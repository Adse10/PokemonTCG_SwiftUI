//
//  Card.swift
//  PokemonTCG_SwiftUI
//
//  Created by Adrián Bolaños Ríos on 27/04/2021.
//

import Foundation

struct Cards: Codable {
    let cards: [Card]
    
    enum CodingKeys: String, CodingKey {
        case cards = "data"
    }
}

struct CardDetail: Codable {
    let card: Card
    
    enum CodingKeys: String, CodingKey{
        case card = "data"
    }
}

struct Card: Codable, Identifiable {
    var id: String
    var name: String?
    var supertype: String?
    var hp: String?
    var number: String?
    var artist: String?
    var rarity: String?
    var subtypes: [String]?
    var types: [String]?
    var attacks: [Attack]?
    var weaknesses: [Weakness]?
    var images: Images?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case supertype
        case hp
        case number
        case artist
        case rarity
        case subtypes
        case types
        case attacks
        case weaknesses
        case images
    }
    
    init(){
      self.id = ""
    }
}


struct Attack: Codable {
    let name: String?
    let cost: [String]?
    let convertedEnergyCost: Int?
    let damage: String?
    let textAttack: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case cost
        case convertedEnergyCost
        case damage
        case textAttack = "text"
    }
}

struct Weakness: Codable {
    let type: String?
    let valueType: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case valueType = "value"
    }
}

struct Images: Codable {
    let small: String
    let large: String
}
