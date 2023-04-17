import UIKit

class FilterCellView: UICollectionViewCell {
    static let identifier = "filterCellViewId"
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = ColorPalette.secondaryOfferColor
        textLabel.font = .boldSystemFont(ofSize: 16)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Filter"
        return textLabel
    }()
    lazy var upArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "filterArrowUp")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = ColorPalette.backgroundMain
        return imageView
    }()
    lazy var downArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "filterArrowDown")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = ColorPalette.backgroundMain
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupData(cellName: String) {
        textLabel.text = cellName
    }
    
    func setupLayers(cellName: String) {
        self.addSubview(textLabel)
        self.addSubview(upArrowImage)
        self.addSubview(downArrowImage)
        setupData(cellName: cellName)
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
            textLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            upArrowImage.leadingAnchor.constraint(equalTo: textLabel.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            upArrowImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            downArrowImage.leadingAnchor.constraint(equalTo: textLabel.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            downArrowImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
