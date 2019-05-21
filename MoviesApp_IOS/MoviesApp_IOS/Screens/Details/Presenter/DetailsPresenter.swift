//
//  DetailsPresenter.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/19/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import CoreData

class DetailsPresenter {
    let accessData : AccessData
    let detailsViewDelegate : DetailsDelegate
    init( detailsViewDelegate : DetailsDelegate) {
        self.accessData = AccessData()
        self.detailsViewDelegate = detailsViewDelegate
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
}
