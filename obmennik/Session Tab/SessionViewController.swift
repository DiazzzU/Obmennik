import UIKit

class SessionViewController: UIViewController {
    var allSessions: [SessionStruct] = []
    var sessions: [SessionStruct] = []
    var user: UserStruct? = nil
    
    var viewModels = SessionViewModels()
    var currentChatVC: ChatViewController? = nil
    var currentSession: SessionStruct? = nil
    
    var myTabBarController: TabBarController? = nil
    
    var filterNames = ["Open", "Incoming"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundMain
        
        viewModels.setupLayers(parrent: view)
        setupFilterCollectionView()
        setupSessionTableView()
    }
    
    func setupSessionTableView() {
        viewModels.sessionTableView.dataSource = self
        viewModels.sessionTableView.delegate = self
    }
    
    func setupFilterCollectionView() {
        viewModels.filterCollectionView.dataSource = self
        viewModels.filterCollectionView.delegate = self
    }
    
    func setupData(tabBarController: TabBarController) {
        self.allSessions = tabBarController.sessions
        self.user = tabBarController.user
        self.myTabBarController = tabBarController
    }
    
    func updateSessions(sessions: [SessionStruct]) {
        self.allSessions = sessions
        self.viewModels.sessionTableView.reloadData()
        self.viewModels.filterCollectionView.reloadData()
    }
    
    func closeSession(sessionId: Int) {
        if currentSession != nil && currentSession?.id == sessionId && currentSession?.type == .outcoming && currentSession?.state == .open {
            currentSession?.state = .closed
            currentChatVC?.closeSession()
        }
    }
    
    func newMessage(message: MessageStruct) {
        if currentSession != nil && (currentSession!.id == message.sessionId || currentSession!.id == -1) {
            currentSession!.id = message.sessionId
            currentChatVC?.newMessage(message: message)
            currentChatVC!.session!.id = message.sessionId
        }
    }
}
