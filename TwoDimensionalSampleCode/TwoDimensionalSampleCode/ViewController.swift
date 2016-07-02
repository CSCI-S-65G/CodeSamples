//
//  ViewController.swift
//  TwoDimensionalSampleCode
//
//  Created by Jp LaFond on 7/2/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var twoDim = TwoDimensional(columns: 5, rows: 10)
        print(twoDim.prettyPrint(twoDim.twoDimensionalArray))
        
        twoDim = TwoDimensional(columns: -5, rows: -10)
        print(twoDim.prettyPrint(twoDim.twoDimensionalArray))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

