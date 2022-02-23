import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    @Inject
    var authRepository: AccountsService
    
    @Inject var alertManager: AlertManager
    
    @Published var login = ""
    @Published var password = ""
    @Published var passwordRepeat = ""
    
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
        Publishers.CombineLatest(isPasswordEmptyPublisher, arePasswordsEqualPublisher)
            .map { isPasswordEmpty, arePasswordsEqual in
                return isPasswordEmpty || !arePasswordsEqual ?
                    PasswordCheck.invalid : PasswordCheck.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
//            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { password in
                return password.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordRepeat)
//            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { password, passwordRepeat in
                return password == passwordRepeat
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidUsernamePublisher: AnyPublisher<UsernameCheck, Never> {
        $login
//            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                let isValid = !input.isEmpty
                return isValid ? UsernameCheck.valid
                    : UsernameCheck.invalid
            }
            .eraseToAnyPublisher()
    }

    func registrationRequest(successCallback: @escaping () -> Void) {
        if !isValidForm {
            return
        }

        isLoading = true

        authRepository.register(login, password)
            .sink(receiveCompletion: { [unowned self] completion in
                if case let .failure(error) = completion {
                    alertManager.enqueue(error)
                }
                isLoading = false
            }, receiveValue: { [unowned self] data in
                if data {
                    successCallback()
                } else {
                    print("Some error in registration request.")
                }
                isLoading = false
            })
            .store(in: &self.cancellableSet)
    }
}
