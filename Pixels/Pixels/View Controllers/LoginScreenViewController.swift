//
//  LoginScreenViewController.swift
//  Pixels
//
//  Created by brian vilchez on 3/3/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginScreenViewController: UIViewController {
    
    //MARK: - properties
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    private var pixelController = PixelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        loginSegue()
    }
    
    @IBAction func singupButtonPressed(_ sender: UIButton) {
        signupSegue()
    }
    
    
    //MARK: - helper methods
    
    private func loginSegue() {
        
        //checking to make sure textfields arent empty.
        guard let email = emailTextfield.text, !email.isEmpty,
            let password = passwordTextfield.text, !password.isEmpty else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { ( result, error) in
            if let error = error {
                self.showAlert()
                NSLog("error logging in: \(error)")
            } else {
                DispatchQueue.main.async {
                    guard let memoriesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemoriesVC") as? MemoriesViewController else { return }
                    memoriesVC.modalPresentationStyle = .fullScreen
                    self.present(memoriesVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func showAlert() {
        let alertVC = UIAlertController(title: "oops", message: "something is wrong! failed to log in", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(ok)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    private func signupSegue() {
        
        guard let signupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupVC") as? SignupViewController else { return }
        signupVC.modalPresentationStyle = .fullScreen
        self.present(signupVC, animated: true, completion: nil)
    }
    
    @IBAction func unwindToLoginVC(_ unwindSegue: UIStoryboardSegue) {
        pixelController.signout()
        passwordTextfield.text = ""
        emailTextfield.text = ""
        do {
            try Auth.auth().signOut()
        } catch {
            NSLog("failed to logout user: \(error)")
        }
        
    }
    
}
