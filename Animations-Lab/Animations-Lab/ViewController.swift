
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
        button.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.setImage(UIImage(systemName: "chevron.up.circle"), for: .normal)
        button.showsTouchWhenHighlighted = true
        button.transform = CGAffineTransform(scaleX: 1.65, y: 1.65)
        button.addTarget(self, action: #selector(moveUpButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var moveDownButton: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.setImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.showsTouchWhenHighlighted = true
        button.transform = CGAffineTransform(scaleX: 1.65, y: 1.65)
        button.addTarget(self, action: #selector(moveDownButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var moveLeftButton: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.setImage(UIImage(systemName: "chevron.left.circle"), for: .normal)
        button.showsTouchWhenHighlighted = true
        button.transform = CGAffineTransform(scaleX: 1.65, y: 1.65)
        button.addTarget(self, action: #selector(moveLeftButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var moveRightButton: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        button.setImage(UIImage(systemName: "chevron.right.circle"), for: .normal)
        button.showsTouchWhenHighlighted = true
        button.transform = CGAffineTransform(scaleX: 1.65, y: 1.65)
        button.addTarget(self, action: #selector(moveRightButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var LeftRightButtonStackView: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [moveLeftButton, moveRightButton])
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 1
        return buttonStack
    }()
    
    lazy var upDownButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [moveUpButton, moveDownButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 29
        return stack
    }()
    
    lazy var myView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "image")
        var frame = view.frame
        frame.size.width = 150
        frame.size.height = 150
        view.frame = frame
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var animationTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time: \(animationTimeStepper.value)"
        label.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        return label
    }()
    
    lazy var animationTimeStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 5.0
        stepper.minimumValue = 0.25
        stepper.stepValue = 0.25
        stepper.value = 1.0
        stepper.addTarget(self, action: #selector(animationTimeStepperValueChanged(sender:)), for: .valueChanged)
        return stepper
    }()
    
    lazy var animationTimeStackView: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [animationTimeLabel, animationTimeStepper])
        buttonStack.axis = .vertical
        buttonStack.alignment = .center
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 10
        return buttonStack
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Dist: \(distanceStepper.value)"
        label.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        return label
    }()
    
    lazy var distanceStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 300
        stepper.minimumValue = 50
        stepper.stepValue = 10
        stepper.value = 100
        stepper.addTarget(self, action: #selector(distanceStepperValueChanged(sender:)), for: .valueChanged)
        return stepper
    }()
    
    lazy var distanceStackView: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [distanceLabel, distanceStepper])
        buttonStack.axis = .vertical
        buttonStack.alignment = .center
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 10
        return buttonStack
    }()
    
    lazy var animStylePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 280.0)
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    
    
    var selectedAnimationOption = UIView.AnimationOptions()
    
    var animationOptionTitles = ["CurveLinear", "CurveEaseIn", "CurveEaseOut", "transitionCrossDissolve", "Repeat"]
    
    
    var animationDuration = Double() {
        didSet {
            animationTimeLabel.text = "Time: \(animationDuration)"
        }
    }
    
    var travelDistance = CGFloat() {
        didSet {
            distanceLabel.text = "Dist: \(travelDistance)"
        }
    }
    
    //References to prior constraints.
    lazy var myViewHeightConstraint: NSLayoutConstraint = {
        myView.heightAnchor.constraint(equalToConstant: myView.frame.height)
    }()
    
    lazy var myViewWidthConstraint: NSLayoutConstraint = {
        myView.widthAnchor.constraint(equalToConstant: myView.frame.width)
    }()
    //The frame is a circle, but the view isn't yet 'cut out' for the frame until these two lines
    
    lazy var myViewCenterXConstraint: NSLayoutConstraint = {
        myView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var myViewCenterYConstraint: NSLayoutConstraint = {
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    
    //MARK: -- Methods
    @objc func moveUpButtonPressed(sender: UIButton) {
        myView.image = #imageLiteral(resourceName: "imageMoving")
        let oldYPosition = myViewCenterYConstraint.constant
        myViewCenterYConstraint.constant = oldYPosition - travelDistance
        UIView.animate(withDuration: animationDuration, delay: 0, options: selectedAnimationOption, animations: {self.view.layoutIfNeeded()}, completion: {(action) in
            self.myView.image = #imageLiteral(resourceName: "image")
        })
    }
    
    
    @objc func moveDownButtonPressed(sender: UIButton) {
        myView.image = #imageLiteral(resourceName: "imageMoving")
        let oldYPosition = myViewCenterYConstraint.constant
        myViewCenterYConstraint.constant = oldYPosition + travelDistance
        UIView.animate(withDuration: animationDuration, delay: 0, options: selectedAnimationOption, animations: {self.view.layoutIfNeeded()}, completion: {(action) in
            self.myView.image = #imageLiteral(resourceName: "image")
        })
    }
    
    @objc func moveLeftButtonPressed(sender: UIButton) {
        myView.image = #imageLiteral(resourceName: "imageMoving")
        let oldXPosition = myViewCenterXConstraint.constant
        myViewCenterXConstraint.constant = oldXPosition - travelDistance
        UIView.animate(withDuration: animationDuration, delay: 0, options: selectedAnimationOption, animations: {self.view.layoutIfNeeded()}, completion: {(action) in
            self.myView.image = #imageLiteral(resourceName: "image")
        })
    }
    
    @objc func moveRightButtonPressed(sender: UIButton) {
        myView.image = #imageLiteral(resourceName: "imageMoving")
        let oldXPosition = myViewCenterXConstraint.constant
        myViewCenterXConstraint.constant = oldXPosition + travelDistance
        UIView.animate(withDuration: animationDuration, delay: 0, options: selectedAnimationOption, animations: {self.view.layoutIfNeeded()}, completion: {(action) in
            self.myView.image = #imageLiteral(resourceName: "image")
        })
    }
    
    @objc func animationTimeStepperValueChanged(sender: UIStepper) {
        animationDuration = sender.value
    }
    
    @objc func distanceStepperValueChanged(sender: UIStepper) {
        travelDistance = CGFloat(sender.value)
    }
    
    private func addSubViews() {
        [myView, LeftRightButtonStackView, animationTimeStackView, distanceStackView, animStylePicker, upDownButtonStack].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        let UIElements = [myView, LeftRightButtonStackView, animationTimeStackView, distanceStackView, animStylePicker, upDownButtonStack]
        
        for UIElement in UIElements {
            self.view.addSubview(UIElement)
        }
    }
    
    //MARK: -- Constraints
    private func setConstraints(){
        setViewConstraints()
        setConstraintsForLeftRightButtonStack()
        setConstraintsForUpDownButtonStack()
        setConstraintsForAnimTimeStack()
        setConstraintsForDistanceStack()
        setconstraintsForAnimPicker()
    }
    
    
    private func setConstraintsForLeftRightButtonStack() {
        NSLayoutConstraint.activate([
            LeftRightButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LeftRightButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            LeftRightButtonStackView.heightAnchor.constraint(equalToConstant: 50),
            LeftRightButtonStackView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setConstraintsForUpDownButtonStack() {
        NSLayoutConstraint.activate([
            upDownButtonStack.centerXAnchor.constraint(equalTo: LeftRightButtonStackView.centerXAnchor),
            upDownButtonStack.centerYAnchor.constraint(equalTo: LeftRightButtonStackView.centerYAnchor),
            upDownButtonStack.heightAnchor.constraint(equalToConstant: 100),
            upDownButtonStack.widthAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
    private func setConstraintsForAnimTimeStack() {
        NSLayoutConstraint.activate([
            animationTimeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            animationTimeStackView.bottomAnchor.constraint(equalTo: LeftRightButtonStackView.bottomAnchor, constant: -100),
            animationTimeStackView.widthAnchor.constraint(equalToConstant: 130),
            animationTimeStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setConstraintsForDistanceStack() {
        NSLayoutConstraint.activate([
            distanceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 150),
            distanceStackView.bottomAnchor.constraint(equalTo: LeftRightButtonStackView.bottomAnchor, constant: -100),
            distanceStackView.widthAnchor.constraint(equalToConstant: 130),
            distanceStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setconstraintsForAnimPicker() {
        NSLayoutConstraint.activate([
            animStylePicker.centerXAnchor.constraint(equalTo:  view.centerXAnchor, constant: -3.5),
            animStylePicker.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
    }
    
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            myViewWidthConstraint,
            myViewHeightConstraint,
            myViewCenterXConstraint,
            myViewCenterYConstraint
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9632374644, green: 1, blue: 0.8970387578, alpha: 1)
        addSubViews()
        setConstraints()
        animationDuration = 1.0
        travelDistance = 100
    }
}

//MARK: -- PickerView DataSource/Delegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animationOptionTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animationOptionTitles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0: selectedAnimationOption = .curveLinear
        case 1: selectedAnimationOption = .curveEaseIn
        case 2: selectedAnimationOption = .curveEaseOut
        case 3: selectedAnimationOption = .transitionCrossDissolve
        case 4: selectedAnimationOption = .repeat
        default:
            selectedAnimationOption = .init()
        }
    }
}









//lazy var moveUpButton: UIButton = {
//     let button = UIButton()
//     button.setTitle("U", for: .normal)
//     button.titleLabel?.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
//     button.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
//     button.layer.cornerRadius = 10
//     button.showsTouchWhenHighlighted = true
//
//     button.addTarget(self, action: #selector(moveUpButtonPressed(sender:)), for: .touchUpInside)
//     return button
// }()
