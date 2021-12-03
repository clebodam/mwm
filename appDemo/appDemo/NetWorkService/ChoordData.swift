//
//  ChoordData.swift
//  appDemo
//
//  Created by Damien on 29/11/2021.
//

import Foundation



struct ApiData: Decodable {
    var allKeys: [Key]
    var allChords:  [Choord]

    private enum CodingKeys : String, CodingKey {
        case allkeys = "allkeys"
        case allChords = "allchords"
    }

    public  init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.allKeys = try values.decode([Key].self, forKey: .allkeys)
        self.allChords = try values.decode([Choord].self, forKey: .allChords)
    }

    public init( allKeys: [Key], allChords:[Choord]) {
        self.allChords = allChords
        self.allKeys = allKeys
    }
}

struct Key: Decodable {
    var keyId: Int
    var keychordIds: [Int]
    var name: String

    private enum CodingKeys : String, CodingKey {
        case keyId = "keyid"
        case name = "name"
        case keychordIds = "keychordids"
    }

    
}

struct Choord: Decodable {
    var midi: [Int]
    var suffix: String
    var fingers: [Int]
    var chordId: Int

    private enum CodingKeys : String, CodingKey {
        case midi = "midi"
        case suffix = "suffix"
        case fingers = "fingers"
        case chordId = "chordid"
    }
}
