//
//  CalculatorViewController.swift
//  Course2Week3Task1
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var firstTextLabel: UILabel!
    @IBOutlet weak var firstTextOperand: UILabel!
    @IBOutlet weak var secondTextLabel: UILabel!
    @IBOutlet weak var secondTextOperand: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stepperFirstOperand: UIStepper!
    @IBOutlet weak var sliderSecondOperand: UISlider!
    @IBOutlet weak var button: UIButton!
    
    let segmentSpace: CGFloat = 32
    let space: CGFloat = 16
    let heigh: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension CalculatorViewController {
    func setup(){
        setupButton()
        setupTextField()
        setupStepper()
        setupFirstTextLabel()
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
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: heigh).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.frame.width - space * 2).isActive = true
        button.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -(heigh/2 + space)).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupSlider() {
        sliderSecondOperand.translatesAutoresizingMaskIntoConstraints = false
        sliderSecondOperand.topAnchor.constraint(equalTo: secondTextLabel.bottomAnchor, constant: space).isActive = true
        sliderSecondOperand.leadingAnchor.constraint(equalTo: stepperFirstOperand.leadingAnchor).isActive = true
        sliderSecondOperand.trailingAnchor.constraint(equalTo: stepperFirstOperand.trailingAnchor).isActive = true
    }
    
    func setupTextField(){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: heigh).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.topAnchor, constant: heigh/2 + segmentSpace).isActive = true
        textField.widthAnchor.constraint(equalToConstant: view.frame.width - space * 2).isActive = true
    }
    
    func setupStepper() {
        stepperFirstOperand.translatesAutoresizingMaskIntoConstraints = false
        stepperFirstOperand.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space).isActive = true
        stepperFirstOperand.topAnchor.constraint(equalTo: firstTextLabel.bottomAnchor, constant: space).isActive = true
    }
    
    func setupFirstTextLabel() {
        firstTextLabel.text = "First operant"
        firstTextLabel.translatesAutoresizingMaskIntoConstraints = false
        firstTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        firstTextLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: segmentSpace).isActive = true
    }
    
    func setupSecondTextLabel() {
        secondTextLabel.text = "Second operant"
        secondTextLabel.translatesAutoresizingMaskIntoConstraints = false
        secondTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        secondTextLabel.topAnchor.constraint(equalTo: stepperFirstOperand.bottomAnchor, constant: segmentSpace).isActive = true
    }
    
    func setupFirstOperand() {
        firstTextOperand.translatesAutoresizingMaskIntoConstraints = false
        firstTextOperand.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        firstTextOperand.centerYAnchor.constraint(equalTo: stepperFirstOperand.centerYAnchor).isActive = true
    }
    
    func setupSecondOperand() {
        secondTextOperand.translatesAutoresizingMaskIntoConstraints = false
        secondTextOperand.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        secondTextOperand.centerYAnchor.constraint(equalTo: sliderSecondOperand.centerYAnchor).isActive = true
    }
}
