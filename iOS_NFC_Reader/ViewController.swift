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
import Pulsator

class ViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    private static let PLUSATOR_NUM_PLUS:Int = 3
    private static let PLUSATOR_RADIUS:CGFloat = 120.0
    private static let PLUSATOR_BG_COLOR:CGColor = UIColor(red: 0.792, green: 0.811, blue: 0.819, alpha: 0.7).cgColor
    
    @IBOutlet weak var vCreditCardView: CreditCardFormView!
    @IBOutlet weak var mIvNfcRipper: UIImageView!
    
    let paymentTextField = STPPaymentCardTextField()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initPaymentTextField()
    }
    
    override func viewDidLayoutSubviews() {
        initNfcIconEffect()
    }
    
    func initNfcIconEffect() {
        let pulsator = Pulsator()
        pulsator.numPulse = ViewController.PLUSATOR_NUM_PLUS
        pulsator.radius = ViewController.PLUSATOR_RADIUS
        pulsator.backgroundColor = ViewController.PLUSATOR_BG_COLOR
        pulsator.position = CGPoint(x: mIvNfcRipper.frame.origin.x + mIvNfcRipper.frame.size.width / 2, y: mIvNfcRipper.frame.origin.y + mIvNfcRipper.frame.size.height / 2)
        
        self.view.layer.addSublayer(pulsator)
        pulsator.start()
    }
    
    func initPaymentTextField() {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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

