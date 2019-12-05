//
//  ViewController.swift
//  Custom UIButton
//
//  Created by Maxim on 07/11/2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var topCustomeButtom: CustomeButtom!
    var customButton = CustomeButtom()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomButtonConstraints()
        addActionToButton()
        customButton.setTitle("Next page", for: .normal)
    }
    
    func setupBottomButtonConstraints() {
        view.addSubview(customButton)
        customButton.translatesAutoresizingMaskIntoConstraints                      = false
        customButton.heightAnchor.constraint(equalToConstant: 50).isActive          = true
        customButton.widthAnchor.constraint(equalToConstant: 280).isActive          = true
        customButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive         = true
    }
    
    func addActionToButton() {
        customButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
    }
    
    @objc func bottomButtonTapped(){
        customButton.shake()
    }
    
    
    @IBAction func topButtomTapped(_ sender: CustomeButtom) {
        topCustomeButtom.shake()
    }
    
}
