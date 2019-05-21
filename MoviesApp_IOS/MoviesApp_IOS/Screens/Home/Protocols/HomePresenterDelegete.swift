//
//  HomePresenterDelegete.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/19/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol HomePresenterDelegate {
    func setJSON(json : JSON)
    func setMoviesArr(moviesArr : Array<HomeMovie>)
    //func getSegmentIndex() -> Int
}
