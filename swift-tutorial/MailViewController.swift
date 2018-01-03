//
//  FirstViewController.swift
//  swift-tutorial
//
//  Created by ParthSoni on 01/01/18.
//  Copyright © 2018 ParthSoni. All rights reserved.
//

import UIKit

class MailViewController: UIViewController {
    
    @IBOutlet var logInButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var dataSource: MessagesDataSource?
    
    let service = OutlookService.shared()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 90;
        tableView.rowHeight = UITableViewAutomaticDimension
        setLogInState(loggedIn: service.isLoggedIn)
        if (service.isLoggedIn) {
            loadUserData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logInButtonTapped(sender: AnyObject) {
            if (service.isLoggedIn) {
                // Logout
                service.logout()
                setLogInState(loggedIn: false)
            } else {
                // Login
                service.login(from: self) {
                    error in
                    if let unwrappedError = error {
                        NSLog("Error logging in: \(unwrappedError)")
                    } else {
                        NSLog("Successfully logged in.")
                        self.setLogInState(loggedIn: true)
                        self.loadUserData()
                    }
                }
            }
    }
    
    func loadUserData() {
        service.getUserEmail() {
            email in
            if let unwrappedEmail = email {
                NSLog("Hello \(unwrappedEmail)")
                
                self.service.getInboxMessages() {
                    messages in
                    if let unwrappedMessages = messages {
                        self.dataSource = MessagesDataSource(messages: unwrappedMessages["value"].arrayValue)
                        self.tableView.dataSource = self.dataSource
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func setLogInState(loggedIn: Bool) {
        if (loggedIn) {
            logInButton.setTitle("Log Out", for: UIControlState.normal)
        }
        else {
            logInButton.setTitle("Log In", for: UIControlState.normal)
        }
    }

}

