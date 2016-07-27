//
//  SecondViewController.swift
//  SingletonTestProject
//
//  Created by Jp LaFond on 7/26/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet var textView: UITextView!
    
    var countdown = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(notificationReceived), name: EngineNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Methods
    @objc private func notificationReceived(notification: NSNotification) {
        countdown -= 1
        print("Countdown: [\(countdown)]")
        
        if let grid = notification.userInfo![GridKey] as? GridProtocol {
            textView.text = textView.text + "\n" + grid.description
        }
        if let date = notification.userInfo![FireDateKey] as? NSDate {
            textView.text = textView.text + " : " + date.description
        }
        
        if countdown < 0 {
            // Reset the positions
            let positions = [(row: 1, col: 4),
                             (row: 2, col: 4),
                             (row: 3, col: 4),
                             (row: 4, col: 2),
                             (row: 4, col: 3),
                             (row: 4, col: 4)]
            if let grid = Engine.sharedInstance.grid as? GridBase {
                grid.positions = positions
            }
        }
    }
    
}

