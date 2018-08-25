//
//  ViewController.swift
//  FBLogin
//
//  Created by Carlos Rodolfo Santos on 24/08/2018.
//  Copyright © 2018 Carlos Rodolfo Santos. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var lbStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btnFBLogin = FBSDKLoginButton()
        btnFBLogin.readPermissions = ["public_profile","email"]
        let buttonText = NSAttributedString(string: "your text here")
        btnFBLogin.setAttributedTitle(buttonText, for: .normal)
        btnFBLogin.delegate = self
        btnFBLogin.center = self.view.center
        self.view.addSubview(btnFBLogin)
        
        
        if FBSDKAccessToken.current() != nil {
            self.lbStatus.text = "user logged in"
            FBSDKProfile.loadCurrentProfile { (profile, error) in
                if ((profile) != nil) {
                    print("Hello \(profile?.firstName) \(profile?.lastName)")
                    
                    self.lbStatus.text = profile!.name
                }
            }
        } else {
            self.lbStatus.text = "not logged in"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            self.lbStatus.text = error.localizedDescription
        } else if (result.isCancelled) {
            self.lbStatus.text = "User canceled login"
        } else {
            //OK successful
            
            self.lbStatus.text = "user logged in"
            
            FBSDKProfile.loadCurrentProfile { (profile, error) in
                if ((profile) != nil) {
                    print("Hello \(profile?.firstName) \(profile?.lastName)")
                }
            }
        }
    }

    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        self.lbStatus.text = "User logged out"
    }

}

