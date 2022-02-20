import Foundation
import Combine

class AccountsService {
    
    @Inject var httpRequestBuilder: HttpRequestBuilder
    
    private var subscriptions: Set<AnyCancellable> = []
    
//    let session: URLSession
//    let baseUrl: String
//    let bgQueue = DispatchQueue(label: "bg_parse_queue")
//
//    init(session: URLSession, baseUrl: String) {
//        self.session = session
//        self.baseUrl = baseUrl
//    }
    
    private func BuildUrl(_ endpoint: String) -> String {
        ApiConstants.apiUri + "account/" + endpoint
    }
    
    func register(_ login: String, _ password: String) -> Future<Bool, AppError> {
        return Future<Bool, AppError> {[unowned self] promise in
            let urlPath = BuildUrl("registration")
            var request = httpRequestBuilder.buildPost(urlPath)
            
            let json: [String: Any] = ["name": login, "password": password]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
            
            HttpClient<Response>.sendRequest(request)
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
                }, receiveValue: { data in promise(.success(data.succeeded))})
                .store(in: &self.subscriptions)
        }
    }
    
    func token(_ login: String, _ password: String) -> Future<AuthTokenResult, AppError> {
        return Future<AuthTokenResult, AppError> {[unowned self] promise in
            let urlPath = BuildUrl("token")
            var request = httpRequestBuilder.buildPost(urlPath)
            
            let json: [String: Any] = ["name": login, "password": password]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
            
            HttpClient<ResponseData<AuthTokenResult>>.sendRequest(request)
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
                }, receiveValue: { data in
                    promise(.success(data.data))
                })
                .store(in: &self.subscriptions)
        }
    }
}
