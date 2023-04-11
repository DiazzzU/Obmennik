import UIKit

extension RenameViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("\(textField.tag)" + " " + textField.text!)
        currentUserName = textField.text!
        print("TextField should return method called")
    }
}
