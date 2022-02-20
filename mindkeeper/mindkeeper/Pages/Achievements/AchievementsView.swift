//
//  AchievementsView.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 17.02.2022.
//

import SwiftUI

struct AchievementsView: View {
    
    @ObservedObject var viewModel = AchievementsViewModel()
    
    var body: some View {
        //        LoadingView(isShowing: !$viewModel.isCombinedAchievementsCreated) {
        ScrollView {
            if viewModel.achievements.isEmpty {
                Text("There are no achievements")
            }
            else {
                ForEach(viewModel.achievements, id: \.self) { a in
                    AchievementCardView(title: a.name,
                                        description: a.description,
                                        isSecret: a.isSecret,
                                        userGot: a.userGot)
                }
            }
        }
        .onAppear(perform: viewModel.initialize)
        //        }
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView()
    }
}
