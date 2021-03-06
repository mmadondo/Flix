//
//  Movie.swift
//  Flix
//
//  Created by Malvern Madondo on 12/16/17.
//  Modified by Malvern Madondo on 8/9/18
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import Foundation

class Movie {
    
    //properties for data to be accessed from API
    var title: String
    var overview: String
    var releaseDate: String
    var posterUrl: URL
    var posterPath: String
    var baseURL: String
    var backdropPath: String
    var backdropURL: URL

    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        baseURL = "https://image.tmdb.org/t/p/w500"
        backdropPath = dictionary["backdrop_path"] as? String ?? "No backdrop path"
        posterPath = dictionary["poster_path"] as? String ?? "No poster path"
        posterUrl = URL(string: baseURL + posterPath)!
        backdropURL = URL(string: baseURL + backdropPath)!
    }
    
    //HELPER FUNCTION
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
