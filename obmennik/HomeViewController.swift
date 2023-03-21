//
//  HomeViewController.swift
//  obmennik
//
//  Created by Dias Ussenov on 21.03.2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }
    
    private func configureItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil
        )
    }
}
