//
//  ToSearchTV.swift
//  ToTheMovieDB
//
//  Created by Fernando Torcelly on 26/11/17.
//  Copyright © 2017 Fernando Torcelly. All rights reserved.
//

import Foundation
import ObjectMapper

public class ToSearchTV: Mappable {
    public var posterPath: String?
    public var popularity: Double!
    public var itemId: Int!
    public var backdropPath: String?
    public var voteAverage: Double!
    public var overview: String!
    public var firstAirDate: String!
    public var originCountry: [String]!
    public var genreIds: [Int]!
    public var originalLanguage: String!
    public var voteCount: Int!
    public var name: String!
    public var originalName: String!
    
    public required init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        posterPath          <- map["poster_path"]
        popularity          <- map["popularity"]
        itemId              <- map["id"]
        backdropPath        <- map["backdrop_path"]
        voteAverage         <- map["vote_average"]
        overview            <- map["overview"]
        firstAirDate        <- map["first_air_date"]
        originCountry       <- map["origin_country"]
        genreIds            <- map["genre_ids"]
        originalLanguage    <- map["original_language"]
        voteCount           <- map["vote_count"]
        name                <- map["name"]
        originalName        <- map["original_name"]
    }
}
