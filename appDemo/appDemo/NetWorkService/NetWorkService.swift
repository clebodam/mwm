//
//  NetWorkService.swift
//  appDemo
//
//  Created by Damien on 29/11/2021.
//

import Foundation

public enum NetworkError: Error {
    case badUrl
    case invalidStatusCode
    case invalidInPut
    case invalidResponse
    case noData
    case serialization
}

protocol NetWorkServiceProtocol {


    func fetchData(completion:  @escaping (ApiData?) -> ())
}


class NetWorkService: NetWorkServiceProtocol {
   
    
    static let CHOORDS_URL = "https://europe-west1-mwm-sandbox.cloudfunctions.net/midi-chords"
    var session: URLSession
    var sessionCfg: URLSessionConfiguration
    let decoder = JSONDecoder()
    private var currentTask: URLSessionDataTask?

    init() {
        sessionCfg = URLSessionConfiguration.default
        sessionCfg.timeoutIntervalForRequest = 10.0
        session = URLSession(configuration: sessionCfg)
    }

    func fetchData(completion: @escaping (ApiData?) -> ()) {
        self.getData { result in
            var data: ApiData?
            switch result {
            case .success(let response):
                data = response
            case .failure(let error):
                data = nil
                print("fetch apiData fail from intenet \(error)")
            }
            completion(data)
        }
    }


    internal func getData(url :String = NetWorkService.CHOORDS_URL ,callback: ((Result<ApiData, Error>) -> Void)?) {
        if let task = currentTask { task.cancel() }
        if let url = URL(string: url) {

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
               currentTask = session.dataTask(with: request, completionHandler: {  (data, response, error) in
                if let e = error {
                    callback?( Result.failure(e))
                }else {
                    if let r = response as? HTTPURLResponse {
                        if  r.statusCode == 200 {
                            guard let data = data  else {
                                callback?(Result.failure(NetworkError.noData))
                                return
                            }
                            do {
                                let responseObject  = try self.decoder.decode(ApiData.self, from: data)
                                print("NetWorkService - \(url) success : \(r.statusCode), response:\(responseObject)")
                                callback?(Result.success(responseObject))

                            } catch {
                                callback?(Result.failure(NetworkError.serialization))
                            }
                        }else {
                            callback?(Result.failure(NetworkError.invalidStatusCode))
                        }
                    }else {
                        callback?(Result.failure(NetworkError.invalidResponse))
                    }
                }
            })
            currentTask?.resume()
        }else {
            callback?(Result.failure(NetworkError.badUrl))
        }
    }

}
