//
//  ToExternalID.swift
//  ToTheMovieDB
//
//  Created by Fernando Torcelly on 26/11/17.
//  Copyright © 2017 Fernando Torcelly. All rights reserved.
//

import Foundation
import ObjectMapper

public class ToExternalID: Mappable {
    public var imdbId: String?
    public var freebaseMId: Int?
    public var freebaseId: Int?
    public var tvRageId: Int?
    public var itemId: Int?
    public var tvdbId: Int?
    
    public required init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        imdbId          <- map["imdb_id"]
        freebaseMId     <- map["freebase_mid"]
        freebaseId      <- map["freebase_id"]
        tvRageId        <- map["tvrage_id"]
        itemId          <- map["id"]
        tvdbId          <- map["tvdb_id"]
    }
}
