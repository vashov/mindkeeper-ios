//
//  MapSurfaceTab.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 22.02.2022.
//

import SwiftUI

struct MapSurfaceTabView: View {
    @Inject var appState: AppState
    @ObservedObject var viewModel = MapViewModel()
    
    var body: some View {
        LoadingView(isShowing: .constant(viewModel.isLoadingIdeas)) {
            NavigationView {
//                VStack{
                SurfaceView(mesh: viewModel.mesh, selection: viewModel.selectionHandler)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {}) {
                                Image(systemName: "goforward")
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "slider.horizontal.3")
                                }
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
                    .onAppear(perform: viewModel.initialize)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct MapSurfaceTabView_Previews: PreviewProvider {
    static var previews: some View {
        MapSurfaceTabView()
    }
}
