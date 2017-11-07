//
//  LoginViewController.swift
//  MyVK
//
//  Created by itisioslab on 07.11.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var emailUser = ""
    var passwordUser = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pressedButtonComeIn(_ sender: Any) {
        guard checkInputData() == true else {return}
        guard checkUser() == true else {return}
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! NewViewController
        vc.userEmail = emailUser
        present(vc, animated: true, completion: nil)
    }
    
    func checkInputData() -> Bool {
        var check = true
        if let email = emailTextField.text, email.characters.contains("@") {
            emailUser = email
            emailTextField.setClearBorder()
        } else {
            check = false
            emailTextField.setRedBorder()
        }
        
        if let password = passwordTextField.text, !password.isEmpty {
            passwordUser = password
            passwordTextField.setClearBorder()
        } else {
            check = false
            passwordTextField.setRedBorder()
        }
        return check
    }
    
    func checkUser() -> Bool{
        let check = UserRepository.instance.checkData(email: emailUser, password: passwordUser)
        return check
    }
    
}
