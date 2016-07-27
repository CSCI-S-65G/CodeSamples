//
//  GridProtocol.swift
//  SingletonTestProject
//
//  Created by Jp LaFond on 7/26/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import Foundation

// Modified Grid API

typealias Position = (row: Int, col: Int)

protocol GridProtocol : CustomStringConvertible {
    var rows: Int {get}
    var cols: Int {get}
    
    init(rows: Int, cols: Int)
    
    subscript(row: Int, col: Int) -> Bool {get set}
}

protocol PositionsProtocol {
    var positions: [Position] {get set}
}