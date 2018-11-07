//
//  RangeSliderTrackLayer.swift
//  CustomSliderExample
//
//  Created by duy on 11/7/18.
//  Copyright © 2018 duy. All rights reserved.
//

import UIKit

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSliderView?;
    
    override func draw(in context: CGContext) {
        if let slider = rangeSlider {
            let cornerRadius: CGFloat = bounds.height * slider.curvaceousness / 2;
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius);
            context.addPath(path.cgPath)
            
            //fill the track
            context.setFillColor(slider.trackTintColor.cgColor);
            context.addPath(path.cgPath)
            context.fillPath();
            
            //fill the highlighted range
            context.setFillColor(slider.trackHighlightedColor.cgColor);
            
            let lowerValuePostion = slider.positionForValue(slider.lowerValue);
            let upperValuePostion = slider.positionForValue(slider.upperValue);
            let rect = CGRect(x: lowerValuePostion, y: 0, width: upperValuePostion - lowerValuePostion, height: bounds.height);
            
            context.fill(rect);
        }
    }
}
