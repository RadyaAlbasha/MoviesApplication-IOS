//
//  HomeCollectionViewController_ExtensionDelegate.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/18/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import CoreData
import UIKit
extension HomeCollectionViewController : HomeDelegate{
    
    func setMoviesArr(moviesArr : Array<HomeMovie>) {
        self.moviesArr = moviesArr
        self.collectionView?.reloadData()
    }
    func showInternetConnectionAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Pleas Check Your Internet Connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
