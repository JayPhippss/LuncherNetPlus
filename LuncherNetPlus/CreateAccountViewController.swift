//
//  CreateAccountViewController.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/18/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


class CreateAccountViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var creationInfo: UILabel!
    
    
    @IBAction func createAccount(_ sender: Any) {
        createAccount()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func createAccount() {
        if passwordField.text == "" || usernameField.text == "" || nameField.text == ""{
            
            let fieldsAlert = UIAlertController(title: "Error Creating Account!", message: "Please fill in all the fields.", preferredStyle: .alert)
            fieldsAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(fieldsAlert, animated: true)
            
            //self.creationInfo.text = "Fill In All Fields"
            print("Must fill in all text fields")
        } else {
            Auth.auth().createUser(withEmail: usernameField.text!, password: passwordField.text!) { (user, error) in
                if error == nil  {
                    self.creationInfo.text = "You Have Signed Up"
                    print("You are now signed up")
                
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.nameField.text
                    changeRequest?.commitChanges(completion: { (error) in
                        if error == nil {
                            print("User display name changed")
                            self.navigationController?.popViewController(animated: false)
                            //self.dismiss(animated: false, completion: nil)
                        } else {
                            print("User display name error!")
                        }
                    })
                    
                } else {
                    let creationAlert = UIAlertController(title: "Error Creating Account!", message: error?.localizedDescription, preferredStyle: .alert)
                    creationAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(creationAlert, animated: true)
                    print(error)
                }
            }
        }
        
    }
    
    
}
