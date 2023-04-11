import UIKit

class SessionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundMain
        let button = UIButton()
        button.setTitle("CLICK", for: .normal)
        button.tintColor = .red
        button.frame = .init(x: view.frame.midX, y: view.frame.midY, width: 100, height: 100)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func handleButton() {
        let chatVC = ChatViewController()
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
