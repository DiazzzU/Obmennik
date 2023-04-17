import UIKit

extension ProfileVieewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerCellId", for: indexPath) as! OfferCellView
        cell.backgroundColor = .clear
        cell.setupCell(data: userOffers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(userOffers[indexPath.row])
        let vc = OfferViewController()
        vc.setupData(homeVC: homeVC!, offer: userOffers[indexPath.row])
        let navVC = UINavigationController(rootViewController: vc)
        self.present(navVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
