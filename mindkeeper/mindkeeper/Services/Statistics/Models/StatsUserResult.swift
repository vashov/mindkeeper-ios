//
//  GetStatsUserResult.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 16.02.2022.
//

import Foundation

struct StatsUserResult: Decodable {
    let userId: UUID
    let ideasCreatedCount: Int64
    let achievementsCount: Int64
}
