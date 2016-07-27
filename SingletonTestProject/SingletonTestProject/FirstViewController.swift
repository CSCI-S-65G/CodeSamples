//
//  FirstViewController.swift
//  SingletonTestProject
//
//  Created by Jp LaFond on 7/26/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    private let singletonSwitchTag = 0x0FF // 255
    private let refreshSwitchTag = 0xACE // 2766
    
    private var engine : EngineProtocol = Engine.sharedInstance
    
    // MARK: - UI Elements
    @IBOutlet var rowStepper: UIStepper!
    @IBOutlet var colStepper: UIStepper!
    @IBOutlet var rowTextField: UITextField!
    @IBOutlet var colTextField: UITextField!
    
    @IBOutlet var refreshSlider: UISlider!
    @IBOutlet var refreshLabel: UILabel!
    
    @IBOutlet var refreshSwitch: UISwitch!
    
    @IBAction func stepperChanged(stepper: UIStepper) {
        // Validation isn't needed because the stepper can only go
        // between 0...100
        if stepper == rowStepper {
            engine.rows = Int(stepper.value)
        } else {
            engine.cols = Int(stepper.value)
        }
        refreshUI(engine)
    }
    
    @IBAction func sliderChanged(slider: UISlider) {
        // Validation isn't needed because slider can only go from
        // 0.1...10
        engine.refreshRate = Double(slider.value)
        refreshUI(engine)
    }
    
    @IBAction func switchFlipped(switcher: UISwitch) {
        if switcher.tag == singletonSwitchTag {
            if switcher.on {
                engine = Engine.sharedInstance
            } else {
                let rows = Int(rowStepper.value)
                let cols = Int(colStepper.value)
                engine = Engine(rows: rows, cols: cols)
            }
        } else if switcher.tag == refreshSwitchTag {
            engine.runTimer = switcher.on
        }
        refreshUI(engine)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI(engine)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Methods
    private func refreshUI(engine: EngineProtocol) {
        // Populate the values from the engine
        rowStepper.value = Double(engine.rows)
        colStepper.value = Double(engine.cols)
        
        rowTextField.text = engine.rows.description
        colTextField.text = engine.cols.description
        
        refreshSlider.value = Float(engine.refreshRate)
        refreshSwitch.on = engine.runTimer
        
        let refreshString = String(format: "%0.2f HZ",
                                   engine.refreshRate)
        refreshLabel.text = refreshString +
            (engine.runTimer == false ? " OFF" : "")
    }

}

