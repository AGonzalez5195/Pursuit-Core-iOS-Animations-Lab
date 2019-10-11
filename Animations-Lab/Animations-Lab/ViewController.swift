
//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Anthony Gonzalez on 10/11/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: -- Properties
    lazy var moveUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move Up", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        
        button.addTarget(self, action: #selector(moveUpButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var moveDownButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move Down", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        
        button.addTarget(self, action: #selector(moveDownButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var moveLeftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move Left", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        
        button.addTarget(self, action: #selector(moveLeftButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var moveRightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move Right", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        
        button.addTarget(self, action: #selector(moveRightButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [moveLeftButton,  moveUpButton, moveDownButton, moveRightButton])
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 10
        return buttonStack
    }()
    
    
    lazy var myView: UIView = {
        let myView = UIView()
        myView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        myView.layer.cornerRadius = 50
        return myView
    }()
    
    lazy var animationTimeStepper: UIStepper = {
        let stepper = UIStepper()
        
        return stepper
    }()
    
    //References to prior constraints.
    lazy var myViewHeightConstraint: NSLayoutConstraint = {
        myView.heightAnchor.constraint(equalToConstant: 250)
    }()
    
    lazy var myViewWidthConstraint: NSLayoutConstraint = {
        myView.widthAnchor.constraint(equalToConstant: 250)
    }()
    
    lazy var myViewCenterXConstraint: NSLayoutConstraint = {
        myView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var myViewCenterYConstraint: NSLayoutConstraint = {
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    
    //MARK: -- Methods
    @objc func moveUpButtonPressed(sender: UIButton) {
        let oldOffset = myViewCenterYConstraint.constant
        myViewCenterYConstraint.constant = oldOffset - 125 //Takes the prior constraint constant as a reference point and designates a new point.
        UIView.animate(withDuration: 1.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    //        UIView.animate(withDuration: 1.3, delay: 0, options: [.autoreverse,.repeat], animations: {self.view.layoutIfNeeded()}, completion: nil)
    
    
    //'layoutIfNeeded()' animates any constraint changes done for whole view
    
    @objc func moveDownButtonPressed(sender: UIButton) {
        let oldOffet = myViewCenterYConstraint.constant
        myViewCenterYConstraint.constant = oldOffet + 125
        UIView.animate(withDuration: 1.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func moveLeftButtonPressed(sender: UIButton) {
        let oldOffet = myViewCenterXConstraint.constant
        myViewCenterXConstraint.constant = oldOffet - 125
        UIView.animate(withDuration: 1.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func moveRightButtonPressed(sender: UIButton) {
        let oldOffet = myViewCenterXConstraint.constant
        myViewCenterXConstraint.constant = oldOffet + 125
        UIView.animate(withDuration: 1.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func addSubViews() {
        [myView, buttonStackView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        let UIElements = [buttonStackView, myView]
        
        for UIElement in UIElements {
            self.view.addSubview(UIElement)
        }
    }
    
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            myViewWidthConstraint, myViewHeightConstraint, myViewCenterXConstraint, myViewCenterYConstraint
        ])
        
        setConstraintsForStackView()
    }
    
    
    private func setConstraintsForStackView() {
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9719913602, green: 1, blue: 0.9106864333, alpha: 1)
        addSubViews()
        setConstraints()
    }
}

