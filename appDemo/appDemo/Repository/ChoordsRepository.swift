//
//  File.swift
//  appDemo
//
//  Created by Damien on 03/12/2021.
//

import Foundation

protocol ChoordsRepositoryProtocol {
    func fetchData(completion: @escaping (ApiData?) -> ())
    func getAllKeys() -> [Key]
    func getAllChoords() -> [Choord]
    func getChoordsForKey( key: Key) -> [Choord]
}
class ChoordsRepository: ChoordsRepositoryProtocol {
    let networkService : NetWorkServiceProtocol!
    let dataService: DataServiceProtocol!
    init(networkService: NetWorkServiceProtocol, dataService: DataServiceProtocol) {
        self.dataService = dataService
        self.networkService = networkService
    }

    func fetchData(completion: @escaping (ApiData?) -> ()) {
        if self.dataService.getAllKeys().count == 0 {
            self.networkService.fetchData { data in
                guard let data = data else {
                    completion(nil)
                    return
                }
                self.dataService.saveData(data) { data in
                    completion(data)
                }
            }
        } else {
            completion( self.dataService.getData())
        }
    }

    func getAllKeys() -> [Key] {
        return self.dataService.getData()?.allKeys ?? []
    }

    func getAllChoords() -> [Choord] {
        return self.dataService.getData()?.allChords ?? []
    }

    func getChoordsForKey( key: Key) -> [Choord] {
        guard let choords = self.dataService.getData()?.allChords else {
            return []
        }
        return choords.filter {
            key.keychordIds.contains($0.chordId)
        }
    }

}
