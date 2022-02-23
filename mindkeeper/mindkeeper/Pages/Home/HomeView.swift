import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        LoadingView(isShowing: .constant(viewModel.isLoading)) {
            NavigationView {
                ZStack {
                    LogoBackgroundView()
                    ScrollView {
                        VStack {
                            NavigationLink(destination: StatisticsView()) {
                                HStack {
                                    //                            Image(systemName: "crown")
                                    Text("level")
                                    Text(String(viewModel.level))
                                    ProgressBar(value: $viewModel.levelProgress)
                                    Image(systemName: "rosette")
                                    Text(String(viewModel.ideasCreatedCount))
                                }
                                .padding()
                            }
                            NavigationLink(destination: AchievementsView(), label: { Text("Achievements") })
                                .buttonStyle(MainButtonStyle())
                                .padding(.top)
                            
                            Button(action: {}, label: { Text("Favorites") })
                                .buttonStyle(MainButtonStyle())
                                .padding(.top)
                            
                            Button(action: {}, label: { Text("Recommendations") })
                                .buttonStyle(MainButtonStyle())
                                .padding(.top)
                        }
                        .onAppear(perform: viewModel.initialize)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: viewModel.reload) {
                                Image(systemName: "goforward")
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Text(viewModel.userLogin)
                                Button(action: viewModel.signOut) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                }
                            }
                        }
                    }
                    getCreateIdeaButton()
                }
                .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .accentColor(.black)
    }
    
    private func getCreateIdeaButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    NavigationLink(destination: IdeaDetailsView()) {
                        Text("idea")
                    }
                    .buttonStyle(CreateIdeaButtonStyle())
                }
            }
            .padding()
            .padding(.trailing)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
