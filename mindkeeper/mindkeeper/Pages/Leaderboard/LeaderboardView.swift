import SwiftUI

struct LeaderboardView: View {
    
    @ObservedObject var viewModel = LeaderboardViewModel()
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                NavigationView {
                    ZStack {
                        LogoBackgroundView()
                        VStack {
//                            ForEach(viewModel.usersStatistics, id: \.self) { stat in
//                                HStack {
//                                    Text("\(stat.place).")
//                                        .bold()
//                                    Text("User ID \(stat.userId)")
//                                    Spacer()
//                                    Image(systemName: "rosette")
//                                    Text(String(stat.createdObjectives + stat.finishedObjectives))
//                                }
//                                .padding()
//                                .shadow(radius: 5)
//                            }
                            Spacer()
                        }
                        .navigationTitle("Leaderboard")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: viewModel.reload) {
                                    Image(systemName: "goforward")
                                }
                                
                            }
                        }
                    }
                }
            }
            .onAppear(perform: viewModel.initialize)
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
