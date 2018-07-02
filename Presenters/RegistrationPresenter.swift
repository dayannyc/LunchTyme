//
//  RegistrationPresenter.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/26/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import Foundation
import FirebaseAuth

class RegistrationPresenter {
    
    private var registrationView: RegisterViewController?
    var error = ""
    
    init(view: RegisterViewController) {
        registrationView =  view
    }
    
    func register(email: String, password: String) {
        if(password.isEmpty) {
            self.error = "Password field cannot be left blank"
        }
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil {
                // if user account created successfully, sign them in
                Auth.auth().signIn(withEmail: email, password: password)
                if (error == nil) {
                    // signed in successfully so take user to restaurant list
                    print("User has successfully logged in")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sVC = storyboard.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                    self.registrationView?.present(sVC!, animated: true, completion: nil)
                } else {
                    // error when signing in
                    self.addAlert(errorMsg: (error?.localizedDescription)!)
                }
            } else {
                // error when signing up
                self.addAlert(errorMsg: (error?.localizedDescription)!)
            }
        }
    }
    
    // adds alert controller displaying error from firebase
    func addAlert(errorMsg: String) {
        registrationView?.alertController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        registrationView?.alertController!.addAction(OKAction)
        registrationView?.present((registrationView?.alertController)!, animated: true, completion:nil)
    }
}
