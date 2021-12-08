//
//  File.swift
//  appDemo
//
//  Created by Damien on 29/11/2021.
//

import Foundation

protocol DataServiceProtocol {

    func getData() -> ApiData?
    func getAllKeys() -> [Key]
    func getChoordsForKey( key: Key) -> [Choord]
    func saveData(_ data: ApiData, completion: (ApiData) -> ())
}
class DataService: DataServiceProtocol {

    private var data : ApiData?
    func saveData(_ data: ApiData, completion: (ApiData) -> ()) {
        self.data = data
        completion(data)
    }

    func getData() -> ApiData? {
        return data
    }

    func getAllKeys() -> [Key] {
        return self.data?.allKeys ?? []
    }

    func getAllChoords() -> [Choord] {
        return self.data?.allChords ?? []
    }

    func getChoordsForKey( key: Key) -> [Choord] {
        guard let choords = self.data?.allChords else {
            return []
        }
        return choords.filter {
            key.keychordIds.contains($0.chordId)
        }
    }

}
