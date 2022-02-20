import Foundation
import Swinject

class Resolver {
    static let shared = Resolver()
    
    private let container: Container = {
        let container = Container()
        
        container.register(AccountsService.self) { _ in AccountsService() }
        container.register(UsersService.self) { _ in UsersService() }
        container.register(StatisticsService.self) { _ in StatisticsService() }
        container.register(IdeasService.self) { _ in IdeasService() }
        
        container.register(AppState.self) { _ in AppState() }
            .inObjectScope(ObjectScope.container)
        container.register(AlertManager.self) { _ in AlertManager() }
            .inObjectScope(ObjectScope.container)
        
        container.register(HttpRequestBuilder.self) { _ in HttpRequestBuilder() }
        
        return container
    }()
    
    func resolve<T>(_ type: T.Type) -> T {
        let service = container.resolve(T.self)
        
        if service == nil {
            print("Unresolved ", T.self)
        }
        
        return service!
    }
}
