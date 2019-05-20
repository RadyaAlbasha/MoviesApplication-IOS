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
    var appDeleget : AppDelegate?
    let managerContext : NSManagedObjectContext?
    let movieEntity : NSEntityDescription?
    init() {
//        appDeleget = AppDelegate()
//        DispatchQueue.main.async {
        self.appDeleget = (UIApplication.shared.delegate as! AppDelegate)
//        }
        managerContext = appDeleget?.persistentContainer.viewContext
        movieEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managerContext!)
    }
    func saveMovie(movie: HomeMovie) {
        let cdMovie = NSManagedObject(entity: movieEntity!, insertInto: managerContext)
        cdMovie.setValue(movie.original_title, forKey: "original_title")
        cdMovie.setValue(movie.overview, forKey: "overview")
        cdMovie.setValue(movie.poster_path, forKey: "poster_path")
        cdMovie.setValue(movie.release_date, forKey: "release_date")
        cdMovie.setValue(movie.vote_Average, forKey: "vote_Average")
        do{
            try managerContext?.save()
        }catch{
            print("Saving error")
        }
    }
//    func retriveMovies() -> Array<NSManagedObject>? {
    func retriveMovies() -> Array<HomeMovie>? {
        let fecheRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        var movieArr : Array<NSManagedObject>? = nil
        do{
            try movieArr = (managerContext?.fetch(fecheRequest))!
        }catch{
            print("error feche data")
        }
        var arr : Array<HomeMovie> = Array<HomeMovie>()
        for nsObject in movieArr! {
            arr.append(HomeMovie(
                original_title: nsObject.value(forKey: "original_title") as! String, poster_path: nsObject.value(forKey: "poster_path") as! String, overview: nsObject.value(forKey: "overview") as! String, release_date: nsObject.value(forKey: "release_date") as! String, vote_Average: nsObject.value(forKey: "vote_Average") as! Float))
        }
        return arr;
    }
//    func saveJSONToCoreData(jsonData : JSON){
//    
       // let movie = NSManagedObject(entity: entity! , insertInto: manegerContext)
//        let results = jsonData["results"]
//        results.array?.forEach({ (newMovie) in
//              let movie = NSManagedObject(entity: entity! , insertInto: manegerContext)
//            movie.setValue(newMovie["original_title"].stringValue , forKey: "original_title")
//            movie.setValue(newMovie["overview"].stringValue , forKey: "overview")
//            movie.setValue(newMovie["poster_path"].stringValue , forKey: "poster_path")
//            movie.setValue(newMovie["release_date"].stringValue , forKey: "release_date")
//            movie.setValue(newMovie["vote_Average"].floatValue , forKey: "vote_Average")
//        })
//        do{
//            try manegerContext.save()
//        }
//        catch let error as NSError{
//            print(error.localizedDescription)
//        }
//    }
//
    
}
