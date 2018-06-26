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
    
    init(view: LoginViewController) {
        loginView =  view
    }
    
    func register(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (error == nil) {
                // successfully signed in so take user to the restaurant list
                print("User has successfully logged in")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let sVC = storyboard.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                self.loginView?.present(sVC!, animated: true, completion: nil)
            } else {
                print("Error occured while logging in")
            }
        }
    }
}
