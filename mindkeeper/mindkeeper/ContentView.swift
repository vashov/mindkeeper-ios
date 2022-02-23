import SwiftUI

struct ContentView: View {
    @ObservedObject
    var appState: AppState = Resolver.shared.resolve(AppState.self)
    
    @ObservedObject
    var alertManager: AlertManager = Resolver.shared.resolve(AlertManager.self)
    
    //    @EnvironmentObject var appState: AppState
    
    var body: some View {
        GetView()
            .alert(isPresented: $alertManager.isPresented) {
                Alert(title: Text(alertManager.dequeue().localizedDescription), dismissButton: .default(Text("Got it!")))
            }
    }
    
    private func GetView() -> some View {
        VStack {
            if appState.isLoggedIn {
                MenuView()
            } else {
                SignInView()
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
