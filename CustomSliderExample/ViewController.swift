//
//  ViewController.swift
//  CustomSliderExample
//
//  Created by duy on 11/7/18.
//  Copyright © 2018 duy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var rangeSilder: RangeSliderView!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeSilder = RangeSliderView(frame: CGRect.zero)
//        rangeSilder.backgroundColor = UIColor.red;
        
        view.addSubview(rangeSilder)
        
        
        let margin: CGFloat = 20.0;

        rangeSilder.translatesAutoresizingMaskIntoConstraints = false;
        rangeSilder.heightAnchor.constraint(equalToConstant: 31).isActive = true;
        rangeSilder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin).isActive = true;
        rangeSilder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin).isActive = true;
        rangeSilder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin).isActive = true;
        
        rangeSilder.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rangeSilder.updateLayerFrames();
    }
    
    @objc func rangeSliderValueChanged(_ sender: RangeSliderView){
        print("rangeSliderValueChanged")
    }


}

