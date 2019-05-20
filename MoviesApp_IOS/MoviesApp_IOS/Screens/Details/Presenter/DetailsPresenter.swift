//
//  DetailsPresenter.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/19/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
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
}
