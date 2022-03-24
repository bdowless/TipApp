//
//  TipCalculatorController.swift
//  TipApp
//
//  Created by Brandon Dowless on 3/17/22.
//

import UIKit

class TipCalculatorController: UIViewController {
    
    //MARK: - Properties
    
    var buttonPercentage: Int = 0
    
    /*
     data source for creating buttons acts a single source of truth
     this way you can just update this array and loop thru it to create your buttons
     */
    var tipPercentages = [0, 10, 18, 20] // [0 -> percent button,
    
    var buttons = [UIButton]() {
        didSet {
            configureUI()
        }
    }
    
    var billTotal: UILabel = {
        let label = UILabel()
        label.text = "Bill total"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tipTotal: UILabel = {
        let label = UILabel()
        label.text = "Tip Percentage"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var billTotalTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "0.0"
        textfield.textColor = .black
        textfield.font = UIFont.boldSystemFont(ofSize: 32)
        textfield.layer.borderColor = CGColor(red: 20, green: 20, blue: 20, alpha: 1)
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    var tipPercentageTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "18%"
        textfield.textColor = .black
        textfield.font = UIFont.boldSystemFont(ofSize: 32)
        textfield.layer.borderColor = CGColor(red: 20, green: 20, blue: 20, alpha: 1)
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    var splitBillLabelText: UILabel = {
        let label = UILabel()
        label.text = "Split The Bill"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.addTarget(self, action: #selector(handleStepper), for: .valueChanged)
        return stepper
    }()
    
    var splitBillLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCalculateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var finalBillTotal: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .black
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createButtonArray()
        view.backgroundColor = .white
    }
    
    //MARK: - Selectors
    
    @objc func handleStepper() {
        let value = stepper.value
        let splitlabel = splitBillLabel
        splitlabel.text = "\(value)"
    }
    
    @objc func handleTip(sender: UIButton) {
//        let filterButtonPercentage = sender.titleLabel?.text?.filter{ "0123456789".contains($0) }
        let filterButtonPercentage = sender.titleLabel?.text?.replacingOccurrences(of: "%", with: "")
        guard let buttonPercentage = filterButtonPercentage else { return }
        print("DEBUG: \(buttonPercentage)")
        tipPercentageTextField.text = buttonPercentage
        print("DEBUG: \(buttonPercentage)")
    }
    
    @objc func handleCalculateButtonTapped() {
        guard let billAmountString = billTotalTextField.text else { return }
        let initalBillAmount = Double(billAmountString)
        print("DEBUG:\(initalBillAmount)")
        
//        let finalBillLabel = FinalBillTotal
//
        guard let tipPercentageAmount = tipPercentageTextField.text else { return }
        let tipPercentage = Int(tipPercentageAmount) ?? 2
//        let decimalPercentage = tipPercentage / 100
//        let tip = initalBillAmount * decimalPercentage
//        print("DEBUG: \(tip)")
//        let finalBill = String("\(initalBillAmount + tip)$")
//        finalBillLabel.isHidden = false
//        finalBillLabel.text = ("Bill Total: \(finalBill)")
//
//        let calculateController = CalculateController()
//        calculateController.finalBillResult.text = finalBillLabel.text
//        present(calculateController, animated: true, completion: nil)
//
        let tipPercentAsDoulbe = Double(tipPercentage)
        let calculation = TipCalculation(tipPercentage: tipPercentAsDoulbe, numberOfPeople: Int(stepper.value))
        
        let billTotal = calculation.billTotal(forAmount: initalBillAmount ?? 0)
        let calculateController = CalculateController()
        calculateController.finalBillResult.text = ("Your Total is : \(billTotal)")
        present(calculateController, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
         let billStack = UIStackView(arrangedSubviews: [billTotal, billTotalTextField])
        billStack.axis = .horizontal
        billStack.distribution = .fillEqually
        billStack.spacing = 50
        billStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(billStack)
        billStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 80) .isActive = true
        billStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -52) .isActive = true
        billStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 42) .isActive = true
        
        let tipStack = UIStackView(arrangedSubviews: [tipTotal, tipPercentageTextField])
        tipStack.axis = .horizontal
        tipStack.distribution = .fillEqually
        tipStack.spacing = 50
        tipStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tipStack)
        tipStack.topAnchor.constraint(equalTo: billStack.topAnchor, constant: 62) .isActive = true
        tipStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -48) .isActive = true
        tipStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 42) .isActive = true
        
        let buttonStack = UIStackView(arrangedSubviews: buttons)
        buttonStack.axis = .horizontal
        buttonStack.spacing = 20
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonStack)
        buttonStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20) .isActive = true
        buttonStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20) .isActive = true
        buttonStack.topAnchor.constraint(equalTo: tipStack.bottomAnchor, constant: 100) .isActive = true
        
        view.addSubview(splitBillLabelText)
        splitBillLabelText.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 80) .isActive = true
        splitBillLabelText.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
        
        let stepperStack = UIStackView(arrangedSubviews: [stepper, splitBillLabel])
        stepperStack.axis = .horizontal
        stepperStack.spacing = 20
        stepperStack.alignment = .center
        stepperStack.distribution = .fill
        stepperStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stepperStack)
        stepperStack.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
        stepperStack.topAnchor.constraint(equalTo: splitBillLabelText.bottomAnchor, constant: 42) .isActive = true
        
        let finalBillStack = UIStackView(arrangedSubviews: [finalBillTotal, calculateButton])
        finalBillStack.translatesAutoresizingMaskIntoConstraints = false
        finalBillStack.distribution = .fillEqually
        finalBillStack.axis = .vertical
        finalBillStack.spacing = 50
        
        view.addSubview(finalBillStack)
        finalBillStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50) .isActive = true
        finalBillStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50) .isActive = true
        finalBillStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50) .isActive = true
    }
    
    func createButtonArray() {
//        for _ in 0 ... 2 {
//            let button = templateButton(Percentage: "\(buttonPercentage)%")
//            buttons.append(button)
//            buttonPercentage += 10
//        }
        
        buttons = tipPercentages.map({ templateButton(Percentage: "\($0)%") })
        
        // this is the same as above short hand notation
//        tipPercentages.map { percentage in
//            return templateButton(Percentage: "\(percentage)%")
//        }
    }
}

extension TipCalculatorController {
    func templateButton(Percentage: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(Percentage, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleTip), for: .touchUpInside)
        return button
    }
}
