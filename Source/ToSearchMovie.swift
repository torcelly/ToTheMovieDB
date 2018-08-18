//
//  ToSearchMovie.swift
//  ToTheMovieDB
//
//  Created by Fernando Torcelly on 27/8/17.
//  Copyright © 2017 Fernando Torcelly. All rights reserved.
//

import Foundation
import ObjectMapper

public class ToSearchMovie: Mappable {
    public var posterPath: String?
    public var adult: Bool!
    public var overview: String!
    public var releaseDate: String!
    public var genreIds: [Int]!
    public var imdbId: String!
    public var itemId: Int!
    public var originalTitle: String!
    public var originalLanguage: String!
    public var title: String!
    public var backdropPath: String?
    public var popularity: Double!
    public var voteCount: Int!
    public var video: Bool!
    public var voteAverage: Double!
    
    public required init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        posterPath          <- map["poster_path"]
        adult               <- map["adult"]
        overview            <- map["overview"]
        releaseDate         <- map["release_date"]
        genreIds            <- map["genre_ids"]
        imdbId              <- map["imdb_id"]
        itemId              <- map["id"]
        originalTitle       <- map["original_title"]
        originalLanguage    <- map["original_language"]
        title               <- map["title"]
        backdropPath        <- map["backdrop_path"]
        popularity          <- map["popularity"]
        voteCount           <- map["vote_count"]
        video               <- map["video"]
        voteAverage         <- map["vote_average"]
    }
}
