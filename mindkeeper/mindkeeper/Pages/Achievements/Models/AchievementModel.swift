//
//  Achievement.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 17.02.2022.
//

import Foundation

struct AchievementModel: Hashable {
    let id: Int32
    let name: String
    let description: String
    let isSecret: Bool
    var userGot: Bool
}
