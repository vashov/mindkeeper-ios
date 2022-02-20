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
    let createdAt: Date
    let createdBy: UUID
    let updatedAt: Date?
    let updatedBy: UUID?
    let parents: [UUID]
    let children: [UUID]
    let dependsOn: [UUID]
    let requiredFor: [UUID]
    let relatesTo: [UUID]
    let countries: [UUID]
    let subdomains: [UUID]
}



/**
 
 id    string($uuid)
 name    string
 nullable: true
 description    string
 nullable: true
 createdBy    string($uuid)
 createdAt    string($date-time)
 updatedBy    string($uuid)
 nullable: true
 updatedAt    string($date-time)
 nullable: true
 parents    [
 nullable: true
 readOnly: true
 string($uuid)]
 children    [
 nullable: true
 readOnly: true
 string($uuid)]
 dependsOn    [
 nullable: true
 readOnly: true
 string($uuid)]
 requiredFor    [
 nullable: true
 readOnly: true
 string($uuid)]
 relatesTo    [
 nullable: true
 readOnly: true
 string($uuid)]
 countries    [
 nullable: true
 readOnly: true
 string($uuid)]
 subdomains    [
 nullable: true
 readOnly: true
 string($uuid)]
 */
