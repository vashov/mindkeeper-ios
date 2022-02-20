import Foundation
import Combine

class AlertManager: ObservableObject {
    @Published var isPresented = false

    private var queues: [Error] = []
    private var cancellable: AnyCancellable?

    init() {
        cancellable = $isPresented
            .filter({ [weak self] isPresented in
                guard let self = self else {
                    return false
                }
                return !isPresented && !self.queues.isEmpty
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.isPresented = true
            })
    }

    func enqueue(_ alert: Error) {
        queues.append(alert)
        DispatchQueue.main.async {
            self.isPresented = true
        }
        
    }

    func dequeue() -> Error {
        queues.removeFirst()
    }
}
