//
//  EngineProtocol.swift
//  SingletonTestProject
//
//  Created by Jp LaFond on 7/26/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import Foundation

// Modified EngineProtocol
protocol EngineProtocol {
    var grid: GridProtocol {get}
    
    var rows: Int {get set}
    var cols: Int {get set}
    
    var refreshRate: Double {get set}
    
    var runTimer: Bool {get set}
    
    init(rows: Int, cols: Int)
    
    func notifyObservers()
}

// Define the default functionality
extension EngineProtocol {
    var refreshRate: Double {
        return 0
    }
}