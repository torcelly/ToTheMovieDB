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
    
    // MARK: - Movies
    
    public func movie(movieId: Int, language: String? = nil, completionBlock:  @escaping RequestEscaping<ToSearchMovie>) {
        let path = "movie/\(movieId)"
        var params: [String : Any?] = ["api_key" : apiKey]
        if language != nil {
            params["language"] = language! // ISO 639-1
        }
        
        Alamofire.request(self.requestPath(path), method: .get, parameters: self.normalizeParameters(params)).responseObject { (response: DataResponse<ToSearchMovie>) in
            let (value, error) = self.handleResponse(response)
            completionBlock(value, error)
        }
    }
    
    // Get Images
    public func moviePosters(_ movieId: Int, language: String? = nil, completionBlock:  @escaping RequestEscapingArray<ToImage>) {
        self.movieImages(movieId, language: language, keyValue: "posters", completionBlock: completionBlock)
    }
    
    public func movieBackdrops(_ movieId: Int, language: String? = nil, completionBlock:  @escaping RequestEscapingArray<ToImage>) {
        self.movieImages(movieId, language: language, keyValue: "backdrops", completionBlock: completionBlock)
    }
    
    public func tvPosters(_ tvId: Int, language: String? = nil, completionBlock:  @escaping RequestEscapingArray<ToImage>) {
        self.tvImages(tvId, language: language, keyValue: "posters", completionBlock: completionBlock)
    }
    
    public func tvBackdrops(_ tvId: Int, language: String? = nil, completionBlock:  @escaping RequestEscapingArray<ToImage>) {
        self.tvImages(tvId, language: language, keyValue: "backdrops", completionBlock: completionBlock)
    }
    
    private func movieImages(_ movieId: Int, language: String? = nil, keyValue: String, completionBlock:  @escaping RequestEscapingArray<ToImage>) {
        let path = "movie/\(movieId)/images"
        var params: [String : Any?] = ["api_key" : apiKey]
        if language != nil {
            params["language"] = language! // ISO 639-1
        }
        
        Alamofire.request(self.requestPath(path), method: .get, parameters: self.normalizeParameters(params)).responseArray(keyPath: keyValue) {
            (response: DataResponse<[ToImage]>) in
            let (value, error) = self.handleResponse(response)
            completionBlock(value, error)
        }
    }
    
    private func tvImages(_ tvId: Int, language: String? = nil, keyValue: String, completionBlock:  @escaping RequestEscapingArray<ToImage>) {
        let path = "tv/\(tvId)/images"
        var params: [String : Any?] = ["api_key" : apiKey]
        if language != nil {
            params["language"] = language! // ISO 639-1
        }
        
        Alamofire.request(self.requestPath(path), method: .get, parameters: self.normalizeParameters(params)).responseArray(keyPath: keyValue) {
            (response: DataResponse<[ToImage]>) in
            let (value, error) = self.handleResponse(response)
            completionBlock(value, error)
        }
    }
    
    // MARK: - Search
    
    public func searchMovie(query: String, page: Int? = nil, language: String? = nil, includeAdult: Bool = false, region: String? = nil, year: Int? = nil, releaseYear: Int? = nil, completionBlock:  @escaping RequestEscapingArray<ToSearchMovie>) {
        let params: [String : Any?] = ["api_key" : apiKey,
                          "language" : language, // ISO 639-1
                          "query" : query,
                          "page" : page,
                          "include_adult" : includeAdult == true ? "1" : "0",
                          "region" : region,
                          "year" : year,
                          "primary_release_year" : releaseYear]
        
        Alamofire.request(self.requestPath("search/movie"), method: .get, parameters: self.normalizeParameters(params)).responseArray(keyPath: "results") {
            (response: DataResponse<[ToSearchMovie]>) in
            let (value, error) = self.handleResponse(response)
            completionBlock(value, error)
        }
    }
    
    public func searchTV(query: String, page: Int? = nil, language: String? = nil, firstAirDateYear: Int? = nil, completionBlock:  @escaping RequestEscapingArray<ToSearchTV>) {
        let params: [String : Any?] = ["api_key" : apiKey,
                                       "language" : language, // ISO 639-1
            "query" : query,
            "page" : page,
            "first_air_date_year" : firstAirDateYear]
        
        Alamofire.request(self.requestPath("search/tv"), method: .get, parameters: self.normalizeParameters(params)).responseArray(keyPath: "results") {
            (response: DataResponse<[ToSearchTV]>) in
            let (value, error) = self.handleResponse(response)
            completionBlock(value, error)
        }
    }
    
    // MARK: - TV
    
    public func tvExternalIds(tvId: Int, language: String? = nil, completionBlock:  @escaping RequestEscaping<ToExternalID>) {
        let path = "tv/\(tvId)/external_ids"
        var params: [String : Any?] = ["api_key" : apiKey]
        if language != nil {
            params["language"] = language! // ISO 639-1
        }
        
        Alamofire.request(self.requestPath(path), method: .get, parameters: self.normalizeParameters(params)).responseObject { (response: DataResponse<ToExternalID>) in
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
