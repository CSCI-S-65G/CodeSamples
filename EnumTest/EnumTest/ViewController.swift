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
    @IBOutlet var whiteSquare : UIView!
    
    // Switching color
    var currentColor = Color.red
    
    var isWhiteShowing = false

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
//        currentColor = currentColor.nextColor()
        currentColor.next()
        
        // Change the color
        colorSquare.backgroundColor = currentColor.color
    }
    
    @IBAction func tapped(sender: AnyObject) {
        print("tapped (\(sender))")
    }
    @IBAction func flipColorSquare(button: UIButton) {
        // Add the flip animation
        let fromView : UIView
        let toView : UIView
        
        // Prepare to flip the value
        if isWhiteShowing {
            fromView = whiteSquare
            toView = colorSquare
        } else {
            fromView = colorSquare
            toView = whiteSquare
        }
        
        // Keep track of which is in front
        isWhiteShowing = !isWhiteShowing
        
        UIView.transitionFromView(fromView,
                                  toView: toView,
                                  duration: 0.5,
                                  options:
            [UIViewAnimationOptions.TransitionFlipFromLeft,
                                    .ShowHideTransitionViews],
                                  completion: nil)
    }

    @IBAction func tappedColorSquared(sender: UITapGestureRecognizer) {
        print ("Tapped")
    }
    
}

