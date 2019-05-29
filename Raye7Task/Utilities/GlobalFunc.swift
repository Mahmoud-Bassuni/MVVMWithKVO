//
//  GlobalFunc.swift
//  Raye7Task
//
//  Created by Bassuni on 5/29/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
import SafariServices
func navigateURL(url : String , viewController : UIViewController)
{
    if #available(iOS 9.0, *) {
        if let url = URL(string: url) {
            let vc = SFSafariViewController(url: url)
            viewController.present(vc, animated: true)
        }
    }
}
