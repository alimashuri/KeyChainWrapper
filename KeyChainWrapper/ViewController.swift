//
//  ViewController.swift
//  KeyChainWrapper
//
//  Created by Ali Mashuri on 1/6/17.
//  Copyright © 2017 Ali Mashuri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let credential = AccountCredential()
    
    
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func didTapAddButton(_ sender: AnyObject) {
        let account = Account.init(email: "ali@mashuri.web.id", token: "abc123")
        credential.storeAccount(account as AnyObject)
        showKeychainItem()
    }
    
    @IBAction func didTapGetButton(_ sender: AnyObject) {
//        let account = credential.retrieve() as! Account
//        label.text = account.email
        showKeychainItem()
    }
    
    fileprivate func showKeychainItem() {
        var email = ""
        if credential.isStored() {
            let account = credential.retrieve() as! Account
            email = account.email
        }
        label.text = email
    }
    
    @IBAction func didTapRemoveButton(_ sender: AnyObject) {
        credential.delete()
        showKeychainItem()
    }
}

