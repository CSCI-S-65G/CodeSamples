//: Playground - noun: a place where people can play

import UIKit

class PrintSimpleClass {
    let property : String
    
    init(name : String = "Default") {
        print ("PrintSimpleClass is initialized: \(NSDate())")
        property = name
    }
}

class SimpleClass {
    let row : Int
    let col : Int
    
    private (set) var otherString : String {
        // Observers
        willSet(newValue) {
            print ("willSet otherString: (\(otherString)) -> (\(newValue))")
        }
        
        didSet {
            print("didSet otherString: (\(otherString))")
        }
    }
    
    // Lazy variables cannot have observers
    lazy var susan = PrintSimpleClass()
    
    init(rows: Int, cols: Int) {
        print ("SimpleClass is initialized: \(NSDate())")
        row = rows
        col = cols
        
        print ("Set up: (\(row))x(\(col))")
        
        // This doesn't trigger the observers
        otherString = "Nonsense"
    }
    
}

let mySimple = SimpleClass(rows: 5, cols: 10)
mySimple.otherString

mySimple.otherString = "Frog"

mySimple.susan

