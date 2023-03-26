import Foundation

struct UserCreateQuery: Codable {
    // MARK: - Properties

    let user_id: Int
    let user_name: String
    let user_rating: Float

    // MARK: - Lifecycle

    init(
        user_id: Int,
        user_name: String,
        user_rating: Float
    ) {
        self.user_id = user_id
        self.user_name = user_name
        self.user_rating = user_rating
    }
}
