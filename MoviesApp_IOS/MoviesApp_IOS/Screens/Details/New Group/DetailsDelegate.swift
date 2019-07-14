//
//  DetailsDelegate.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/19/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation

protocol DetailsDelegate {
    func setMovieToDisplayDetails(movie : HomeMovie);
    func setTrailersForTable(trailerArr: [Trailer])
    func setReviewsForTable(reviewArr: [Review])
}
