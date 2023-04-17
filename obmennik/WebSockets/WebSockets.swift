import Foundation

class WSManager {
    public static let shared = WSManager() // создаем Синглтон
    private init(){}
    
    var webSocketTask: URLSessionWebSocketTask? = nil
    var tabBarController: TabBarController? = nil
    
    public func connectToWebSocket(user: UserStruct, tabBarController: TabBarController) {
        webSocketTask = URLSession(configuration: .default).webSocketTask(with: URL(string: "ws://127.0.0.1:8000/ws/\(user.id)/")!)
        webSocketTask!.resume()
        self.tabBarController = tabBarController
        self.receiveData()
    }
    
    func receiveData() {
        webSocketTask!.receive { result in
        switch result {
            case .failure(let error):
              print("Error in receiving message: \(error)")
            case .success(let message):
              switch message {
              case .string(let text):
                  let unwrappedData = Data(text.utf8)
                  do {
                      let data = try JSONDecoder().decode(SessionResponse.self, from: unwrappedData)
                      if data.responseType == "sessionCreated" {
                          DispatchQueue.main.async { [weak self] in
                              guard let self = self else { return }
                              self.tabBarController!.addSession(session: data.session!)
                          }
                      }
                      else if data.responseType == "messageSent" {
                          DispatchQueue.main.async { [weak self] in
                              guard let self = self else { return }
                              self.tabBarController!.addMessage(message: data.message!)
                          }
                      }
                      else if data.responseType == "sessionClosed" {
                          DispatchQueue.main.async { [weak self] in
                              guard let self = self else { return }
                              self.tabBarController!.closeSession(sessionId: data.session!.sessionId)
                          }
                      }
                  } catch {
                      print(error)
                  }
              case .data(let data):
                  print("Received data: \(data)")
              @unknown default:
                debugPrint("Unknown message")
              }
              self.receiveData()
        }
      }
    }
}
