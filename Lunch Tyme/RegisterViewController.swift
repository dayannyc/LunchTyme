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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.placeholder = "Email"
        password.placeholder = "Password"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerBttn(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { user, error in
            if error == nil {
                // if user account created successfully, sign them in
                Auth.auth().signIn(withEmail: self.email.text!,
                                   password: self.password.text!)
                if (error == nil) {
                    // signed in successfully so take user to restaurant list
                    print("User has successfully logged in")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sVC = storyboard.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                    self.present(sVC!, animated: true, completion: nil)
                } else {
                    print("Error occured while logging in")
                }
            }
            // else add message to user stating they didn't
            // register correctly
        }
    }
}
