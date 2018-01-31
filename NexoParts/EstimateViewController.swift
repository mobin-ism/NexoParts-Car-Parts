//
//  EstimateViewController.swift
//  NexoParts
//
//  Created by Creativeitem on 5/29/17.
//  Copyright © 2017 Creativeitem. All rights reserved.
//

import UIKit

class EstimateViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = BG_COLOR
    setupNavBar()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  func setupNavBar() {
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.barTintColor = DEEP_BLUE_COLOR
    navigationController?.navigationBar.tintColor = UIColor.white
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    self.title = "Cotizaciones"
    // removes the back title from back button of navigation bar
    let barAppearace = UIBarButtonItem.appearance()
    barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}
