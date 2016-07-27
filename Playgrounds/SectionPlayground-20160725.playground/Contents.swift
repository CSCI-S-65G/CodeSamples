//: Playground - noun: a place where people can play

import UIKit

typealias Position = (row: Int, col: Int)
class SampleClass {
    private var grid = [[Bool]]()
    
    var rows : Int {
        didSet {
            grid = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: false))
        }
    }
    
    var cols : Int {
        didSet {
            grid = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: false))
        }
    }
    
    var myGrid : [Position] {
        get {
            var positions = [Position]()
            
            for row in 0..<rows {
                for col in 0..<cols {
                    if grid[row][col] {
                        positions.append((row: row, col: col))
                    }
                }
            }
            return positions
        }
        
        set(positionArray) {
            // Find max rows & cols
            // Set up a new grid w/ the rows & cols (with everything .Empty)
            // Populate only the positions set
        }
    }
    
    init(row: Int, col: Int) {
        rows = row
        cols = col
        grid = Array(count: row, repeatedValue: Array(count: col, repeatedValue: false))
    }
}

let sc = SampleClass(row: 5, col: 5)
sc.grid[0][1] = true
sc.grid[3][2] = true
sc.myGrid
sc.myGrid = [(9,0), (5, 4), (3,2)]

