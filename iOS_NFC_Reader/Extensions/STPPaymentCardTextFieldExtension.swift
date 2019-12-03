//
//  STPPaymentCardTextFieldExtension.swift
//  iOS_NFC_Reader
//
//  Created by yomi on 2019/12/3.
//  Copyright © 2019 yomi. All rights reserved.
//

import Foundation
import Stripe

extension STPPaymentCardTextField {
    func setExistingCard(card: STPCardParams) {
        replaceField(memberName: "numberField", withValue: card.number!)
        replaceField(memberName: "expirationField", withValue: String(format: "%02d/%02d", card.expMonth, (card.expYear % 100)))
        replaceField(memberName: "cvcField", withValue: card.cvc!)
    }

    func replaceField(memberName: String, withValue value: String) {
        let field = self.value(forKey: memberName) as! UITextField
        field.text = value
    }
}
