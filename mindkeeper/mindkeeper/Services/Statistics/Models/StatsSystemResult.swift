//
//  StatsSystemResult.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 16.02.2022.
//

import Foundation

struct StatsSystemResult : Decodable {
    let totalUsersCount: Int64
    let totalIdeasCount: Int64
}
