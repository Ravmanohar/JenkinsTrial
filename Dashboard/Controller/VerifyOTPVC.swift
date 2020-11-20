//
//  VerifyOTPVC.swift
//  Dashboard
//
//  Created by Xanthus Software Solutions on 30/07/20.
//  Copyright © 2020 Xanthus Software Solutions. All rights reserved.
//

import UIKit

class VerifyOTPVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }

    //MARK: Button Actions
    //====================
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
