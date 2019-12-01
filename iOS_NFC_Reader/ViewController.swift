//
//  ViewController.swift
//  iOS_NFC_Reader
//
//  Created by yomi on 2019/11/29.
//  Copyright © 2019 yomi. All rights reserved.
//

import UIKit
import CreditCardForm
import Stripe

class ViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    @IBOutlet weak var vCreditCardView: CreditCardFormView!
    
    let paymentTextField = STPPaymentCardTextField()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up stripe textfield
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        paymentTextField.delegate = self
        
        view.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: vCreditCardView.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - STPPaymentCardTextFieldDelegate
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        vCreditCardView.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        vCreditCardView.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        vCreditCardView.paymentCardTextFieldDidBeginEditingCVC()
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        vCreditCardView.paymentCardTextFieldDidEndEditingCVC()
    }
}

