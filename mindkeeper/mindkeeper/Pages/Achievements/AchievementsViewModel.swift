//
//  AchievementsViewModel.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 17.02.2022.
//

import Foundation
import Combine

class AchievementsViewModel: ObservableObject {
    @Inject var appState: AppState
    @Inject var statisticsRepository: StatisticsService
    
    @Published var isLoadingAllAchievements = false
    @Published var isLoadingUserAchievements = false
    @Published var isCombinedAchievementsCreated = false
    
    @Published var level: Int64 = 0
    @Published var levelProgress = 0.0
    @Published var ideasCreatedCount: Int64 = 0
    
    @Published var totalIdeasCount: Int64 = 0
    @Published var totalUsersCount: Int64 = 0
    
    @Published private var allAchievements: [Achievement] = []
    @Published private var userAchievements: [Achievement] = []
    
    @Published var achievements: [AchievementModel] = []
    
    private var cancellableSet: [AnyCancellable] = []
    
    private var isAllAchievementsLoadedPublisher: AnyPublisher<Bool, Never> {
        $isLoadingAllAchievements
            .removeDuplicates()
            .map { isLoading in !isLoading }
            .eraseToAnyPublisher()
    }
    
    private var isUsersAchievementsLoadedPublisher: AnyPublisher<Bool, Never> {
        $isLoadingUserAchievements
            .removeDuplicates()
            .map { isLoading in !isLoading }
            .eraseToAnyPublisher()
    }
    
    private var isAchievementsLoadedPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isAllAchievementsLoadedPublisher, isUsersAchievementsLoadedPublisher)
            .map { isAllLoaded, isUsersLoaded in
                isAllLoaded && isUsersLoaded
            }
            .eraseToAnyPublisher()
    }
    
    
    var isLoading: Bool {
        isLoadingUserAchievements || isLoadingAllAchievements || !isCombinedAchievementsCreated
    }
    
    init() {
        Publishers.CombineLatest($allAchievements, $userAchievements)
//            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { all, users in
                // TODO: fix many updates.
                print("Sink in achievements")
                if all.isEmpty {
                    return
                }
                let result = AchievementsViewModel.JoinAchievements(users, all)
                self.achievements = Array(result).sorted(by: { $0.id < $1.id })
                self.isCombinedAchievementsCreated = true
            })
            .store(in: &cancellableSet)
    }
    
    private static func JoinAchievements(_ usersAchievements: [Achievement], _ allAchievements: [Achievement]) -> Set<AchievementModel> {
        var achievementSet: Set<AchievementModel> = []
        for i in 0..<allAchievements.endIndex {
            let achievement = allAchievements[i]
            let model = AchievementModel(id: achievement.id,
                                         name: achievement.name,
                                         description: achievement.description,
                                         isSecret: achievement.isSecret,
                                         userGot: false)
            achievementSet.update(with: model)
        }
        
        for i in 0..<usersAchievements.endIndex {
            let achievement = usersAchievements[i]
            let model = AchievementModel(id: achievement.id,
                                         name: achievement.name,
                                         description: achievement.description,
                                         isSecret: achievement.isSecret,
                                         userGot: true)
            achievementSet.update(with: model)
        }
        
        return achievementSet
//        self.achievements = Array(achievementSet)
    }
    
    var isInitilized = false
    
    func initialize() {
        //        if isInitilized {
        //            return
        //        }
        //        isInitilized = true
        
        reload()
        
        print("Achievements initialized")
    }
    
    func reload() {
        isCombinedAchievementsCreated = false
        loadAllAchivements()
        loadUserAchievements()
    }
    
    private func loadAllAchivements() {
        isLoadingAllAchievements = true
        
        statisticsRepository.getAchievements()
            .sink(receiveCompletion: { [unowned self] completion in
                if case let .failure(error) = completion {
                    print(error)
                }
                isLoadingAllAchievements = false
            }, receiveValue: { [unowned self] data in
                self.setAllAchievements(data)
                isLoadingAllAchievements = false
            })
            .store(in: &self.cancellableSet)
    }
    
    private func setAllAchievements(_ achievements: [Achievement]) {
        DispatchQueue.main.async {
            self.allAchievements = achievements
        }
    }
    
    private func loadUserAchievements() {
        isLoadingUserAchievements = true
        
        let userId = appState.userId
        
        statisticsRepository.getAchievements(userId: userId)
            .sink(receiveCompletion: { [unowned self] completion in
                if case let .failure(error) = completion {
                    print(error)
                }
                isLoadingUserAchievements = false
            }, receiveValue: { [unowned self] data in
                self.setUserAchievements(data)
                isLoadingUserAchievements = false
            })
            .store(in: &self.cancellableSet)
    }
    
    private func setUserAchievements(_ achievements: [Achievement]) {
        DispatchQueue.main.async {
            self.userAchievements = achievements
        }
    }
}
