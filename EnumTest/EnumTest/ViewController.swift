//
//  ViewController.swift
//  EnumTest
//
//  Created by Jp LaFond on 7/5/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UIElements
    @IBOutlet var colorSquare : UIView!
    
    // Switching color
    var currentColor = Color.red

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colorSquare.backgroundColor = currentColor.color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UIElement Actions
    @IBAction func colorCyclePressed(button: UIButton) {
        // Cycle the color
        currentColor = currentColor.nextColor()
        
        // Change the color
        colorSquare.backgroundColor = currentColor.color
    }

}

