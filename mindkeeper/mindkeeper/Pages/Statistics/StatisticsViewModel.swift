//
//  StatisticsViewModel.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 17.02.2022.
//

import Foundation
import Combine

class StatisticsViewModel: ObservableObject {
    
    @Inject var appState: AppState
    @Inject var statisticsRepository: StatisticsService
    
    @Published var isLoadingUserStatistics = false
    @Published var isLoadingSystemStatistics = false
    
    @Published var level: Int64 = 0
    @Published var levelProgress = 0.0
    @Published var ideasCreatedCount: Int64 = 0
    
    @Published var totalIdeasCount: Int64 = 0
    @Published var totalUsersCount: Int64 = 0
    
    private var cancellableSet: [AnyCancellable] = []
    
    var isLoading: Bool {
        isLoadingSystemStatistics || isLoadingUserStatistics
    }
    
    var isInitilized = false
    
    func initialize() {
        //        if isInitilized {
        //            return
        //        }
        //        isInitilized = true
        
        reload()
        
        print("Statistics initialized")
    }
    
    func reload() {
        loadUserStatistics()
        loadSystemStatistics()
    }
    
    private func loadUserStatistics() {
        isLoadingUserStatistics = true
        
        let userId = appState.userId
        statisticsRepository.getUserStatistics(userId: userId)
            .sink(receiveCompletion: { [unowned self] completion in
                if case let .failure(error) = completion {
                    print(error)
                }
                isLoadingUserStatistics = false
            }, receiveValue: { [unowned self] data in
                self.setUserStatistics(data)
                isLoadingUserStatistics = false
            })
            .store(in: &self.cancellableSet)
    }
    
    private func setUserStatistics(_ userStatistics: StatsUserResult) {
        DispatchQueue.main.async {
            self.level = (10 + userStatistics.ideasCreatedCount) / 10
            self.ideasCreatedCount = userStatistics.ideasCreatedCount
            self.levelProgress = Double(((10 + userStatistics.ideasCreatedCount)) - (self.level * 10)) / 10
        }
    }
    
    private func loadSystemStatistics() {
        isLoadingSystemStatistics = true
        
        statisticsRepository.getSystemStatistics()
            .sink(receiveCompletion: { [unowned self] completion in
                if case let .failure(error) = completion {
                    print(error)
                }
                isLoadingSystemStatistics = false
            }, receiveValue: { [unowned self] data in
                self.setSystemStatistics(data)
                isLoadingSystemStatistics = false
            })
            .store(in: &self.cancellableSet)
    }
    
    private func setSystemStatistics(_ systemStatistics: StatsSystemResult) {
        DispatchQueue.main.async {
            self.totalIdeasCount = systemStatistics.totalIdeasCount
            self.totalUsersCount = systemStatistics.totalUsersCount
        }
    }
}
