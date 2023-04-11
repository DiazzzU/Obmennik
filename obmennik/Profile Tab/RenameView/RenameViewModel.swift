import UIKit

class RenameViewModel {
    lazy var cancelButton: UIButton = {
        return setupCancelButton(tag: 0)
    }()
    lazy var titleLabel: UILabel = {
        return setupLabel(tag: 0, text: "Edit username")
    }()
    lazy var userNameField: UITextField = {
        return setupField(tag: 0)
    }()
    lazy var userNameLabel: UILabel = {
        let label = setupLabel(tag: 1, text: "Username")
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = ColorPalette.secondaryOfferColor
        return label
    }()
    lazy var saveChangesButton: UIButton = {
        return setupSaveChangesButton(tag: 1)
    }()
    
    func setupField(tag: Int) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.tag = tag
        textField.font = .boldSystemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = ColorPalette.selectedFilter
        textField.textColor = .white
        textField.clearButtonMode = .never
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 43))
        textField.leftView = leftView
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }
    
    func setupLabel(tag: Int, text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.tag = tag
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setupCancelButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(ColorPalette.close, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupSaveChangesButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("Save changes", for: .normal)
        button.setTitleColor(ColorPalette.backgroundMain, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = ColorPalette.yellow
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupData(user: UserStruct) {
        userNameField.text = user.name
    }

    func setupLayers(parrent: UIView, user: UserStruct) {
        parrent.addSubview(cancelButton)
        parrent.addSubview(titleLabel)
        parrent.addSubview(userNameField)
        parrent.addSubview(userNameLabel)
        parrent.addSubview(saveChangesButton)
        
        setupData(user: user)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            titleLabel.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 22),
            
            userNameField.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            userNameField.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            userNameField.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 58),
            userNameField.heightAnchor.constraint(equalToConstant: 44),
            
            userNameLabel.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 33),
            userNameLabel.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            saveChangesButton.heightAnchor.constraint(equalToConstant: 47),
            saveChangesButton.bottomAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveChangesButton.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            saveChangesButton.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
}
