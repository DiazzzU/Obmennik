import UIKit

extension EditViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("\(textField.tag)" + " " + textField.text!)
        if textField.tag == 2 {
            textField.text = textField.text?.uppercased()
            viewModels.fromCurrencyLabel.text = textField.text
            
            currentFromCurrency = textField.text!.uppercased()
        } else if textField.tag == 3 {
            textField.text = textField.text?.uppercased()
            viewModels.toCurrencyLabel.text = textField.text
            currentToCurrency = textField.text!.uppercased()
        }
        
        if textField.tag == 0 {
            currentSellAmount = textField.text!.floatValue
        }
        if textField.tag == 1 {
            currentBuyAmount = textField.text!.floatValue
        }
        if textField.tag == 4 {
            currentExchangeRate = 1.0 / textField.text!.floatValue
        }
        if textField.tag == 5 {
            currentExchangeRate = textField.text!.floatValue
        }
        
        if textField.tag <= 1 || textField.tag == 4 || textField.tag == 5 {
            var tag = textField.tag
            if tag == 5 || tag == 4 {
                tag = 2
            }
            if let index = changeLog.firstIndex(of: tag) {
                changeLog.remove(at: index)
            }
            changeLog.insert(tag, at: 0)
            
            if changeLog.count == 3 {
                recalculate()
            }
        }

        print("TextField should return method called")
    }
}
