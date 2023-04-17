struct UserStruct: Codable{
    var name: String
    var rating: Float
    var id: Int
    var closedSessions: Int
    
    init(name: String, rating: Float, id: Int, closedSessions: Int) {
        self.name = name
        self.rating = rating
        self.id = id
        self.closedSessions = closedSessions
    }
    init(data: UserCreateQuery) {
        self.name = data.user_name
        self.rating = data.user_rating
        self.id = data.user_id
        self.closedSessions = data.closed_sessions
    }
}
