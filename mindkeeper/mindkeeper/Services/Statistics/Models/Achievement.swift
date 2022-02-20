//
//  Achievement.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 16.02.2022.
//

import Foundation

struct Achievement: Decodable, Hashable {
    public let id: Int32
    public let name: String
    public let description: String
    public let isSecret: Bool
}
