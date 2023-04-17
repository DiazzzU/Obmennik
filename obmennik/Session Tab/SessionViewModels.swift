import UIKit

class SessionViewModels {
    lazy var filterCollectionView: UICollectionView = {
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FilterCellView.self, forCellWithReuseIdentifier: FilterCellView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    lazy var sessionTableView: UITableView = {
        let t = UITableView()
        t.tag = 1
        t.showsVerticalScrollIndicator = false
        t.backgroundColor = .clear
        t.register(SessionCellView.self, forCellReuseIdentifier: SessionCellView.identifier)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    func setupLayers(parrent: UIView) {
        parrent.addSubview(filterCollectionView)
        parrent.addSubview(sessionTableView)
        
        NSLayoutConstraint.activate([
            filterCollectionView.heightAnchor.constraint(equalToConstant: 50),
            filterCollectionView.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 0),
            filterCollectionView.leadingAnchor.constraint(equalTo: parrent.leadingAnchor, constant: 24),
            filterCollectionView.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            sessionTableView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 0),
            sessionTableView.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            sessionTableView.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            sessionTableView.bottomAnchor.constraint(equalTo: parrent.bottomAnchor),
        ])
    }
}
