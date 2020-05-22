//
//  ViewController.swift
//  NavigationNoStoryBoard
//
//  Created by Maxim on 21/05/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let nextButton = UIButton()
    let nextButtonSegue = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNextButton(button: nextButton ,selector: #selector(nextButtonTapped), text: "Next Screen", centerAnchorConstant: -100)
        setupNextButton(button: nextButtonSegue, selector: #selector(nextButtonTappedSegue), text: "Next Screen Segue", centerAnchorConstant: 100)
        view.backgroundColor = .red
        
        // Do any additional setup after loading the view.
    }

    func setupNextButton(button: UIButton, selector: Selector, text: String, centerAnchorConstant: Int) {
        button.backgroundColor = .black
        button.setTitleColor(.red, for: .normal)
        button.setTitle(text, for: .normal)
        
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        view.addSubview(button)
        setNextButtonConstraints(button: button ,centerAnchor: centerAnchorConstant)
    }
    
    func setNextButtonConstraints(button: UIButton, centerAnchor: Int){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat(centerAnchor)).isActive = true
    }
    
    @objc func nextButtonTapped() {
        let nextScreen = SecondViewController()
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    @objc func nextButtonTappedSegue() {
        let nextScreen = SecondViewController()
        present(nextScreen, animated: true, completion: nil)
    }
}

