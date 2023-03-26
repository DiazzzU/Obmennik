import Foundation

final class NetworkServiceImp: NetworkService {
    // MARK: - Properties
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    // MARK: - Public
    func createUser(
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createCreateUserRequest(),
            completion: completion
        )
    }

    // MARK: - Private

    private func createCreateUserRequest() -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/createUser/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            httpMethod: .post
        )
    }
}

// MARK: - Nested types

extension NetworkServiceImp {
    enum Constants {
        static let baseurl: String = "http://localhost:8000"
        static let contentTypeKey: String = "Content-type"
        static let contentTypeValue: String = "application/json"
    }
}
