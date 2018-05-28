//
//  RoundedButton.swift
//  stoppuhr
//
//  Created by Filip Nikolić on 11.05.18.
//  Copyright © 2018 Filip Nikolić. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
         layer.cornerRadius = frame.size.height/2
    }

}
