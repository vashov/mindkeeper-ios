import Foundation

class MenuViewModel : ObservableObject {
    
    @Inject var usersRepository: UsersService
    @Inject var appState: AppState
    
    @Published var isLoading = false
    
    func initialize() {
//        loadMe()
        print("MenuViewModel initialized")
    }
    
    private func loadMe() {
        isLoading = true
        
        usersRepository.loadMe() { result in
            switch result {
            case .success(let user):
                print("User phone: " + String(user.phone))
                DispatchQueue.main.async {
                    self.appState.userId = user.id
                }
                

            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        print("loadMe executed")
    }
}
