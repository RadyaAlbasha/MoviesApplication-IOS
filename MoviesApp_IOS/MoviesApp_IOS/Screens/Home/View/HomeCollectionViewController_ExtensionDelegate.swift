//
//  HomeCollectionViewController_ExtensionDelegate.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/18/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import CoreData
extension HomeCollectionViewController : HomeDelegate{
    
    func setMoviesArr(moviesArr : Array<HomeMovies>) {
        self.moviesArr = moviesArr
        self.collectionView?.reloadData()
    }
    
}
