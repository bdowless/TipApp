//
//  CalculateController.swift
//  TipApp
//
//  Created by Brandon Dowless on 3/22/22.
//

import Foundation
import UIKit

class CalculateController: UIViewController {
    
    var finalBillResult: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Result is 200"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemGreen
        
        view.addSubview(finalBillResult)
        finalBillResult.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
        finalBillResult.topAnchor.constraint(equalTo: view.topAnchor, constant: 150) .isActive = true
    }
}
