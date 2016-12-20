//
//  NumbersFactory.swift
//  NumbersFlow
//
//  Created by Ionut Apostol on 08/12/16.
//  Copyright © 2016 Catchy Games. All rights reserved.
//

import Foundation

public class NumbersFactory {
    
    private var currentNumbers : [Int] = []
    
    private var nextNumber : Int = 1
    
    private var start : Int = 1
    
    private var limit : Int = Constants.gameIndex * Constants.gameIndex
    
    
    public func reset(){
        currentNumbers = []
        nextNumber = 1
        start = 1
        limit = Constants.gameIndex * Constants.gameIndex
    }
    
    private func getNumbers(start : Int, limit : Int) -> [Int] {
        var numbers : [Int] = []
        
        for number in start...limit {
            numbers.append(number)
        }
        
        return numbers
    }
    
    public func getScore() -> Int {
        return  nextNumber - 1
    }
    
    public func getLastNumber() -> Int {
        return nextNumber
    }
    
    public func getNextNumber() -> Int {
        if(currentNumbers.isEmpty){
            updateCurrentList()
        }
        
        let number = currentNumbers[0]
        currentNumbers.remove(at: 0)
        
        return number
    }
    
    public func validateNumber(number: Int) -> Bool {
        if(number == nextNumber){
            nextNumber += 1
            return true
        }
        else {
            return false
        }
    }
    
    private func updateCurrentList(){
        var orderedNumbers = getNumbers(start: start, limit: limit)
        start += Constants.gameIndex * Constants.gameIndex
        limit += Constants.gameIndex * Constants.gameIndex
        
        while !orderedNumbers.isEmpty {
            var randomIndex = 0
            
            if(orderedNumbers.count > 1){
                randomIndex = Int(arc4random_uniform(UInt32(orderedNumbers.count)))
            }
            else
            {
                randomIndex = 0
            }
            
            let number = orderedNumbers[randomIndex]
            currentNumbers.append(number)
            orderedNumbers.remove(at: randomIndex)
        }
    }
    
}
