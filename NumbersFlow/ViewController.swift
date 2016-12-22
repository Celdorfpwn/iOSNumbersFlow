//
//  ViewController.swift
//  NumbersFlow
//
//  Created by Ionut Apostol on 07/12/16.
//  Copyright © 2016 Catchy Games. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet  var presentationLabel: UILabel!
    
    public let numbersFactory : NumbersFactory = NumbersFactory()
    
    private lazy var countDowner : CountDowner = CountDowner(controller: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startIntroduction()
    }
    
    public func startIntroduction(){
        presentationLabel.alpha = 0.0
        fadeInFun()
    }
    
    
    public func fadeInFun() {
        
        self.presentationLabel.text = "Have fun"
        fadeInText()
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fadeOutFun), userInfo: nil, repeats: false)
    }
    
    public func fadeOutFun() {
        fadeOutText()
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(startGame), userInfo: nil, repeats: false)
    }
    
    public func startGame(){
        
        removeButtons()
        self.numbersFactory.reset()
        self.generateButtons()
        self.countDowner.start()
        
    }
    
    private func removeButtons(){
        self.view.subviews.forEach({
            if(!$0.isEqual(self.presentationLabel)){
                $0.removeFromSuperview()
            }
            
            self.presentationLabel.isHidden = true
            
        })
    }
    
    
    
    public func endGame() {
        
        removeButtons()
        self.view.backgroundColor = UIColor.white
        self.presentationLabel.isHidden = false
        let scoreBoard = ScoreBoard()
        
        scoreBoard.tryBestScore(bestscore: numbersFactory.getScore())
        
        if(scoreBoard.isBestScore(bestscore: numbersFactory.getScore()))
        {
            fadeInBestScore()
        }
        else
        {
            fadeInScore()
        }
    }
    
    public func fadeInScore(){
        self.presentationLabel.text = "Score " + String(numbersFactory.getScore())
        fadeInText()
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fadeOutScore), userInfo: nil, repeats: false)
    }
    
    public func fadeOutScore(){
        fadeOutText()
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fadeInBestScore), userInfo: nil, repeats: false)
    }
    
    
    public func fadeInBestScore(){
        self.presentationLabel.text = "Best score " + String(ScoreBoard().getBestScore())
        fadeInText()
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fadeOutBestScore), userInfo: nil, repeats: false)
    }
    
    public func fadeOutBestScore(){
        
        fadeOutText()
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(startGame), userInfo: nil, repeats: false)
        
    }
    
    
    private func fadeInText(){
        
        UIView.animate(withDuration: 2, animations: {
            self.presentationLabel.alpha = 1.0
        })
    }
    
    private func fadeOutText(){
        UIView.animate(withDuration: 2, animations: {
            self.presentationLabel.alpha = 0
        })
    }
    

    
    
    @IBAction func buttonClick(button: GameButton!) {
        
        let number = Int(button.titleLabel!.text!)
        
        if(numbersFactory.validateNumber(number: number!))
        {
            button.okEvent()
            countDowner.addCombo()
            button.setTitle(String(numbersFactory.getNextNumber()), for: UIControlState.normal)
        }
        else
        {
            countDowner.wrong()
            button.wrongEvent()
        }
        
    }
    
    @IBAction public func counterClick(button: GameButton!){
        
        countDowner.tempSetLabelText(text: String(numbersFactory.getLastNumber()))
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    func generateButtons() {
        
        let buttonSize : CGFloat = view.frame.width / Constants.buttonDiff
        
        let whiteSpace : CGFloat = buttonSize / Constants.buttonDiff
        
        var xPosition : CGFloat = whiteSpace
        
        // 5x5 var yPosition : CGFloat = (view.frame.height - buttonSize * Constants.whiteSpaceIndex - whiteSpace * 4) / 2
        
        var yPosition : CGFloat = buttonSize * 2.5
        
        for _ in 1...Constants.gameIndex {
            
            for _ in 1...Constants.gameIndex {
                let button =  GameButton(type: UIButtonType.system)
                button.initialize(x: xPosition, y: yPosition, size: buttonSize)
                button.setText(text: String(numbersFactory.getNextNumber()))
                button.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
                xPosition += buttonSize + whiteSpace
                
                view.addSubview(button)
            }
            
            xPosition = whiteSpace
            yPosition += buttonSize + whiteSpace
            
        }
    }
    
}

