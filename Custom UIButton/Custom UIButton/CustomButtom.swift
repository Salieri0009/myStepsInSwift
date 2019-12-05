//
//  CustomButtom.swift
//  Custom UIButton
//
//  Created by Maxim on 12/11/2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class CustomeButtom: UIButton
{
    
    override init(frame: CGRect){
        super.init(frame:frame)
        setupButton()
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        setShadow()
        setTitleColor(.black, for: .normal)
        
        backgroundColor    = UIColor(red: 170/255, green: 5/255, blue: 5/255, alpha: 1.0)
        titleLabel?.font   = UIFont(name: "TEST", size: 17)
        layer.cornerRadius = 25
        layer.borderColor  = UIColor.black.cgColor
        layer.borderWidth  = 3.0
    }
    
    private func setShadow()
    {
        layer.shadowColor   = UIColor.red.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    func shake()
    {
        let shake          = CABasicAnimation(keyPath: "position")
        shake.duration     = 0.1
        shake.repeatCount  = 2
        shake.autoreverses = true
        
        let fromPoint      = CGPoint(x: center.x - 8, y: center.y)
        let fromValue      = NSValue(cgPoint: fromPoint)
        
        let toPoint        = CGPoint(x: center.x + 8, y:center.y)
        let toValue        = NSValue(cgPoint: toPoint)
        
        shake.fromValue    = fromValue
        shake.toValue      = toValue
        
        layer.add(shake, forKey: "position")
    }
    
}

