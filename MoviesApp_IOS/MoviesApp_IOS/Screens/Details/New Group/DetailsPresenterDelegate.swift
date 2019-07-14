//
//  DetailsPresenterDelegate.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/24/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol DetailsPresenterDelegate {
    func saveMovieToFavorit(movie: HomeMovie)
    func isFavorite(movieID : Int32) -> Bool 
    func deleteMovieFromFavorite(movieID : Int32)
    func setTrailerArray(trailersOfMovie : [Trailer])
    func getTrailerOfMovies(movieId:Int32)
    func setReviewArray(reviewsOfMovie : [Review])
    func getReviewsOfMovies(movieId:Int32)
}
