//
//  LoginViewController.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/22/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var loginPresenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.placeholder = "Email"
        password.placeholder = "Password"
        self.loginPresenter = LoginPresenter(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginBttn(_ sender: Any) {
        loginPresenter?.register(email: email.text!, password: password.text!)
    }
}
