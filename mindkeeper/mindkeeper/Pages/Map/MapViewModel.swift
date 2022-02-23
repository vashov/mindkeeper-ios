import Foundation
import SwiftUI
import Combine

struct NodeModel {
    var node: Node
    var selection: SelectionHandler
}

class MapViewModel : ObservableObject {
    
    @Inject var appState: AppState
    @Inject var ideasService: IdeasService
    
    @Published var nodes: [NodeModel] = []
    
    @Published var showQueryDetailsPage = false
    
    @Published var isLoadingIdeas = false
    
    @Published var mesh: Mesh
    
    var selectionHandler = SelectionHandler()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        nodes = [
            NodeModel(node: Node(id: UUID(), position: .zero, text: "Some node 1"),
                      selection: SelectionHandler()),
            NodeModel(node: Node(id: UUID(), position: .zero, text: "Some node 2"),
                      selection: SelectionHandler()),
            NodeModel(node: Node(id: UUID(), position: .zero, text: "Some node 3"),
                      selection: SelectionHandler()),
            NodeModel(node: Node(id: UUID(), position: .zero, text: "Some node 4"),
                      selection: SelectionHandler())
        ]
        
        mesh = MapViewModel.sampleMesh()
    }
    
    func initialize() {
        print("MapViewModel initialize")
        loadIdeas()
    }
    
    static private func sampleMesh() -> Mesh {
      let mesh = Mesh()
      mesh.updateNodeText(mesh.rootNode(), string: "every human has a right to")
      [(0, "shelter"),
       (120, "food"),
       (240, "education")].forEach { (angle, name) in
        let point = mesh.pointWithCenter(center: .zero, radius: 200, angle: angle.radians)
        let node = mesh.addChild(mesh.rootNode(), at: point)
        mesh.updateNodeText(node, string: name)
      }
      return mesh
    }
    
    func loadIdeas() {
        isLoadingIdeas = true
        
        ideasService.getAll(userId: appState.userId)
            .sink(receiveCompletion: { completion in
                print(completion)
                self.isLoadingIdeas = false
            }, receiveValue: { ideasResult in
                self.generateMesh(ideasResult.ideas)
                self.isLoadingIdeas = false
            })
            .store(in: &cancellableSet)
//        queriesRepository.getAll() { result in
//            switch result {
//            case .success(let queries):
//                self.setQueries(queries)
//            case .failure(let error):
//                print(error)
//            }
//
//            DispatchQueue.main.async {
//                self.isLoadingQueries = false
//            }
//        }
    }
    
    private func generateMesh(_ ideas: [IdeaListItem]) {
        let mesh = Mesh()
        let child1 = Node(position: CGPoint(x: 100, y: 200), text: "child 1")
        let child2 = Node(position: CGPoint(x: -100, y: 200), text: "child 2")
        [child1, child2].forEach {
          mesh.addNode($0)
          mesh.connect(mesh.rootNode(), to: $0)
        }
        mesh.connect(child1, to: child2)
    }
}
