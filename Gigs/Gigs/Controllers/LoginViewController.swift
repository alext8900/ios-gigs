//
//  LoginViewController.swift
//  Gigs
//
//  Created by Alex Thompson on 11/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case signIn
}

class LoginViewController: UIViewController {
    
    var gigController: GigController?
    
    var loginType = LoginType.signUp
    
    @IBOutlet weak var signInOrSignUp: UISegmentedControl!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpOutlet.backgroundColor = UIColor(hue: 190/360, saturation: 70/100, brightness: 80/100, alpha: 1.0)
        signUpOutlet.tintColor = .white
        signUpOutlet.layer.cornerRadius = 8.0
        signInOrSignUp.selectedSegmentIndex = 0
        signUpOutlet.setTitle("Sign up", for: .normal)
        // Do any additional setup after loading the view.

    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        guard let gigController = gigController else { return }
        print("HAHA that tickled")
        if let username = usernameField.text,
            !username.isEmpty,
            let password = passwordField.text,
            !password.isEmpty {
            let user = User(username: username, password: password)
            
            if loginType == .signUp {
                gigController.signUp(with: user) { error in
                    if let error = error {
                        print("Error occured during sign up: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Sign up successful", message: "Now please log in", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true) {
                                self.loginType = .signIn
                                
                                self.signInOrSignUp.selectedSegmentIndex = 1
                                self.signUpOutlet.setTitle("Sign in", for: .normal)
                            }
                        }
                    }
                }
            } else {
                gigController.signIn(with: user) { error in
                    if let error = error {
                        print("Error occured during sign in \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            signUpOutlet.setTitle("Sign up", for: .normal)
        } else {
            loginType = .signIn
            signUpOutlet.setTitle("Sign in", for: .normal)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
