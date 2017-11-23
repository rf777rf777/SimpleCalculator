//
//  ViewController.swift
//  Calculator
//
//  Created by Syashin on 2017/11/19.
//  Copyright © 2017年 Syashin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var rightValue:String = ""
    var leftValue:String = ""
    var currentNumber:String = "\(0)"
    var operatorSelected = OperatorSymbol.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func acButton(_ sender: UIButton) {
        
        resultLabel.text = "\(0)"
        rightValue = ""
        leftValue = ""
        currentNumber = "\(0)"
    }
    
    //1~9
    @IBAction func propertySymbolButton(_ sender: UIButton) {

        if let currentTitle = sender.currentTitle {
            if currentTitle == "."{
                if !currentNumber.contains(currentTitle){
                    currentNumber.append(currentTitle)
                    if currentNumber.first == "."{
                       currentNumber.insert("0", at: currentNumber.startIndex)
                    }
                }
            }
            else{
                currentNumber.append(currentTitle)
            }

            resultLabel.text = formatNumber(number: Double(currentNumber)!)
        }
    }

    //multiplication
    @IBAction func multiplicationButton(_ sender: UIButton) {
        lastReult()

        operatorSelected = OperatorSymbol.multiplication
    }
    
    //division
    @IBAction func divisionButton(_ sender: UIButton) {
        lastReult()
  
        operatorSelected = OperatorSymbol.division

    }
    
    //plus
    @IBAction func plusButton(_ sender: UIButton) {
        lastReult()
        operatorSelected = OperatorSymbol.plus
    }
    
    //minus
    @IBAction func minusButton(_ sender: UIButton) {
        lastReult()
  
        operatorSelected = OperatorSymbol.minus
    }
    
    //equal
    @IBAction func equalButton(_ sender: UIButton) {
        lastReult()
        operatorSelected = OperatorSymbol.Empty

        leftValue = ""
        rightValue = ""
    }

    //percent
    @IBAction func percentButton(_ sender: UIButton) {
        currentNumber = propertyResult(inputText: resultLabel.text, propertySymbol: PropertySymbol.percent)
        resultLabel.text = currentNumber
    }
    
    //root
    @IBAction func rootButton(_ sender: UIButton) {
        currentNumber = propertyResult(inputText: resultLabel.text, propertySymbol: PropertySymbol.root)
        resultLabel.text = currentNumber
    }
    
    func lastReult(){
        
        rightValue = currentNumber
        
        if leftValue.isEmpty {
            leftValue = currentNumber
        }
        else{
            if !leftValue.isEmpty && !rightValue.isEmpty{
                leftValue = "\(tempResult(leftVal: Double(leftValue)!, rightVal: Double(rightValue)!, operatorSymbol: operatorSelected))"
                resultLabel.text = formatNumber(number: Double(leftValue)!)
            }
        }
        
//        if !rightValue.isEmpty {
//            resultLabel.text = leftValue
//        }
        
        currentNumber = ""
    }
    
    func tempResult(leftVal:Double,rightVal:Double,operatorSymbol:OperatorSymbol) -> Double {
        switch operatorSymbol {
        case OperatorSymbol.plus:
            return leftVal + rightVal
        case OperatorSymbol.minus:
            return leftVal - rightVal
        case OperatorSymbol.multiplication:
            return leftVal * rightVal
        case OperatorSymbol.division:
            return leftVal / rightVal
        default:
            return leftVal
        }
    }
    
    func propertyResult(inputText:String? , propertySymbol:PropertySymbol) ->String {
        if var resultString = inputText {
            switch propertySymbol {
            case PropertySymbol.percent:
                resultString = formatNumber(number: Double(resultString)!*0.01)
            case PropertySymbol.root:
                resultString = formatNumber(number: sqrt(Double(resultString)!))
            }
            return resultString
        }
        return ""
    }
    
    func formatNumber(number originalNumber:Double) -> String{
        if originalNumber.truncatingRemainder(dividingBy: 1) == 0{
            return String(format: "%.0f", originalNumber)
        }
        return "\(originalNumber)"
    }
}

