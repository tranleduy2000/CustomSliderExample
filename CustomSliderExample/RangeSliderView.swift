//
//  RangeSlider.swift
//  CustomSliderExample
//
//  Created by duy on 11/7/18.
//  Copyright © 2018 duy. All rights reserved.
//

import UIKit
import QuartzCore

//
@IBDesignable class RangeSliderView: UIControl {
    
    // MARK: - Propertise;
    @IBInspectable var minimumValue: CGFloat = 0.0 {
        didSet {
            updateLayerFrames();
        }
    }
    
    @IBInspectable var maximumValue: CGFloat = 1.0 {
        didSet {
            updateLayerFrames();
        }
    }
    @IBInspectable var lowerValue: CGFloat = 0.2 {
        didSet {
            updateLayerFrames();
        }
    }
    @IBInspectable var upperValue: CGFloat = 0.8 {
        didSet {
            updateLayerFrames();
        }
    }
    
    let trackLayer = RangeSliderTrackLayer();
    let lowerThumbLayer = RangeSliderThumbLayer();
    let upperThumbLayer = RangeSliderThumbLayer();
    
    var thumbWidth: CGFloat {
        return bounds.height;
    }
    
    var previousLocation = CGPoint();
    
    
    var trackTintColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay();
        }
    }
    var trackHighlightedColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet{
            trackLayer.setNeedsDisplay();
        }
    }
    var thumbTintColor = UIColor.white {
        didSet {
            lowerThumbLayer.setNeedsDisplay();
            upperThumbLayer.setNeedsDisplay();
        }
    }
    
    var curvaceousness: CGFloat = 1.0 {
        didSet {
            trackLayer.setNeedsDisplay();
            lowerThumbLayer.setNeedsDisplay();
            upperThumbLayer.setNeedsDisplay();
        }
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames();
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        print("init \(frame)")
        
        //init color of all layers, then add it to parent
        trackLayer.rangeSlider = self;
        trackLayer.contentsScale = UIScreen.main.scale;
        layer.addSublayer(trackLayer)
        
        lowerThumbLayer.rangeSlider = self;
        lowerThumbLayer.contentsScale = UIScreen.main.scale;
        layer.addSublayer(lowerThumbLayer);
        
        upperThumbLayer.rangeSlider = self;
        upperThumbLayer.contentsScale = UIScreen.main.scale;
        layer.addSublayer(upperThumbLayer);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLayerFrames(){
        CATransaction.begin();
        CATransaction.setDisableActions(true);
        
        trackLayer.frame = bounds.insetBy(dx: 0, dy: bounds.height / 3);
        trackLayer.setNeedsDisplay();
        
        let lowerThumbCenter = positionForValue(lowerValue);
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2, y: 0.0, width: thumbWidth, height: thumbWidth);
        lowerThumbLayer.setNeedsDisplay();
        
        let upperThumbCenter = positionForValue(upperValue);
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2, y: 0.0, width: thumbWidth, height: thumbWidth);
        upperThumbLayer.setNeedsDisplay();
        
        CATransaction.commit();
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        let contentWidth: CGFloat = bounds.width - thumbWidth;
        let position = contentWidth * (value - minimumValue) / (maximumValue - minimumValue);
        
        // +---------------
        // ^ thumb at start position, need add thumbWidth / 2 to move to center
        return position + thumbWidth / 2;
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self);
        
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true;
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true;
        }
        
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted;
    }
    
    func boundValue(value: CGFloat, toLowerValue lowerValue: CGFloat, upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue);
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self);
        
        let deltaLocation: CGFloat = location.x - previousLocation.x;
        let deltaValue: CGFloat = deltaLocation / (bounds.width - thumbWidth) * (maximumValue - minimumValue);
        
        previousLocation = location;
        
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue;
            lowerValue = boundValue(value: lowerValue, toLowerValue: minimumValue, upperValue: maximumValue);
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue;
            upperValue = boundValue(value: upperValue, toLowerValue: minimumValue, upperValue: maximumValue);
        }
        
        sendActions(for: .valueChanged)
        return true;
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false;
        upperThumbLayer.highlighted = false;
    }
    
    
}
