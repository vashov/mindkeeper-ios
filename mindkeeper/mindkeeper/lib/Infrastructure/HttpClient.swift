//
//  HttpClient.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 14.02.2022.
//

import Foundation
import Combine

public class HttpClient<T: Decodable> {
    
    static func sendRequest(_ request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                          var errorMsg: String = "Some error"
                          let alertManager = Resolver.shared.resolve(AlertManager.self)
                          do {
                              let errorResponse = try ApiJsonDecoder.instance
                                  .decode(Response.self, from: data)
                              errorMsg = errorResponse.message ?? errorMsg
                          } catch  {
                              print(error)
                              alertManager.enqueue(error)
                          }
                          
                          let error = AppError.someError(errorMsg)
                          alertManager.enqueue(error)
                          throw error
                      }
                return data
            }
            .decode(type: T.self, decoder: ApiJsonDecoder.instance)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
