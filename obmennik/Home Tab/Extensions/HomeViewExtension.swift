import UIKit


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerCellId", for: indexPath) as! OfferCellView
        cell.setupCell(data: offers[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UICollectionView()
//        return headerView
//    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCellViewId", for: indexPath) as! FilterCellView
        cell.setupLayers(cellName: filterNames[indexPath.row])
        if selectedFilterIndex == indexPath.row {
            cell.layer.cornerRadius = 14
            cell.backgroundColor = ColorPalette.selectedFilter
            if selectedFilterState == 0 {
                cell.upArrowImage.tintColor = ColorPalette.mainOfferColor
            } else {
                cell.downArrowImage.tintColor = ColorPalette.mainOfferColor
            }
        } else {
            cell.layer.cornerRadius = 14
            cell.backgroundColor = .clear
            cell.upArrowImage.tintColor = ColorPalette.backgroundMain
            cell.downArrowImage.tintColor = ColorPalette.backgroundMain
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if selectedFilterIndex == indexPath.row {
            selectedFilterState = 1 - selectedFilterState
        } else {
            selectedFilterIndex = indexPath.row
            selectedFilterState = 0
        }
        viewModels.offerTableView.reloadData()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let filterName = filterNames[indexPath.row]
        let font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (filterName as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        return CGSize(width: size.width + 40, height: 27)
    }
}
