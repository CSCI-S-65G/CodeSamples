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
        
        var twoDim = TwoDimensional(columns: -5, rows: -10)
        print(twoDim.prettyPrint(twoDim.lifeGrid))
        
        twoDim = TwoDimensional(columns: 5, rows: 10)
        print(twoDim.prettyPrint(twoDim.lifeGrid))
        
//        twoDim.neighborsOf(CellCoordinates(column: 0, row: 0))
//        twoDim.neighborsOf(CellCoordinates(column: 1, row: 1))
        let target = CellCoordinates(column: 1, row: 0)
        let census = twoDim.neighborCensusOf(target,
                                             in: twoDim.lifeGrid)
        print ("Census: \(census) of target <\(target)>")
        print ("Full Census: (\(twoDim.censusOf(twoDim.lifeGrid)))")
        
        let targetValue = twoDim.lifeGrid[target.row][target.column]
        let cellState = CellState(cell: targetValue,
                                  neighborCount: census)
        print ("cellState <\(cellState)> for targetValue (\(targetValue)) -> (\((cellState.isDead ? "Dead" : "Alive")))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

