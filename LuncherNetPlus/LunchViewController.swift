//
//  LunchViewController.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/18/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import UIKit
import Firebase


class LunchViewController: UIViewController {
    @IBOutlet weak var logoutBrn: UIButton!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var sideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       viewLeading.constant = -175
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed{
            let tranlation = sender.translation(in: self.view).x
            
            if tranlation > 0 { //swipe right
                
                if viewLeading.constant < 20 {
                   self.viewLeading.constant += tranlation
                }
            } else { //swipe left
                
            }
        } else if sender.state == .ended {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
        }
    }
    

