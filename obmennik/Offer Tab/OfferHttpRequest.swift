import UIKit

extension OfferViewController {
    func sendAddWatchlistRequest() {
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        
        networkService.addWatchlist(userId: user!.id, offerId: offer!.offerId) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    func sendRemoveWatchlistRequest() {
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        
        networkService.removeWatchlist(userId: user!.id, offerId: offer!.offerId) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
