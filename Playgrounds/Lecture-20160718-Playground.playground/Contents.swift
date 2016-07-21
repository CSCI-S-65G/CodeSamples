//: Playground - noun: a place where people can play

import UIKit

let fruits = ["apple", "banana", "cherry", "date", "eggplant", "fig", "grape"]

// Count the elements that have "a" in it
fruits.reduce(0) {
    // We don't even need a return at the front, because the convention is that the last thing in a closure is returned
    $1.containsString("a") ? $0 + 1 : $0
}

// Equivalent for-loop
var count = 0
for fruit in fruits {
    if fruit.containsString("a") {
        count += 1
    }
}
count

// Create a new array of reversed strings
let newList = fruits.map{
//    String($0.characters.reverse())
    fruit in
        String(fruit.characters.reverse())
}
newList

var reversedFruit = [String]()
for fruit in fruits {
    reversedFruit.append(String(fruit.characters.reverse()))
}
reversedFruit

// Reverse the order in the array
fruits.sort{
    $0 > $1
}
var reverseFruits = [String]()
for fruit in fruits {
    if reverseFruits.isEmpty {
        reverseFruits.append(fruit)
    } else if reverseFruits.first < fruit {
        reverseFruits.insert(fruit, atIndex: 0)
    }
}
reverseFruits

// Create a new array specific elements
fruits.filter{
    $0.containsString("a")
}
var specificFruits = [String]()
for fruit in fruits {
    if fruit.containsString("a") {
        specificFruits.append(fruit)
    }
}
specificFruits

// A negative number modulus is still negative
-1 % 5
// That negative number added to the max and modulus is wrapped within bounds
(-1 + 5) % 5

