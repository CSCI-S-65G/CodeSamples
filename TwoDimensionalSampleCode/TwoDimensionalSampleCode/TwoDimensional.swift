//
//  TwoDimensional.swift
//  TwoDimensionalSampleCode
//
//  Created by Jp LaFond on 7/2/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import Foundation

// MARK: - typealias definitions
/// A useful feature of Swift that lets you convert a known class to an alias to minimize typing. This is especially useful in closure definitions.
typealias LifeGrid = [[Int]]

typealias CellCoordinates = (row: Int, column: Int)

// MARK: - CellState definition
/**
 * CellState
 * 
 * Note:
 *  Rules of _*Conway's Game of Life*_:
 *   * Dead cells:
 *   *   3 interesting neighbors: Reproduction (Alive)
 *   *   Otherwise, stays Dead
 ***
 *   * Living cells (interesting):
 *   *   <2 interesting neighbors: Starvation (Dead)
 *   *   2-3 interesting neighbors: Alive
 *   *   >3 interesting neighbors: Overcrowding (Dead)
 */
enum CellState {
    case dead
    case reproduction
    
    case starvation
    case alive
    case overcrowding
    
    /// Dynamic variable to clarify death
    var isDead: Bool {
        switch (self) {
            case .dead,
                 .starvation,
                 .overcrowding:
            return true
            case .reproduction,
                 .alive:
            return false
        }
    }
    
    /**
     * Variant initializer to encorporate the rules of _*Conway's Game of Life*_
     */
    init(cell: Int, neighborCount: Int) {
        let isAlive = cell == TwoDimensional.interestingValue
        
        if isAlive == false {
            // Dead path
            if neighborCount == 3 {
                self = .reproduction
            } else {
                self = .dead
            }
        } else {
            // Alive path
            if neighborCount < 2 {
                self = .starvation
            } else if neighborCount == 2 || neighborCount == 3 {
                self = .alive
            } else {
                self = .overcrowding
            }
        }
    }
}

/**
 This class will create a two dimensional Int array and instantiate it
 with random values.
 */
class TwoDimensional {
    // MARK: - Properties
    let columnsMax : Int
    let rowsMax : Int
    var lifeGrid : LifeGrid
    
    private static let interestingValue = 1
    
    // MARK: - Life cycle methods
    /**
     Initialize the two-dimensional array defined in this class.
     
     If the values are negative, they'll be normalized to zero values.
     
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
        lifeGrid = Array(count: rowsMax,
                                    repeatedValue: Array(count: columnsMax,
                                        repeatedValue: 0))
        // Set it to a random value
        for col in 0..<columnsMax {
            for row in 0..<rowsMax {
                lifeGrid[row][col] = Int(arc4random_uniform(3))
            }
        }
    }
    
    // MARK: - Conway Game of Life Methods
    // This illustrates code samples within comments
    /**
     * Calculate the eight neighbors of a known coordinate
     * 
     *   ````
     *   X X X O O -- Simple Case
     *   X T X O O
     *   X X X O O
     *   O O O O O
     * 
     *   T X O O X -- Wrapped case
     *   X X O O X
     *   O O O O O
     *   X X O O X
     *   ````
     *
     * - Parameter targetCoordinate: of the target cell
     *
     * - Returns: an array of the targets neighbors; nil, if the coordinates are invalid
     */
    func neighborsOf(targetCoordinate: CellCoordinates) -> [CellCoordinates]? {

        // Validate the input
        if targetCoordinate.row < 0 ||
            targetCoordinate.row >= rowsMax ||
            targetCoordinate.column < 0 ||
            targetCoordinate.column >= columnsMax {
            print ("target (r: (\(targetCoordinate.row)) c: (\(targetCoordinate.column)) invalid")
            return nil
        }
        
        // Loop through the grid and normalize the values
        let rowMin = targetCoordinate.row - 1
        let rowMax = targetCoordinate.row + 1
        let colMin = targetCoordinate.column - 1
        let colMax = targetCoordinate.column + 1
        
        var neighbors = [CellCoordinates]()
        
        for row in rowMin ... rowMax {
            for col in colMin ... colMax {
                var tmpRow = row % rowsMax
                var tmpCol = col % columnsMax
                
                if tmpRow < 0 {
                    tmpRow = (tmpRow + rowsMax) % rowsMax
                }
                if tmpCol < 0 {
                    tmpCol = (tmpCol + columnsMax) % columnsMax
                }
                
                if tmpRow != targetCoordinate.row ||
                    tmpCol != targetCoordinate.column {
                    neighbors.append(CellCoordinates(row: tmpRow, column: tmpCol))
                }
                
            }
        }
//        print ("Neighbors: <\(neighbors)> of " +
//            "<R: \(targetCoordinate.row), " +
//            "C: \(targetCoordinate.column)>")
        return neighbors
    }
    
    /**
     * Census of the neighbors of a known target
     * 
     * - Parameter targetCoordinate: of the cell
     * - Parameter lifeGrid: to evaluate
     * 
     * - Returns: the number of interesting neighbors; 0 for a invalid targetCoordinate
     */
    func neighborCensusOf(targetCoordinate: CellCoordinates,
        in lifeGrid: LifeGrid) -> Int {
        // Validate the neighbors list, as it doesn't return,
        // if the CellCoordinates are invalid
        guard let neighbors = neighborsOf(targetCoordinate) else {
            print ("No neighbors found for (r \(targetCoordinate.row)) c (\(targetCoordinate.column))")
            return 0
        }

        var neighborCensus = 0
        for neighbor in neighbors {
            if lifeGrid[neighbor.row][neighbor.column] == TwoDimensional.interestingValue {
                neighborCensus += 1
            }
        }
    
        return neighborCensus
    }
    
    /**
     A count of all interesting cells in the lifeGrid
     
     - Parameter lifeGrid: to count
     
     - Returns: count of interesting cells
     */
    func censusOf(lifeGrid: LifeGrid) -> Int {
        var census = 0
        
        for intArray in lifeGrid {
            for intValue in intArray {
                if intValue == TwoDimensional.interestingValue {
                    census += 1
                }
            }
        }
        
        return census
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
//                prettyPrintLog += "\(intValue) "
                prettyPrintLog += (intValue == TwoDimensional.interestingValue) ? "X " : "O "
            }
            prettyPrintLog += "\n"
        }
        
        return prettyPrintLog
    }
    
    /**
     * Step method to generate the next iteration of the
     * lifeGrid
     */
    func step(lifeGrid: LifeGrid) -> LifeGrid {
        // Validate
        if lifeGrid.isEmpty {
            print ("lifegrid is empty")
            prettyPrint(lifeGrid)
            return LifeGrid()
        }
        // Create the second lifegrid to write into
        var nextLifeGrid = Array(count: rowsMax,
                                 repeatedValue: Array(count: columnsMax,
                                    repeatedValue: 0))
        
        // Walk the current grid and populate the new one
        for row in 0..<rowsMax {
            for col in 0..<columnsMax {
                // Get the current cell
                let cellStatus = lifeGrid[row][col]
                // Get the neighbor census
                let neighborCensus = neighborCensusOf(CellCoordinates(row: row, column: col), in: lifeGrid)
                // What's the next cell state going to be
                let nextCellState = CellState(cell: cellStatus, neighborCount: neighborCensus)
                // Generate the next value interestingValue == alive; otherwise, 0
                nextLifeGrid[row][col] = (nextCellState.isDead ? 0 : TwoDimensional.interestingValue)
            }
        }
        return nextLifeGrid
    }
}