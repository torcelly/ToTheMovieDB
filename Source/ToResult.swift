//
//  ToResult.swift
//  ToTheMovieDB
//
//  Created by Fernando Torcelly on 27/8/17.
//  Copyright © 2017 Fernando Torcelly. All rights reserved.
//

import Foundation
import ObjectMapper

public class ToResult<T>: Mappable {
    var page: Int!
    var results: [T]!
    var totalResults: Int!
    var totalPages: Int!
    
    public required init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        page            <- map["page"]
        results         <- map["results"]
        totalResults    <- map["total_results"]
        totalPages      <- map["total_pages"]
    }
}
