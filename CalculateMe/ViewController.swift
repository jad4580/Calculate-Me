//
//  ViewController.swift
//  CalculateMe
//
//  Created by Justin Doan on 1/6/18.
//  Copyright © 2018 Justin Doan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentOperator: Operator = Operator.Nothing
    var calcState: CalcState = CalcState.enteringNum
    var firstValue: String = ""
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func numberClicked (_ sender: UIButton) {
        updateDisplay(number: String(sender.tag))
    }
    
    func updateDisplay (number: String) {
        if calcState == CalcState.newNumStarted {
            // Tests if theres actually a string in displayLabel.text
            if let num = displayLabel.text {
                if num != "" {
                    firstValue = num
                }
            }
            calcState = CalcState.enteringNum
            displayLabel.text = number
        } else if calcState == CalcState.enteringNum {
            // Saying that you're absolute sure there is a string in displayLabel.text (!) - unwrapping an option
            displayLabel.text = displayLabel.text! + number
        } else {
            
        }
    }
    
    @IBAction func operatorClicked (_ sender: UIButton) {
        calcState = CalcState.newNumStarted
        if let num = displayLabel.text {
            if num != "" {
                firstValue = num
                displayLabel.text = ""
            }
        }
        switch sender.tag {
        case 10:
            currentOperator = Operator.Add
        case 11:
            currentOperator = Operator.Subtract
        case 12:
            currentOperator = Operator.Multiply
        case 13:
            currentOperator = Operator.Divide
        default:
            return
        }
    }
    
    @IBAction func equalsClicked (_ sender: UIButton) {
        calculateSum()
    }
    
    @IBAction func clearClicked (_ sender: UIButton) {
        displayLabel.text = ""
        calcState = CalcState.enteringNum
        
    }
    
    func calculateSum() {
        if firstValue.isEmpty {
            return
        }
        
        var result = ""
        if currentOperator == Operator.Add {
            result = "\(Double(firstValue)! + Double(displayLabel.text!)!)"
        } else if currentOperator == Operator.Subtract {
            result = "\(Double(firstValue)! - Double(displayLabel.text!)!)"
        } else if currentOperator == Operator.Multiply {
            result = "\(Double(firstValue)! * Double(displayLabel.text!)!)"
        } else if currentOperator == Operator.Divide {
            result = "\(Double(firstValue)! / Double(displayLabel.text!)!)"
        }
        
        displayLabel.text = result
        calcState = CalcState.newNumStarted
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

