import Foundation

protocol NetworkService: AnyObject {
    func createUser(
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    )
    func getCurrencies(
        completion: @escaping (Result<[CurrencyGetQuery], Error>) -> Void
    )
}
