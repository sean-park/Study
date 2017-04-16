//
//  ViewController.swift
//  Calculator
//
//  Created by Sean Park on 4/7/17.
//  Copyright © 2017 Sean Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    override func viewDidLoad() {
        brain.addUnaryOperation(named: "✅") { [weak weakSelf = self] in
            weakSelf?.display.textColor = UIColor.green
            return sqrt($0)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        //        print("\(digit) was touched")
        //        drawHorizontalLine(from: 5.0, to: 8.5, using: UIColor.blue)
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        
    }
    
    //    func drawHorizontalLine(from startX: Double, to endX: Double, using color: UIColor){
    //
    //    }
    
    var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathmaticalSymbol = sender.currentTitle{
            brain.performOperation(mathmaticalSymbol)
            //            switch mathmaticalSymbol{
            //            case "π":
            //                displayValue = Double.pi          //set
            //            case "√":
            //                //                let operand = Double(display.text!)!
            //                displayValue =  sqrt(displayValue)              //get
            //            default:
            //                break
            
        }
        if let result = brain.result{
            displayValue = result
        }
    }
}



