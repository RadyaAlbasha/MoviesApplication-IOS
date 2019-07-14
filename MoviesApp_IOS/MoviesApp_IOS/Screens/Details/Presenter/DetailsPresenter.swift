//
//  DetailsPresenter.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/19/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import CoreData

class DetailsPresenter: DetailsPresenterDelegate {
    let accessData : AccessData
    let detailsViewDelegate : DetailsDelegate
    var network : MyNetwork?
    init( detailsViewDelegate : DetailsDelegate) {
        self.accessData = AccessData()
        self.detailsViewDelegate = detailsViewDelegate
        self.network = MyNetwork()
        self.network?.setDetailsPresenterDelegete(detailsPresenterDelegate: self)
    }
    func saveMovieToFavorit(movie: HomeMovie) {
        accessData.saveMovie(movie: movie)
    }
    func isFavorite(movieID : Int32) -> Bool {
        let MovieArr = accessData.retriveMovies()
        
        for movie in MovieArr! {
            if(movie.id == movieID)
            {
                return true
            }
        }
        return false
    }
    
    func deleteMovieFromFavorite(movieID : Int32){
        accessData.deleteMovie(movieID: movieID)
    }
    
    func setTrailerArray(trailersOfMovie : [Trailer]){
        detailsViewDelegate.setTrailersForTable(trailerArr: trailersOfMovie)
    }
    func getTrailerOfMovies(movieId:Int32){
        network?.fetchMoviesTraliers(movieID: movieId)
    }
    func setReviewArray(reviewsOfMovie : [Review]){
        detailsViewDelegate.setReviewsForTable(reviewArr: reviewsOfMovie)
    }
    func getReviewsOfMovies(movieId:Int32){
        network?.fetchMoviesReview(movieID: movieId)
    }
}
