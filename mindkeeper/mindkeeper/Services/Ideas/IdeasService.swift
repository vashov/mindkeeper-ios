//
//  IdeaService.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 20.02.2022.
//

import Foundation
import Combine

class IdeasService {
    @Inject var httpRequestBuilder: HttpRequestBuilder
    @Inject var alertManager : AlertManager
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private func BuildUrl(_ endpoint: String) -> String {
        ApiConstants.apiUri + "idea/" + endpoint
    }
    
    func create(name: String, description: String) -> Future<Bool, AppError> {
        return Future<Bool, AppError> {[unowned self] promise in
            let urlPath = BuildUrl("create")
            var request = httpRequestBuilder.buildPost(urlPath)
            
            let json: [String: Any] = ["name": name, "description": description]
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
    
    func getIdea(ideaId: UUID) -> Future<IdeaListItem, AppError> {
        return Future<IdeaListItem, AppError> {[unowned self] promise in
            let urlPath = BuildUrl(ideaId.uuidString)
            
            // TODO: ideas filter.
            
            let request = httpRequestBuilder.buildGet(urlPath)
            
            HttpClient<ResponseData<IdeaListItem>>.sendRequest(request)
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
    
    func getAll(userId: UUID? = nil, name: String? = nil, parentId: UUID? = nil, ideas: [UUID] = []) -> Future<IdeaListResult, AppError> {
        return Future<IdeaListResult, AppError> {[unowned self] promise in
            let urlPath = BuildUrl("")
            
            var url = URLComponents(string: urlPath)!
            
            var queryItems: [URLQueryItem] = []
            if userId != nil {
                queryItems.append(URLQueryItem(name: "userId", value: userId!.uuidString))
            }
            if !(name ?? "").isEmpty {
                queryItems.append(URLQueryItem(name: "name", value: name!))
            }
            if parentId != nil {
                queryItems.append(URLQueryItem(name: "parentId", value: parentId!.uuidString))
            }
            
            // TODO: ideas filter.
            
            url.queryItems = queryItems
            
            let request = httpRequestBuilder.buildGet(url.string!)
            
            HttpClient<ResponseData<IdeaListResult>>.sendRequest(request)
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
