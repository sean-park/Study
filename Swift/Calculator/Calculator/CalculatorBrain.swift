//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Sean Park on 4/7/17.
//  Copyright © 2017 Sean Park. All rights reserved.
//

import Foundation

struct CalculatorBrain{                     //public API
    
    mutating func addUnaryOperation(named symbol: String, _ operation: @escaping (Double)->Double){
        operations[symbol] = Operation.unaryOperation(operation)
    }
    
    private var accumulator: Double?                //'?' not set
    
    private enum Operation{
        case constant(Double)   //associated value
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),   //Double.pi,
        "e" : Operation.constant(M_E), //M_E,
        "√" : Operation.unaryOperation(sqrt), //sqrt,
        "cos" : Operation.unaryOperation(cos),   //cos
        "±": Operation.unaryOperation({ -$0}),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "−": Operation.binaryOperation({ $0 - $1 }),
        "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String){            //public

        if let operation = operations[symbol]{
            switch operation{
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
        
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?            //'?' not set
    
    private struct PendingBinaryOperation{
        let function: (Double,Double)->Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double)->Double{
            return function(firstOperand,secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double){                 //public
        accumulator = operand
    }
    
    var result: Double?{                                 //public
        get{                    //read only
            return accumulator
        }
    }
}
