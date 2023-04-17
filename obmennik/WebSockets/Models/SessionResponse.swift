import Foundation


struct SessionResponse: Codable {
    let responseType: String
    let session: SessionQuery?
    let message: MessageQuery?
    
    init(
        responseType: String,
        session: SessionQuery?,
        message: MessageQuery?
    ) {
        self.responseType = responseType
        self.session = session
        self.message = message
    }
}

