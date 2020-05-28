//
//  CalculatorViewController.swift
//  Course2Week3Task1
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var sliderSecondOperand: UISlider!
    @IBOutlet weak var stepperFirstOperant: UIStepper!
    @IBOutlet weak var secondOperand: UILabel!
    @IBOutlet weak var secondTextLabel: UILabel!
    @IBOutlet weak var firstTextLabel: UILabel!
    @IBOutlet weak var firstOperand: UILabel!
    
    let segmentSpace: CGFloat = 32
    let space: CGFloat = 16
    let heigh: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension CalculatorViewController{
    func setup(){
        setupButton()
        setupTextField()
        setupFirstTextLabel()
        setupStepper()
        setupFirstOperand()
        setupSecondTextLabel()
        setupSlider()
        setupSecondOperand()
    }
    
    func setupButton(){
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont(name: "Calcul", size: 17)
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect (x: space,
                               y: view.bounds.maxY - space - heigh,
                               width: view.bounds.width - space * 2,
                               height: heigh)
    }
    
    func setupSlider() {
        sliderSecondOperand.frame = CGRect(x: stepperFirstOperant.frame.minX,
                                           y: secondTextLabel.frame.maxY + space,
                                           width: stepperFirstOperant.frame.width,
                                           height: stepperFirstOperant.frame.height)
    }
    
    func setupTextField(){
        textField.frame = CGRect(x: space,
                                 y: segmentSpace,
                                 width: view.bounds.width - space * 2,
                                 height: heigh)
    }
    
    func setupStepper() {
        stepperFirstOperant.frame = CGRect(x: view.bounds.width - space - stepperFirstOperant.frame.width,
                                           y: firstTextLabel.frame.maxY + space,
                                           width: view.bounds.width/2 - space,
                                           height: segmentSpace)
    }
    
    func setupFirstTextLabel() {
        firstTextLabel.frame = CGRect(x: space,
                                      y: textField.frame.maxY + segmentSpace,
                                      width: view.bounds.width/2 - space,
                                      height: segmentSpace)
    }
    
    func setupSecondTextLabel() {
        secondTextLabel.frame = CGRect(x: space,
                                       y: stepperFirstOperant.frame.maxY + segmentSpace,
                                       width: view.bounds.width/2 - space,
                                       height: segmentSpace)
    }
    
    func setupFirstOperand() {
        firstOperand.frame = CGRect(x: space,
                                    y: stepperFirstOperant.frame.minY,
                                    width: view.bounds.width/2 - space,
                                    height: segmentSpace)
    }
    
    func setupSecondOperand() {
        secondOperand.frame = CGRect(x: space,
                                     y: sliderSecondOperand.frame.minY,
                                     width: view.bounds.width/2 - space,
                                     height: segmentSpace)
    }
}
