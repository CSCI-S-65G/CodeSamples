//
//  Engine.swift
//  SingletonTestProject
//
//  Created by Jp LaFond on 7/26/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import Foundation

// Public constants
let EngineNotification = "EngineNotification"
let GridKey = "grid"
let FireDateKey = "fireDate"

class Engine : EngineProtocol {
    var grid: GridProtocol
    var rows: Int {
        didSet {
            // Validate
            if rows < 0 {
                rows = 0
            }
            // Reset
            grid = GridBase(rows: rows, cols: cols)
        }
    }
    var cols: Int {
        didSet {
            // Validate
            if cols < 0 {
                cols = 0
            }
            // Reset
            grid = GridBase(rows: rows, cols: cols)
        }
    }
    var refreshRate: Double = 0 {
        didSet {
            // clear it
            refreshTimer?.invalidate()

            if refreshRate > 0 {
                refreshTimer = NSTimer
                    .scheduledTimerWithTimeInterval(refreshRate,
                                                    target: self,
                                                    selector: #selector(timerTriggered),
                                                    userInfo: nil,
                                                    repeats: true)
            }
        }
    }
    var runTimer: Bool {
        didSet {
            refreshTimer?.invalidate()

            // Set back up the timer
            // Usually, I prefer helper functions, when there's any
            // repeated code like this...
            if runTimer && refreshRate > 0 {
                refreshTimer = NSTimer
                    .scheduledTimerWithTimeInterval(refreshRate,
                                                    target: self,
                                                    selector: #selector(timerTriggered),
                                                    userInfo: nil,
                                                    repeats: true)
            }
        }
    }

    private var refreshTimer: NSTimer?
    
    static let sharedInstance : EngineProtocol = Engine(rows: 10, cols: 10)
    
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
        
        // Set up
        self.rows = maxRows
        self.cols = maxCols
        
        grid = GridBase(rows: maxRows, cols: maxCols)
        
        runTimer = false
    }
    
    func notifyObservers() {
        NSNotificationCenter.defaultCenter().postNotificationName(EngineNotification,
                                                                  object: nil,
                                                                  userInfo: [FireDateKey: refreshTimer!.fireDate,
                                                                    GridKey: grid as! GridBase])
    }
    
    // MARK: - Private Helper Methods
    @objc private func timerTriggered(timer: NSTimer) {
        refreshTimer = timer
        
        notifyObservers()
    }
}

// Useful extra functionality
extension Engine: CustomStringConvertible {
    var description: String {
        let sharedPointer = unsafeAddressOf(Engine.sharedInstance as! Engine)
        let selfPointer = unsafeAddressOf(self)
        let tag = (sharedPointer == selfPointer) ? "[SINGLETON] " : ""
        let refreshString = String(format: "%0.2f", refreshRate)
        let timer = runTimer ? "On \(refreshString)" : "Off"
        
        return tag + "[\(rows) x \(cols)] T (\(timer)) <\(refreshTimer)>"
    }
}