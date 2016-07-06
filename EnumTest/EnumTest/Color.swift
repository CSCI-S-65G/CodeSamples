//
//  Color.swift
//  EnumTest
//
//  Created by Jp LaFond on 7/5/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import Foundation
import UIKit

/**
 * Colorful enum
 *
 * * Red
 * * Orange
 * * Yellow
 * * Green
 * * Blue
 * * Violet
 */
enum Color : String {
    case red
    case orange
    case yellow
    case green
    case blue
    case violet
    
    /// Color associated with the enum value
    var color : UIColor {
        switch (self) {
        case .red:
            return UIColor.redColor()
        case .orange:
            return UIColor.orangeColor()
        case .yellow:
            return UIColor.yellowColor()
        case .green:
            return UIColor.greenColor()
        case .blue:
            return UIColor.blueColor()
        case .violet:
            return UIColor.purpleColor()
        }
    }
    
    /// Helper to cycle the colors
    func nextColor() -> Color {
        switch self {
        case .red:
            return .orange
        case .orange:
            return .yellow
        case .yellow:
            return .green
        case .green:
            return .blue
        case .blue:
            return .violet
        case .violet:
            return .red
        }
    }
}