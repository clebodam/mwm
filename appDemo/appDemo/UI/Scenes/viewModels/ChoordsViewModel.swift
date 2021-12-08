//
//  ChoordsViewModel.swift
//  appDemo
//
//  Created by Damien on 29/11/2021.
//

import Foundation

class ChoordsViewModel {

    private let repository:  ChoordsRepositoryProtocol!
    private var currentKey: Key?
    private var currentChoord: Choord?
    private var currentChoords = [Choord]()
    var loadBlock: (()->())?
    var errorBlock: (()->())?
    var loadChoordsBlock: (()->())?
    var loadChoordsDetailsBlock: ((Choord)->())?
    init(repository: ChoordsRepositoryProtocol) {
        self.repository = repository
    }

    private  func getData(completion: @escaping (ApiData) ->()) {
        self.repository.fetchData {  [unowned self] (data) in
            guard let data = data else {
                self.errorBlock?()
                return
            }
            completion(data)
        }
    }

    func getData() {
        getData { data in
            self.dispatch()
        }
    }

    func dispatch() {
        self.loadBlock?()
    }

    func keyForIndex(_ index: Int) -> Key? {
        let allKeys = self.repository.getAllKeys()
        if allKeys.count > index {
            return self.repository.getAllKeys()[index]
        }
        return nil
    }


    func getKeyNameForIndex(_ index: Int)-> String {
        return keyForIndex(index)?.name ?? ""
    }


    func choordForIndex( _ index: Int) -> Choord? {
        if self.currentChoords.count > index {
                return currentChoords[index]
            }

        return nil
    }

    func getChoordNameForIndex(_ index: Int)-> String {
        return choordForIndex(index)?.suffix ?? ""
    }

    func getKeyCount() -> Int {
        return self.repository.getAllKeys().count
    }

    func getChoords(key: Key) -> [Choord] {
        return self.repository.getChoordsForKey(key: key)
    }


    func getChoordsCount() -> Int {
        return self.currentChoords.count
    }

    func didSelectKey( _ key : Key) {
        self.currentKey = key
        self.currentChoords = self.repository.getChoordsForKey(key: key)
        self.loadChoordsBlock?()

    }

    func didSelectKeyIndex(_ index: Int) {
        if let key = keyForIndex(index) {
            didSelectKey(key)
        }
    }

    func didSelectChoordIndex(_ index: Int) {
        if let choord = choordForIndex(index) {
            didSelectChoord(choord)
        }
    }

    func didSelectChoord( _ choord: Choord) {

        self.currentChoord = choord
        self.loadChoordsDetailsBlock?(choord)
       
    }


}
