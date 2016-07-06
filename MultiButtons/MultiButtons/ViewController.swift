//
//  ViewController.swift
//  MultiButtons
//
//  Created by Jp LaFond on 7/6/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: UIButton) {
        print("Button \(sender.tag) pressed")
    }
    
}

