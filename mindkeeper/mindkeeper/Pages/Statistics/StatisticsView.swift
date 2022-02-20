//
//  StatisticsView.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 17.02.2022.
//

import SwiftUI

struct StatisticsView: View {
    
    @ObservedObject var viewModel = StatisticsViewModel()
    
    var body: some View {
        LoadingView(isShowing: .constant(viewModel.isLoading)) {
            VStack {
                Header("Personal")
                
                StatisticsRow("Level", String(viewModel.level))
                StatisticsRow("Level progress", "\(viewModel.levelProgress)%")
                StatisticsRow("Ideas created", String(viewModel.ideasCreatedCount))
                    .padding(.top)
                
                Spacer()
                
                Header("System")
                
                StatisticsRow("Ideas created", String(viewModel.totalIdeasCount))
                StatisticsRow("Users registered", String(viewModel.totalUsersCount))
                
                Spacer()
            }
            .padding()
        }
        .onAppear(perform: viewModel.initialize)
    }
    
    private func StatisticsRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .padding(.trailing)
        }
        .padding(.horizontal)
    }
    
    private func Header(_ title: String) -> some View {
        VStack {
            Text(title)
                .bold()
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.black)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
