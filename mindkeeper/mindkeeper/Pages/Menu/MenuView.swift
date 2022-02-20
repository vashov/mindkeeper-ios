import SwiftUI

struct MenuView: View {
    
    var menuViewModel = MenuViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
//                    Label("Home", systemImage: "house")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
//                    Label("Map", systemImage: "map")
                }
//            LeaderboardView()
//                .tabItem {
//                    Image(systemName: "crown")
////                    Label("Top", systemImage: "crown")
//                }
        }
        .onAppear(perform: menuViewModel.initialize)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
