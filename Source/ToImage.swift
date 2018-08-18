//
//  ToImage.swift
//  ToTheMovieDB
//
//  Created by Fernando Torcelly on 12/11/17.
//  Copyright © 2017 Fernando Torcelly. All rights reserved.
//

import Foundation
import ObjectMapper

public class ToImage: Mappable {
    public var aspectRatio: Double?
    public var filePath: String?
    public var height: Int?
    public var iso6391: String?
    public var voteAverage: Int?
    public var voteCount: Int?
    public var width: Int?
    
    public required init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        aspectRatio     <- map["aspect_ratio"]
        filePath        <- map["file_path"]
        height          <- map["height"]
        iso6391         <- map["iso_639_1"]
        voteAverage     <- map["vote_average"]
        voteCount       <- map["vote_count"]
        width           <- map["width"]
    }
}
