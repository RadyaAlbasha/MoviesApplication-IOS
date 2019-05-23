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
        trailerEntity = NSEntityDescription.entity(forEntityName: "TrailerEntity", in: managerContext!)
    }
    
    func saveMovie(movie: HomeMovie) {
        if(!movieIsAlreadyExist(movieID: movie.movieID)){
            
            let cdMovie = NSManagedObject(entity: movieEntity!, insertInto: managerContext)
            cdMovie.setValue(movie.movieID, forKey: "id")
            cdMovie.setValue(movie.original_title, forKey: "original_title")
            cdMovie.setValue(movie.overview, forKey: "overview")
            cdMovie.setValue(movie.poster_path, forKey: "poster_path")
            cdMovie.setValue(movie.release_date, forKey: "release_date")
            cdMovie.setValue(movie.vote_Average, forKey: "vote_Average")
            for element in movie.trailers!{
                let mTrailer = NSManagedObject(entity: trailerEntity!, insertInto: managerContext)
                mTrailer.setValue(element.trailerName, forKey: "name")
                mTrailer.setValue(element.key, forKey: "key")
                cdMovie.mutableSetValue(forKeyPath: "movieTrailer").add(mTrailer)
            }
            do{
                try managerContext?.save()
            }catch{
                print("Saving error")
            }
        }
//        saveHomeMovieToCDMovie(movie: movie)
        do{
            try managerContext?.save()
        }catch{
            print("Saving error")
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
        for managedMovieObj in movieArr! {

            let trailerArr = (managedMovieObj.value(forKey: "movieTrailer") as! NSSet).allObjects as! [NSManagedObject]
            var trailers = Array<TrailerData>()
            for t in trailerArr{
                trailers.append(TrailerData(trailerName: t.value(forKey: "name") as! String , key: t.value(forKey: "key") as! String))
            }
            arr.append(HomeMovie(movieID: managedMovieObj.value(forKey: "id") as! Int, original_title: managedMovieObj.value(forKey: "original_title") as! String, poster_path: managedMovieObj.value(forKey: "poster_path") as! String, overview: managedMovieObj.value(forKey: "overview") as! String, release_date: managedMovieObj.value(forKey: "release_date") as! String, vote_Average: managedMovieObj.value(forKey: "vote_Average") as! Float))
        }
        return arr;
    }
    func movieIsAlreadyExist(movieID : Int) -> Bool {
        //Not    working
        let fecheRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        fecheRequest.predicate = NSPredicate(format: "%K == %i", "id" , movieID)
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
    func deleteMovie (movieID : Int){
        let fecheRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        var movieArr : Array<NSManagedObject>? = nil
        do{
            try movieArr = (managerContext?.fetch(fecheRequest))!
            for m in movieArr! {
                if(m.value(forKey: "id") as! Int32 == movieID){
                    self.managerContext?.delete(m)
                }
            }
        }catch{
            print("error feche data")
        }
        //save change
        do{
            try self.managerContext?.save()
        }catch{
            print("Error")
        }
        
    }


}
