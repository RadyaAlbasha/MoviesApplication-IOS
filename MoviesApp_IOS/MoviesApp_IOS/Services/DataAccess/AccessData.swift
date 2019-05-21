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
    let trailerEntity : NSEntityDescription?
    init() {
        self.appDeleget = (UIApplication.shared.delegate as! AppDelegate)
        managerContext = appDeleget?.persistentContainer.viewContext
        movieEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managerContext!)
        trailerEntity = NSEntityDescription.entity(forEntityName: "TrailerEmantity", in: managerContext!)
    }
    
    func saveMovie(movie: HomeMovie) {
        if(!movieIsAlreadyExist(movieID: movie.movieID)){
            let mTrailer = NSManagedObject(entity: trailerEntity!, insertInto: managerContext)
            let cdMovie = NSManagedObject(entity: movieEntity!, insertInto: managerContext)
            cdMovie.setValue(movie.movieID, forKey: "id")
            cdMovie.setValue(movie.original_title, forKey: "original_title")
            cdMovie.setValue(movie.overview, forKey: "overview")
            cdMovie.setValue(movie.poster_path, forKey: "poster_path")
            cdMovie.setValue(movie.release_date, forKey: "release_date")
            cdMovie.setValue(movie.vote_Average, forKey: "vote_Average")
            cdMovie.mutableSetValue(forKeyPath: "movieTrailer").add(<#T##object: Any##Any#>)
            do{
                try managerContext?.save()
            }catch{
                print("Saving error")
            }
        }
    }

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
            nsObject.
            arr.append(HomeMovie(movieID: nsObject.value(forKey: "id") as! Int, original_title: nsObject.value(forKey: "original_title") as! String, poster_path: nsObject.value(forKey: "poster_path") as! String, overview: nsObject.value(forKey: "overview") as! String, release_date: nsObject.value(forKey: "release_date") as! String, vote_Average: nsObject.value(forKey: "vote_Average") as! Float, trailers: <#Array<Trailer>#>))
        }
        return arr;
    }
    func movieIsAlreadyExist(movieID : Int) -> Bool {
        //Not    working
        let fecheRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        fecheRequest.predicate = NSPredicate(format: "%K == %d", "id" , movieID)
        do{
            var result :Array<NSManagedObject>?
            try result = (managerContext?.fetch(fecheRequest))!
            if(result?.count == 0 ){
                return false
            }
            else{
                return true
            }
        }catch{
            print("error")
            return true
        }
    }
    
}
