//
//  MockData.swift
//  appDemoTests
//
//  Created by Damien on 03/12/2021.
//

import Foundation
@testable import appDemo
class MockData {

    static func getFakeData() -> ApiData {
        var keys = [Key]()
        var choords = [Choord]()
        for i in 1...10 {
            let chords_ids = Array(1...10).map {
                $0 * i
            }
            let key = Key(keyId: i, keychordIds: chords_ids, name: "\(i)")
            keys.append(key)
        }

        for i in 1...100 {
            let frets = Array(1...6)
            let fingers: [Int] = frets.map { _ in return Int.random(in: 0..<5)}
            let choord = Choord(midi: Array(1...6), suffix: "\(i)", fingers: fingers , chordId: i)
            choords.append(choord)
        }

        return ApiData(allKeys: keys, allChords: choords)
    }
}
