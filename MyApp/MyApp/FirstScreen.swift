//
//  FirstScreen.swift
//  MyApp
//
//  Created by Maxim on 27/11/2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class FirstScreen: UIViewController {
    
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNextButton()
        view.backgroundColor = .red
        
    }
    
    func setupNextButton() {
        nextButton.backgroundColor = .darkGray
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        view.addSubview(nextButton)
        setNextButtonConstrains()
    }
    
    func setNextButtonConstrains() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    @objc func nextButtonTapped(){
        let nextScreen = SecondScreen()
        nextScreen.title = "Next Screen"
        navigationController?.pushViewController(nextScreen, animated: true)
    }

}
