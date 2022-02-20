import Foundation

class HttpRequestBuilder {
    
    @Inject
    var appState: AppState
    
//    init(_ appState: AppState) {
//        self.appState = appState
//    }
    
    func buildPost(_ urlPath: String) -> URLRequest {
        var request = buildRequest(urlPath)
        request.httpMethod = "POST"
        request.addJsonContentHeaders()
        
        return request
    }
    
    func buildGet(_ urlPath: String) -> URLRequest {
        var request = buildRequest(urlPath)
        request.httpMethod = "GET"
        
        return request
    }
    
    private func buildRequest(_ urlPath: String) -> URLRequest {
        let url = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        
        if !appState.accessToken.isEmpty {
            request.addAuthorizationHeader(token: appState.bearerAccessToken)
        }
        
        return request
    }
}

extension URLRequest {
    mutating func addJsonContentHeaders() {
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    mutating func addAuthorizationHeader(token: String) {
        self.addValue(token, forHTTPHeaderField: "Authorization")
    }
}
