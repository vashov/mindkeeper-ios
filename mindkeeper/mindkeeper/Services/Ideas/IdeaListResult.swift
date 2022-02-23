//
//  Idea.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 20.02.2022.
//

import Foundation

struct IdeaListResult: Decodable {
    let ideas: [IdeaListItem]
}

struct IdeaListItem: Decodable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let createdAt: String
    let createdBy: UUID
    let updatedAt: String?
    let updatedBy: UUID?
    let parents: [UUID]
    let children: [UUID]
    let dependsOn: [UUID]
    let requiredFor: [UUID]
    let relatesTo: [UUID]
    let countries: [UUID]
    let subdomains: [UUID]
}
