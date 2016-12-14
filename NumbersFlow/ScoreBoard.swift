//
//  ScoreBoard.swift
//  NumbersFlow
//
//  Created by Ionut Apostol on 13/12/16.
//  Copyright © 2016 Catchy Games. All rights reserved.
//

import Foundation


class ScoreBoard {
    

    public func tryBestScore(bestscore: Int){
        
        if(bestscore >= getBestScore())
        {
            setBestScore(bestscore: bestscore)
        }
    }
    
    public func isBestScore(bestscore: Int) -> Bool{
        return bestscore >= getBestScore()
    }
    
    
    public func getBestScore() -> Int {
    
        if(UserDefaults.standard.object(forKey: "bestscore") == nil){
            return 0
        }
        
        let bestscore =  UserDefaults.standard.string(forKey: "bestscore")
        
        return Int(bestscore!)!
    }
    
    private func setBestScore(bestscore : Int){
        UserDefaults.standard.set(String(bestscore), forKey: "bestscore")
        UserDefaults.standard.synchronize()
    }

    
}
