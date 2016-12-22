//
//  CountDowner.swift
//  NumbersFlow
//
//  Created by Ionut Apostol on 12/12/16.
//  Copyright © 2016 Catchy Games. All rights reserved.
//

import Foundation
import UIKit


public class CountDowner {
    
    private let viewController : ViewController
    
    private var timerLabel : GameButton!
    
    private var timerCounter : Int = Constants.startSeconds
    
    private var timer : Timer = Timer()
    
    private var comboCounter : Int = Constants.comboSeconds
    
    private var comboX : Int = 0
    
    private var blockLabelText : Bool = false
    
    init(controller : ViewController) {
        viewController = controller
        
    }
    
    
    public func start() {
        generateTimerLabel()
        comboCounter = Constants.comboSeconds
        
        timerCounter = Constants.startSeconds
        timerLabel.setText(text: String(timerCounter) )
        timerLabel.addTarget(viewController, action: #selector(viewController.counterClick), for: UIControlEvents.touchUpInside)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountAction), userInfo: nil, repeats: true)
    }
    
    public func wrong(){
        comboCounter = 0
        comboX = 0
        if(timerCounter >= 3){
            timerCounter -= 3
            timerLabel.setText(text: String(timerCounter))
        }
        else {
            endGame()
        }
    }
    
    public func tempSetLabelText(text: String){
        
        blockLabelText = true
        timerLabel.setText(text: text)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(freeLabel), userInfo: nil, repeats: false)
    }
    
    @objc func freeLabel(){
        blockLabelText = false
    }
    
    public func addCombo() {
        comboCounter = Constants.comboSeconds
        comboX += 1
    }
    
    
    func calculateCombo() -> Int {
        return comboX / 3 + comboX
    }
    
    func generateTimerLabel() {
        let buttonSize : CGFloat = viewController.view.frame.width / Constants.buttonDiff
        // 5x5 buttonSize / 2 + buttonSize * 2
        
        
        let xPosition : CGFloat = buttonSize / 5 * 2 + buttonSize + buttonSize / 2 + buttonSize / 10
        // 5x5 let yPosition : CGFloat = 50.0
        
        let yPosition : CGFloat = (buttonSize * 1.5 ) / 2
        
        
        timerLabel =  GameButton(type: UIButtonType.system)
        timerLabel.initialize(x: xPosition, y: yPosition, size: buttonSize)
        
        viewController.view.addSubview(timerLabel)
    }
    
    func endGame() {
        timer.invalidate()
        viewController.endGame()
    }
    
    @objc func timerCountAction() {
        if(timerCounter <= 0)
        {
            if(comboX <= 3)
            {
                endGame()
            }
            else
            {
                comboCounter = 0
            }
        }
        
        if(comboCounter == 0)
        {
            if(comboX > 3)
            {
                let comboTotal = calculateCombo()
                timerCounter += comboTotal
                setLabelText(text: "+" + String(comboTotal))
                
            }
            else
            {
                setLabelText(text: String(timerCounter))
                timerCounter -= 1
            }
            
            comboX = 0
        }
        else
        {
            comboCounter -= 1
            setLabelText(text:String(timerCounter))
            timerCounter -= 1
        }
    }
    
    func setLabelText(text: String) {
        if(!blockLabelText)
        {
            timerLabel.setText(text: text)
        }
    }
    
}
