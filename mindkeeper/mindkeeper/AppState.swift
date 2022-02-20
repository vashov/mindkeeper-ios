import Foundation
import JWTDecode

class AppState: ObservableObject {
    
    @Published var isLoggedIn = false
    var accessToken: String = ""
    var bearerAccessToken: String {
        get {
            "Bearer \(accessToken)"
        }
    }
    
    var userId: UUID = UUID()
    var login: String = ""
    
    //    @Published var userData = UserData()
    //    @Published var routing = ViewRouting()
    //    @published var system = System()
    
    func signIn(token: String, login: String) {
        
        let jwt = try! decode(jwt: token)
        let userId = UUID(uuidString: jwt.claim(name: "user_id").string!)!
        
        self.login = login
        self.accessToken = token
        self.userId = userId
        self.isLoggedIn = true
    }
    
    func signOut() {
        login = ""
        accessToken = ""
        userId = UUID()
        isLoggedIn = false
    }
}
