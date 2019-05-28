//
//  Extention+UIView.swift
//  Raye7Task
//
//  Created by Bassuni on 5/28/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
import UIKit
extension UIView
{
    func card()  {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        self.clipsToBounds = true
    }
}
