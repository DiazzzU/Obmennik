//
//  HomeViewController.swift
//  obmennik
//
//  Created by Dias Ussenov on 21.03.2023.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModels: HomeViewModels = HomeViewModels()
    var filterNames = ["Rating", "Amount", "Exchange rate"]
    var selectedFilterIndex = -1
    var selectedFilterState = 0
    
    
    
    // MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundMain
        setupLayers()
        
        viewModels.watchlistTabButton.addTarget(self, action: #selector(handleWatchlistButton), for: .touchUpInside)
        viewModels.offerTabButton.addTarget(self, action: #selector(handleOfferButton), for: .touchUpInside)
        viewModels.myTable.delegate = self
        viewModels.myTable.dataSource = self
        viewModels.myCollection.delegate = self
        viewModels.myCollection.dataSource = self
        
    }
    
    
    
    
    // MARK: - Funcrions
    
    private func setupLayers() {
        viewModels.setupLayers(parrent: view)
    }
    
    @objc func handleWatchlistButton(button: UIButton) {
        viewModels.changeOfferButtonState(offerButton: viewModels.offerTabButton)
        viewModels.changeWatchlistButtonState(watchlistButton: viewModels.watchlistTabButton)
    }
    @objc func handleOfferButton(button: UIButton) {
        viewModels.changeOfferButtonState(offerButton: viewModels.offerTabButton)
        viewModels.changeWatchlistButtonState(watchlistButton: viewModels.watchlistTabButton)
    }
}
