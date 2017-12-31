//
//  Movie.swift
//  Flix
//
//  Created by Malvern Madondo on 12/16/17.
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
        posterUrl = dictionary["posterUrl"] as! URL
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        backdropPath = dictionary["backdrop_path"] as! String ?? "No backdrop path"
        baseURL = "https://image.tmdb.org/t/p/w500"
        posterPath = dictionary["poster_path"] as! String ?? "No poster path"
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
