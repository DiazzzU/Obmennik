import Foundation

protocol NetworkService: AnyObject {
    func createUser(
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    )
}
