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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.placeholder = "Email"
        password.placeholder = "Password"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginBttn(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if (error == nil) {
                // successfully signed in so take user to the restaurant list
                print("User has successfully logged in")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let sVC = storyboard.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                self.present(sVC!, animated: true, completion: nil)
            } else {
                print("Error occured while logging in")
            }
        }
    }
}
