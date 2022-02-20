import Foundation

class LeaderboardViewModel: ObservableObject {
    @Published var isLoading = false
    
    @Inject var statisticsRepository: StatisticsService
    @Inject var appState: AppState
    
    //@Published var usersStatistics: [UserStatistics] = []
    
    func initialize() {
        
        reload()
    }
    
    func reload() {
        isLoading = true
        
//        statisticsRepository.getTop() { result in
//            switch result {
//            case .success(let userStatistics):
//                self.usersStatistics.removeAll()
//                self.usersStatistics.append(contentsOf: userStatistics)
//
//            case .failure(let error):
//                print(error)
//            }
//
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//        }
    }
}
