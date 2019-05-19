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
    var network : MyNetwork?
    //var AccessData: AccessCoreData?
    var json : JSON?
    
    init() {
        // here we can send the NW Services
    //    self.network = MyNetwork()
        //self.AccessData = AccessCoreData()
        self.network?.fetchMoviesData()
        /*json = self.network?.getJSON()
         if(json != nil){
         AccessData?.saveJSON(jsonData: json!)
         }*/
        
    }
    func setDelegate(delegate: FavoriteDelegate){
        self.favoriteDelegate = delegate
        
    }
    
    func fetchMoviesFromCoreData(appDeleget: AppDelegate , moviesArr : inout Array<NSManagedObject>)
    {
        let manegerContext = appDeleget.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        do{
            moviesArr = try manegerContext.fetch(fetchRequest)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
  
    
}
