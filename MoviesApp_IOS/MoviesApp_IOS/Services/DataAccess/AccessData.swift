//
//  AccessCoreData.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/18/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class AccessData {
    
    init() {
        
    }
    
    func saveJSONToCoreData(jsonData : JSON){
        var appDeleget = AppDelegate()
        DispatchQueue.main.async {
            appDeleget = UIApplication.shared.delegate as! AppDelegate
        }
        let manegerContext = appDeleget.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: manegerContext)
       // let movie = NSManagedObject(entity: entity! , insertInto: manegerContext)
        let results = jsonData["results"]
        results.array?.forEach({ (newMovie) in
              let movie = NSManagedObject(entity: entity! , insertInto: manegerContext)
            movie.setValue(newMovie["original_title"].stringValue , forKey: "original_title")
            movie.setValue(newMovie["overview"].stringValue , forKey: "overview")
            movie.setValue(newMovie["poster_path"].stringValue , forKey: "poster_path")
            movie.setValue(newMovie["release_date"].stringValue , forKey: "release_date")
            movie.setValue(newMovie["vote_Average"].floatValue , forKey: "vote_Average")
        })
        do{
            try manegerContext.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func saveJSON(jsonData : JSON) -> Array<HomeMovies> {
        let results = jsonData["results"]
        var moviesArr = Array<HomeMovies> ()
        results.array?.forEach({ (newMovie) in
            let movie = HomeMovies(original_title: newMovie["original_title"].stringValue , poster_path: newMovie["poster_path"].stringValue , overview: newMovie["overview"].stringValue, release_date: newMovie["release_date"].stringValue , vote_Average: newMovie["vote_Average"].floatValue)
            moviesArr.append(movie)
        })
        return moviesArr
    }
}
