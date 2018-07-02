//
//  LoginPresenter.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/26/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginPresenter {
    
    private var loginView: LoginViewController?
    var error = ""
    
    init(view: LoginViewController) {
        loginView =  view
    }
    
    func login(email: String, password: String) {
        if email.isEmpty {
            self.error = "Email field cannot be left blank"
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (error == nil) {
                // successfully signed in so take user to the restaurant list
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let sVC = storyboard.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                self.loginView?.present(sVC!, animated: true, completion: nil)
            } else {
                // error signing in
                self.addAlert(errorMsg: (error?.localizedDescription)!)
            }
        }
    }
    
    // adds alert controller displaying error from firebase
    func addAlert(errorMsg: String) {
        loginView?.alertController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        loginView?.alertController!.addAction(OKAction)
        loginView?.present((loginView?.alertController)!, animated: true, completion:nil)
    }
}
