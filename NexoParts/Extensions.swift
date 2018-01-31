//
//  Extensions.swift
//  NexoParts
//
//  Created by Creativeitem on 5/29/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

extension UINavigationController {
  
  open override var preferredStatusBarStyle: UIStatusBarStyle {
    return topViewController?.preferredStatusBarStyle ?? .default
  }
  
}
