//
//  File.swift
//  appDemo
//
//  Created by Damien on 03/12/2021.
//

import Foundation

class ChoordsRepository {
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

}
