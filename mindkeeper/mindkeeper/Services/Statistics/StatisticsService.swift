import Foundation
import Combine

class StatisticsService {
    
    @Inject var httpRequestBuilder: HttpRequestBuilder
    
    private var subscriptions: [AnyCancellable] = []
    
    ///api/Statistics/Achievements
    ///api/Statistics/Achievements/User?userId=
    ///api/Statistics/Stats/User?userId=
    ///api/Statistics/Stats/System

    private func BuildUrl(_ endpoint: String) -> String {
        ApiConstants.apiUri + "statistics/" + endpoint
    }
    
    func getAchievements() -> Future<[Achievement], AppError> {
        return Future<[Achievement], AppError> {[unowned self] promise in
            let urlPath = BuildUrl("achievements")
            let request = httpRequestBuilder.buildGet(urlPath)
            
            HttpClient<ResponseData<AchievementsResult>>.sendRequest(request)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let appError as AppError:
                            promise(.failure(appError))
                        default:
                            print("Unhandled error: \(error)")
                            promise(.failure(AppError.someError("Unhandled error")))
                        }
                    }
                }, receiveValue: { data in promise(.success(data.data.achievements))})
                .store(in: &self.subscriptions)
        }
    }
    
    func getAchievements(userId: UUID) -> Future<[Achievement], AppError> {
        return Future<[Achievement], AppError> {[unowned self] promise in
            let urlPath = BuildUrl("achievements/user")
            var url = URLComponents(string: urlPath)!
            url.queryItems = [
                URLQueryItem(name: "userId", value: userId.uuidString)
            ]

            let request = httpRequestBuilder.buildGet(url.string!)
            
            HttpClient<ResponseData<AchievementsResult>>.sendRequest(request)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let appError as AppError:
                            promise(.failure(appError))
                        default:
                            print("Unhandled error: \(error)")
                            promise(.failure(AppError.someError("Unhandled error")))
                        }
                    }
                }, receiveValue: { data in promise(.success(data.data.achievements))})
                .store(in: &self.subscriptions)
        }
    }
    
    func getUserStatistics(userId: UUID) -> Future<StatsUserResult, AppError> {
        return Future<StatsUserResult, AppError> {[unowned self] promise in
            let urlPath = BuildUrl("stats/user")
            var url = URLComponents(string: urlPath)!
            url.queryItems = [
                URLQueryItem(name: "userId", value: userId.uuidString)
            ]

            let request = httpRequestBuilder.buildGet(url.string!)
            
            HttpClient<ResponseData<StatsUserResult>>.sendRequest(request)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let appError as AppError:
                            promise(.failure(appError))
                        default:
                            print("Unhandled error: \(error)")
                            promise(.failure(AppError.someError("Unhandled error")))
                        }
                    }
                }, receiveValue: { data in promise(.success(data.data))})
                .store(in: &self.subscriptions)
        }
    }
    
    func getSystemStatistics() -> Future<StatsSystemResult, AppError> {
        return Future<StatsSystemResult, AppError> {[unowned self] promise in
            let urlPath = BuildUrl("stats/system")
            let request = httpRequestBuilder.buildGet(urlPath)
            
            HttpClient<ResponseData<StatsSystemResult>>.sendRequest(request)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let appError as AppError:
                            promise(.failure(appError))
                        default:
                            print("Unhandled error: \(error)")
                            promise(.failure(AppError.someError("Unhandled error")))
                        }
                    }
                }, receiveValue: { data in promise(.success(data.data))})
                .store(in: &self.subscriptions)
        }
    }
}
