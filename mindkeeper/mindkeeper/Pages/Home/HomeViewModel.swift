import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    private var statisticsModel = StatisticsModel()
    
    @Inject var appState: AppState
    @Inject var statisticsRepository: StatisticsService
    
    @Published var level: Int64 = 0
    @Published var levelProgress = 0.0
    @Published var ideasCreatedCount: Int64 = 0
    
    var isInitilized = false
    @Published var currentTasks: [TaskModel] = [TaskModel]()
    
    @Published var isLoadingStatistics = false

    var isLoading: Bool {
        isLoadingStatistics
    }
    
    var userLogin: String {
        appState.login
    }
    
    private var cancellableSet: [AnyCancellable] = []
    
    func initialize() {
        if isInitilized {
            return
        }
        isInitilized = true
        
        reload()
        
        print("Home initialized")
    }
    
    func reload() {
        loadStatistics()
    }
    
    func signOut() {
        appState.signOut()
    }
    
    private func loadStatistics() {
        isLoadingStatistics = true
        
        let userId = appState.userId
        statisticsRepository.getUserStatistics(userId: userId)
            .sink(receiveCompletion: { [unowned self] completion in
                if case let .failure(error) = completion {
                    print(error)
                }
                isLoadingStatistics = false
            }, receiveValue: { [unowned self] data in
                self.setStatistics(data)
                isLoadingStatistics = false
            })
            .store(in: &self.cancellableSet)
    }
    
    private func setStatistics(_ userStatistics: StatsUserResult) {
        DispatchQueue.main.async {
            self.level = (10 + userStatistics.ideasCreatedCount) / 10
            self.ideasCreatedCount = userStatistics.ideasCreatedCount
            self.levelProgress = Double(((10 + userStatistics.ideasCreatedCount)) - (self.level * 10)) / 10
        }
    }
    
}

struct TaskModel : Identifiable {
    var id = UUID()
    var queryId: Int
    var title: String
    var date: String
}
