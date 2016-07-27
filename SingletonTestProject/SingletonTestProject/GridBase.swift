//
//  GridBase.swift
//  SingletonTestProject
//
//  Created by Jp LaFond on 7/26/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import Foundation

class GridBase : GridProtocol {
    // The private (set) means no one outside of this file can set this
    // variable. Sort of a belt and suspenders way of ensuring that the
    // code conforms strongly to the protocol.
    private (set) var rows: Int
    var cols: Int
    
    // Secret grid that's actually doing the work
    private var grid: [Bool]
    
    required init(rows: Int, cols: Int) {
        // Validate
        var maxRows = rows
        var maxCols = cols
        
        if maxRows < 0 {
            maxRows = 0
        }
        if maxCols < 0 {
            maxCols = 0
        }
        grid = Array(count: maxRows * maxCols,
                     repeatedValue: false)
        self.rows = maxRows
        self.cols = maxCols
    }
    
    subscript(row: Int, col: Int) -> Bool {
        get {
            // validate
            assert((0..<rows).contains(row) &&
                   (0..<cols).contains(col),
                   "Subscript [\(row), \(col)] out of range")
            // retrieve
            return grid[(row * cols) + col]
        }
        
        set {
            // validate
            assert((0..<rows).contains(row) &&
                   (0..<cols).contains(col),
                   "Subscript [\(row), \(col)] out of range")
            // assign
            grid[(row * cols) + col] = newValue
        }
    }
    
    // Needed for CustomStringConvertible
    var description: String {
        return "[\(rows) x \(cols)]\n" +
            prettyPrint()
    }
    
    // MARK: - Private Methods
    private func prettyPrint() -> String {
        var prettyString = ""
        for row in 0..<rows {
            prettyString += "     "
            for col in 0..<cols {
                let cellValue = self[row, col]
                prettyString += (cellValue ? "X" : "O") + " "
            }
            prettyString += "\n"
        }
        return prettyString
    }
    
}

extension GridBase : PositionsProtocol {
    // REMEMBER: For your final project, the requirement about for-loops should be replaced with .map, .reduce, .filter, .sort will affect your grades.
    var positions: [Position] {
        get {
            var tmpPositions = [Position]()
            for row in 0..<rows {
                for col in 0..<cols {
                    if self[row, col] {
                        tmpPositions.append((row: row, col: col))
                    }
                }
            }
            return tmpPositions
        }
        set (newPositions){
            var maxRows = 0
            var maxCols = 0
            
            // Walk the positions to find max values
            for (row, col) in newPositions {
                if row > maxRows {
                    maxRows = row
                }
                if col > maxCols {
                    maxCols = col
                }
            }
            rows = maxRows + 1
            cols = maxCols + 1
            
            // Walk the positions to populate
            for (row, col) in newPositions {
                self[row, col] = true
            }
        }
    }
}