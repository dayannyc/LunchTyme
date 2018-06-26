//
//  RegisterViewController.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/22/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var registerPresenter: RegistrationPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.placeholder = "Email"
        password.placeholder = "Password"
        self.registerPresenter = RegistrationPresenter(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerBttn(_ sender: Any) {
        registerPresenter?.register(email: email.text!, password: password.text!)
    }
}
