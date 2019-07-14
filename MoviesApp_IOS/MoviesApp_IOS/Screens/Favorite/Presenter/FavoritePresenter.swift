//
//  FavoritePresenter.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/19/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import CoreData
import Alamofire
import SwiftyJSON

class FavoritePresenter{
    var favoriteDelegate: FavoriteDelegate?
    //    var network : MyNetwork?
    var accessData: AccessData = AccessData();
    
    func setDelegate(delegate: FavoriteDelegate)
    {
        self.favoriteDelegate = delegate
    }
    
    func fetchMoviesFromCoreData() -> Array<HomeMovie>
    {
        return accessData.retriveMovies()!;
    }
    
    
}
