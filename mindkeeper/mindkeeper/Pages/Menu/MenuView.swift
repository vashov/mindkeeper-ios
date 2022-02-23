import SwiftUI

struct MenuView: View {
    
    var menuViewModel = MenuViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        
        let coloredAppearance = UINavigationBarAppearance()
          coloredAppearance.configureWithOpaqueBackground()
          coloredAppearance.backgroundColor = .white
          coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
          coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
          
          UINavigationBar.appearance().standardAppearance = coloredAppearance
          UINavigationBar.appearance().compactAppearance = coloredAppearance
          UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
          
          UINavigationBar.appearance().tintColor = .black
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
//                    Image(systemName: "house")
                    Label("Home", systemImage: "house")
                }
            
            MapSurfaceTabView()
                .tabItem {
//                    Image(systemName: "map")
                    Label("Map", systemImage: "map")
                }
        }
        .onAppear(perform: menuViewModel.initialize)
        
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
