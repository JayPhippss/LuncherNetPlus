//
//  LoginViewController.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/18/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var passwordBox: UITextField!
    @IBOutlet weak var infoLbl: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClick(_ sender: Any) {
        logIn()
    }
    
    func logIn () {
        guard let userEmail = emailBox.text else { return }
        guard let userPass = passwordBox.text else { return }

        if emailBox.text == nil || passwordBox.text == nil {
            print("Fill out required text fields")
            self.infoLbl.text = "Fill out all text fields or create an account"
        } else  {
            Auth.auth().signIn(withEmail: userEmail, password: userPass) { (user, error) in
                if error == nil && user != nil {
                    self.infoLbl.text = ("You have successfully logged in!")
                    self.navigationController?.popViewController(animated: false)
                } else {
                    print("Error Logging in: \(error!.localizedDescription)")
                    let alert = UIAlertController(title: "Error Logging in!", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }

        }
    }

}
