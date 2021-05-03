//
//  Pokeman.swift
//  DemoBuild
//
//  Created by Andy Geipel on 4/30/21.
//

import Foundation

struct Pokedex: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Results]
}

struct Results: Decodable {
    let name: String?
    let url: String?
}

struct Pokemon : Decodable {
    let weight: Int?
    let height: Int?
    let name: String?
    let order: Int?
    let base_experience: Int?
    let sprites: Sprite
    let moves: [MovesResults]
}

struct Sprite: Decodable {
    let front_default: String?
}

struct MovesResults: Decodable {
    var move: Move
    var version_group_details: [VersionGroupResults]
}

struct VersionGroupResults: Decodable{
    var level_learned_at: Int?
}

struct VersionGroup: Decodable {
    var name: String?
}

struct Move: Decodable {
    var name: String?
}
