//
//  TwoDimensional.swift
//  TwoDimensionalSampleCode
//
//  Created by Jp LaFond on 7/2/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import Foundation

/// LifeGrid
typealias LifeGrid = [[Int]]

/**
 This class will create a two dimensional Int array and instantiate it
 with random values.
 */
class TwoDimensional {
    let columnsMax : Int
    let rowsMax : Int
    var twoDimensionalArray : LifeGrid
    
    /**
     Initialize the two-dimensional array defined in this class.
     
     - Parameter columnsMax: non-zero maximum
     - Parameter rowsMax: non-zero maximum
     */
    init(columns: Int, rows: Int) {
        // Validate the inputs
        if (columns < 0) {
            columnsMax = 0
        } else {
            columnsMax = columns
        }
        
        if (rows < 0) {
            rowsMax = 0
        } else {
            rowsMax = rows
        }
        
        // Instantiate the array
        twoDimensionalArray = Array(count: rowsMax,
                                    repeatedValue: Array(count: columnsMax,
                                        repeatedValue: 0))
        // Set it to a random value
        for col in 0..<columnsMax {
            for row in 0..<rowsMax {
                twoDimensionalArray[row][col] = Int(arc4random_uniform(3))
            }
        }
    }
    
    /**
     Pretty prints a life grid
     
     - Parameter lifeGrid: to print
     
     - Returns: a pretty printable string
     */
    func prettyPrint(lifeGrid: LifeGrid) -> String {
        let derivedColumns = lifeGrid.count
        let derivedRows : Int
        
        if (derivedColumns == 0) {
            derivedRows = 0
        } else if let firstElement = lifeGrid.first {
            derivedRows = firstElement.count
        } else {
            // Should never happen, but belt and suspendering to catch any logical failures.
            print("lifeGrid: <\(lifeGrid)>")
            derivedRows = 0
        }
        
        var prettyPrintLog = "[\(derivedColumns)x\(derivedRows)]\n"
        for intArray in lifeGrid {
            for intValue in intArray {
                prettyPrintLog += "\(intValue) "
            }
            prettyPrintLog += "\n"
        }
        
        return prettyPrintLog
    }
}