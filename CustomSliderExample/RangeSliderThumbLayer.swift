//
//  RangeSliderThumbLayer.swift
//  CustomSliderExample
//
//  Created by duy on 11/7/18.
//  Copyright © 2018 duy. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderThumbLayer: CALayer {
    var highlighted = false {
        didSet {
            setNeedsDisplay();
        }
    }
    weak var rangeSlider: RangeSliderView?
   
    
    override func draw(in context: CGContext) {
        if let slider = rangeSlider {
            let thumbFrame = bounds.insetBy(dx: 2.0, dy: 2.0);
            let cornerRadius: CGFloat = thumbFrame.height * slider.curvaceousness / 2.0;
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius);
            
            // Fill - with a subtle shadow
            let shadowColor = UIColor.gray;
            context.setShadow(offset: CGSize(width: 0, height: 1), blur: 1.0, color: shadowColor.cgColor);
            context.setFillColor(slider.thumbTintColor.cgColor);
            context.addPath(thumbPath.cgPath);
            context.fillPath();
            
            context.setStrokeColor(shadowColor.cgColor);
            context.setLineWidth(0.5);
            context.addPath(thumbPath.cgPath);
            context.strokePath();
            
            if highlighted {
                context.setFillColor(UIColor(white: 0, alpha: 0.1).cgColor);
                context.addPath(thumbPath.cgPath);
                context.fillPath();
            }
        }
    }
}
