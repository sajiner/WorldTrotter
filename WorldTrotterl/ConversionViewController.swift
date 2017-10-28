//
//  ConversionViewController.swift
//  WorldTrotterl
//
//  Created by 张鑫 on 2017/10/28.
//  Copyright © 2017年 张鑫. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var fahrenheitTextField: UITextField!
    @IBOutlet var celsuisLabel: UILabel!
    
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsuisValue()
        }
    }
    
    var celsuisValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5 / 9)
        }
        return nil
    }
    
    //MARK: 更新摄氏度
    func updateCelsuisValue() {
        if let value = celsuisValue {
            celsuisLabel.text = formatter.string(for: value)
        } else {
            celsuisLabel.text = "???"
        }
    }
    
    //MARK: 输入改变
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    //MARK: delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let changeText = textField.text?.range(of: ".")
        let replaceText = string.range(of: ".")
        if changeText != nil && replaceText != nil {
            return false
        }
        for index in 0..<string.lengthOfBytes(using: String.Encoding.utf8) {
            let char = (string as NSString).character(at: index)
            if (char >= 65 && char <= 90) || (char >= 97 && char <= 122) {
                return false
            }
        }
        return true
    }
}
