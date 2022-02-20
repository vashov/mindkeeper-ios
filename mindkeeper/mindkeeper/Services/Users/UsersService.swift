 import Foundation

 struct UsersService {

    @Inject var httpRequestBuilder: HttpRequestBuilder
    
//    let session: URLSession
//    let baseUrl: String
//    let bgQueue = DispatchQueue(label: "bg_parse_queue")
//
//    init(session: URLSession, baseUrl: String) {
//        self.session = session
//        self.baseUrl = baseUrl
//    }

    func loadMe(completion: @escaping (Result<User, Error>) -> Void) {
        
        let urlPath = ApiConstants.apiUri + "users/me"
        let request = httpRequestBuilder.buildGet(urlPath)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode != 200 {
                let msg = "statusCode" + String(response.statusCode)
                print(msg)
                completion(.failure(ApiCodeError(description: msg)))
                return
            }

            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch let error {
                    print("Error decoding: ", error)
                    completion(.failure(error))
                }
            }
        }

        dataTask.resume()
    }
 }
