//
//  HomeMovies.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/19/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
class HomeMovie{
    var movieID : Int
    var original_title : String
    var overview : String
    var poster_path : String
    var release_date : String
    var vote_Average : Float
    var trailers : Array<Trailer>
    
    init(movieID : Int , original_title : String , poster_path: String , overview: String , release_date: String , vote_Average : Float , trailers : Array<Trailer>) {
        self.original_title = original_title
        self.overview = overview
        self.poster_path = poster_path
        self.release_date = release_date
        self.vote_Average = vote_Average
        self.movieID = movieID
        self.trailers = trailers
    }
    
}
