//
//  IdeaDetailsViewModel.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 20.02.2022.
//

import Foundation
import Combine

class IdeaDetailsViewModel : ObservableObject {
    
    private let nameMaxLength = 100
    private let descriptionMaxLength = 1000
    
    let id: UUID?
    
    @Inject var alertManager: AlertManager
    @Inject var ideaService: IdeasService
    
    @Published var isLoading: Bool = false
    
    @Published var name: String = "" {
        didSet {
            if name.count > nameMaxLength
            //                && oldValue.count <= nameMaxLength
            {
                name = oldValue
            }
        }
    }
    
    @Published var text: String = "" {
        didSet {
            if text.count > nameMaxLength
            //                && oldValue.count <= nameMaxLength
            {
                text = oldValue
            }
        }
    }
    
    @Published var isValidForm: Bool = false
    
    private var isValidFormPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidNamePublisher, isValidDescriptionPublisher)
            .map { isValidName, isValidDescription in
                isValidName && isValidDescription
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidNamePublisher: AnyPublisher<Bool, Never> {
        $name
            .map { value in
                !value.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidDescriptionPublisher: AnyPublisher<Bool, Never> {
        $text
            .map { value in
                !value.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    var isNewIdea: Bool {
        id == nil
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init (id: UUID? = nil) {
        self.id = id
        
        isValidFormPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidForm, on: self)
            .store(in: &cancellableSet)
    }
    
    
    func createIdea(onSuccess: @escaping () -> Void) {
        self.isLoading = true
        
        ideaService.create(name: self.name, description: self.text)
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [unowned self] completion in
                if case let .failure(error) = completion {
                    print(error)
                }
                self.isLoading = false
            }, receiveValue: { isOk in
                if isOk {
                    onSuccess()
                }
                self.isLoading = false
            })
            .store(in: &self.cancellableSet)
    }
    
    func updateIdea() {
        alertManager.enqueue(AppError.someError("Idea updating is not implemented yet."))
    }
}
