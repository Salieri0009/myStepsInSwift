//
//  ViewController.swift
//  Calculator
//
//  Created by Maxim on 15/10/2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var isDouble:Bool = false
    var isNegative:Bool = false
    var isDooble:Bool = false
    var isMathSignInLine:Bool = false

    var numberFromScreen:Double = 0
    var firstNum:Double = 0
    var operation: Int = 0
    
    
    @IBOutlet weak var result: UILabel!
    
    @IBAction func digits(_ sender: UIButton) {
        if isMathSignInLine == true && sender.tag != 16 && sender.tag != 18{
            result.text = String(sender.tag)
            isMathSignInLine = false
        }
        else if sender.tag != 16 && sender.tag != 18{
            result.text = result.text! + String(sender.tag)
        }
        
            
        else if sender.tag == 16 && isDooble == false && result.text != ""{
            result.text = result.text! + "."
            isDooble = true
        }
        else if sender.tag == 18{
            let subline = result.text
            result.text = String(subline!.dropLast())
        }
        if result.text != ""{
            numberFromScreen = Double(result.text!)!
        }
    }
    
    
    @IBAction func buttons(_ sender: UIButton) {
        if result.text != " " && sender.tag != 10 && sender.tag != 15{
            firstNum = Double(result.text!)!
            
            if sender.tag == 11{//деление
                result.text = "/"
                
            }
                
            else if sender.tag == 12{//умножение
                result.text = "x"
                
            }
            
            else if sender.tag == 13{// вычетание
                result.text = "-"
                
            }
            else if sender.tag == 14{// сумма
                result.text = "+"
                
            }
            
            
            operation = sender.tag
            isMathSignInLine = true
            isDooble = false
        }
        else if sender.tag == 15{// равно
            if operation == 11{
                result.text = String(Float(firstNum / numberFromScreen))
                
            }
            else if operation == 12{
                result.text = String(Float(firstNum * numberFromScreen))
                
            }
            else if operation == 13{
                result.text = String(Float(firstNum - numberFromScreen))
                
            }
            else if operation == 14{
                result.text = String(Float(firstNum + numberFromScreen))
                
            }
            
        }
        else if sender.tag == 10{
            result.text = " "
            firstNum = 0
            numberFromScreen = 0
            operation = 0
            isDooble = false
            isMathSignInLine = true
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

