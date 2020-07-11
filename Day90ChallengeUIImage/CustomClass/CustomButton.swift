//
//  CustomButton.swift
//  Day90ChallengeUIImage
//
//  Created by Ceboolion on 11/07/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor.lightGray.cgColor
        titleEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        titleLabel?.adjustsFontSizeToFitWidth = true
        tintColor = .white
        titleLabel?.minimumScaleFactor = 30
    }
}
