import Foundation
import Swinject
import Combine

class SignInViewModel: ObservableObject {
    @Inject
    var authRepository: AccountsService
    
    @Inject
    var appState: AppState
    
    @Published var login = ""
    @Published var password = ""
    @Published var showSignUp = false
    @Published var isLoading = false
    @Published var isValidForm = false
    
    var isButtonDisabled: Bool {
        !isValidForm || isLoading
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        isValidFormPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidForm, on: self)
            .store(in: &cancellableSet)
    }
    
    private var isValidFormPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidUsernamePublisher, isValidPasswordPublisher)
            .map { isValidUsername, isValidPassword in
                isValidUsername == .valid && isValidPassword == .valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidPasswordPublisher: AnyPublisher<PasswordCheck, Never> {
        $password
//            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                let isValid = !input.isEmpty
                return isValid ? PasswordCheck.valid
                    : PasswordCheck.invalid
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidUsernamePublisher: AnyPublisher<UsernameCheck, Never> {
        $login
//            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                let isValid = !input.isEmpty
                return isValid ? UsernameCheck.valid
                    : UsernameCheck.invalid
            }
            .eraseToAnyPublisher()
    }

    func loginRequest() {
        if !isValidForm {
            return
        }

        self.isLoading = true

        authRepository.token(login, password)
            .sink(receiveCompletion: { [unowned self] completion in
                if case let .failure(error) = completion {
                    print(error)
                }
                self.isLoading = false
            }, receiveValue: { [unowned self] data in
                appState.signIn(token: data.accessToken, login: login)
                self.isLoading = false
            })
            .store(in: &self.cancellableSet)
    }
}
