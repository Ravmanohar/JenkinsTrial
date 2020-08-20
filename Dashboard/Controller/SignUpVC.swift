//
//  SignUpVC.swift
//  Dashboard
//
//  Created by Xanthus Software Solutions on 30/07/20.
//  Copyright © 2020 Xanthus Software Solutions. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mobNoTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }

    //MARK: Button Actions
    //====================
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
