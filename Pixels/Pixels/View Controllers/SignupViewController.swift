//
//  SignupViewController.swift
//  Pixels
//
//  Created by brian vilchez on 3/3/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit
import FirebaseAuth
class SignupViewController: UIViewController {

    
    //MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        signupUser()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - helper methods
    private func signupUser() {
        guard let email = emailTextField.text, !email.isEmpty,
        let password = passwordTextField.text, !password.isEmpty,
        let name = nameTextField.text, !name.isEmpty else {return }
        Auth.auth().createUser(withEmail: email, password: password) { ( result, error) in
            if let error = error {
                NSLog("failed to register user: \(error)")
                self.showAlert()
            } else {
                guard let memoriesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemoriesVC") as? MemoriesViewController else { return }
                        memoriesVC.modalPresentationStyle = .fullScreen
                let nameChange = Auth.auth().currentUser?.createProfileChangeRequest()
                nameChange?.displayName = name
                nameChange?.commitChanges(completion: { (error) in
                    if let error = error as NSError? {
                        NSLog("failed to update user's name: \(error)")
                    }
                })
                        self.present(memoriesVC, animated: true, completion: nil)
                                  
            }
        }
    }
    private func showAlert() {
        let alertVC = UIAlertController(title: "oops", message: "Oh no failed to create account", preferredStyle: .alert)
        let `return` = UIAlertAction(title: "return", style: .default, handler: nil)
        alertVC.addAction(`return`)
        present(alertVC, animated: true, completion: nil)
    }
    
}
