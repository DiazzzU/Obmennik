import UIKit

extension SessionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCellViewId", for: indexPath) as! FilterCellView
        cell.setupLayers(cellName: filterNames[indexPath.row])
        cell.layer.cornerRadius = 14
        cell.backgroundColor = ColorPalette.selectedFilter
        cell.textLabel.textColor = ColorPalette.mainOfferColor
        cell.upArrowImage.isHidden = true
        cell.downArrowImage.isHidden = true
        
        var sessionState: [SessionStruct.SessionState] = []
        var sessionType: [SessionStruct.SessionType] = []
        
        switch filterNames[0] {
        case "Open":
            sessionState = [SessionStruct.SessionState.open]
        case "Closed":
            sessionState = [SessionStruct.SessionState.closed]
        case "All":
            sessionState = [SessionStruct.SessionState.open, SessionStruct.SessionState.closed]
        default:
            sessionState = []
        }
        
        switch filterNames[1] {
        case "Incoming":
            sessionType = [SessionStruct.SessionType.incoming]
        case "Outcoming":
            sessionType = [SessionStruct.SessionType.outcoming]
        case "All":
            sessionType = [SessionStruct.SessionType.incoming, SessionStruct.SessionType.outcoming]
        default:
            sessionType = []
        }
        
        sessions = []
        
        for session in allSessions {
            if sessionState.contains(session.state) && sessionType.contains(session.type) {
                sessions.append(session)
            }
        }
        
        viewModels.sessionTableView.reloadData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            switch filterNames[0] {
            case "Open":
                filterNames[0] = "Closed"
            case "Closed":
                filterNames[0] = "All"
            case "All":
                filterNames[0] = "Open"
            default:
                filterNames[0] = ""
            }
        } else {
            switch filterNames[1] {
            case "Incoming":
                filterNames[1] = "Outcoming"
            case "Outcoming":
                filterNames[1] = "All"
            case "All":
                filterNames[1] = "Incoming"
            default:
                filterNames[1] = ""
            }
        }
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let filterName = filterNames[indexPath.row]
        let font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (filterName as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        return CGSize(width: size.width + 20, height: 27)
    }
}

extension SessionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCellId", for: indexPath) as! SessionCellView
        cell.backgroundColor = .clear
        cell.setupCell(data: sessions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentChatVC = ChatViewController()
        currentSession = self.sessions[indexPath.row]
        let selfSender = SenderStruct(senderId: "\(user!.id)", displayName: user!.name)
        currentChatVC!.setupData(session: self.sessions[indexPath.row], selfSender: selfSender, tabBarController: myTabBarController!)
        navigationController?.pushViewController(currentChatVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
