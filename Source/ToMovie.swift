//
//  ToMovie.swift
//  ToTheMovieDB
//
//  Created by Fernando Torcelly on 27/8/17.
//  Copyright © 2017 Fernando Torcelly. All rights reserved.
//

import Foundation
import ObjectMapper

public class ToMovie: Mappable {
    var posterPath: String?
    var adult: Bool!
    var overview: String!
    var releaseDate: String!
    var genreIds: [Int]!
    var itemId: Int!
    var originalTitle: String!
    var originalLanguage: String!
    var title: String!
    var backdropPath: String?
    var popularity: Double!
    var voteCount: Int!
    var video: Bool!
    var voteAverage: Double!
    
    public required init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        posterPath          <- map["poster_path"]
        adult               <- map["adult"]
        overview            <- map["overview"]
        releaseDate         <- map["releaseDate"]
        genreIds            <- map["genreIds"]
        itemId              <- map["itemId"]
        originalTitle       <- map["friends"]
        originalLanguage    <- map["friends"]
        title               <- map["title"]
        backdropPath        <- map["backdrop_path"]
        popularity          <- map["popularity"]
        voteCount           <- map["vote_count"]
        video               <- map["video"]
        voteAverage         <- map["voteA_average"]
    }
}
