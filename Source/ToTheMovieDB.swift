//
//  ToTheMovieDB.swift
//  ToTheMovieDB
//
//  Created by Fernando Torcelly on 27/8/17.
//  Copyright © 2017 Fernando Torcelly. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

public class ToTheMovieDB {

    public typealias RequestEscaping <T> = (T?, NSError?) -> ()
    public typealias RequestEscapingArray <T> = ([T]?, NSError?) -> ()
    
    public static let shareInstance = ToTheMovieDB()
    private init() {}
    
    private var baseURL = "https://api.themoviedb.org/3"
    public var apiKey = ""
    
    // MARK: - Search
    
    public func searchMovie(query: String, page: Int? = nil, language: String? = nil, includeAdult: Bool = false, region: String? = nil, year: Int? = nil, releaseYear: Int? = nil, completionBlock:  @escaping RequestEscapingArray<ToMovie>) {
        let params: [String : Any?] = ["api_key" : apiKey,
                          "language" : language, // ISO 639-1
                          "query" : query,
                          "page" : page,
                          "include_adult" : includeAdult == true ? "1" : "0",
                          "region" : region,
                          "year" : year,
                          "primary_release_year" : releaseYear]
        
        Alamofire.request(self.requestPath("search/movie"), method: .get, parameters: self.normalizeParameters(params)).responseArray(keyPath: "results") {
            (response: DataResponse<[ToMovie]>) in
            let (value, error) = self.handleResponse(response)
            completionBlock(value, error)
        }
    }
    
    // MARK: - Private
    
    private func handleResponse<T>(_ response: DataResponse<T>) -> (T?, NSError?) {
        switch response.result {
        case .success(_):
            if let value = response.result.value {
                return (value, nil)
            }
            else {
                let unknownError = NSError.init(domain: "Unknown Error", code: 700, userInfo: nil)
                return (nil, unknownError)
            }
        case .failure(let error):
            return (nil, error as NSError?)
        }
    }
    
    private func normalizeParameters(_ parameters: [String : Any?]) -> [String : String] {
        var output : [String : String] = [:]
        for (key, value) in parameters {
            if let valueVarArg = value as? CVarArg {
                output[key] = String.init(format: "%@", valueVarArg)
            }
        }
        return output
    }
    
    private func requestPath(_ path:String) -> String {
        return self.baseURL + "/" + path
    }
}
