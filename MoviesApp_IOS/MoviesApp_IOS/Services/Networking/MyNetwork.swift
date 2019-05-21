//
//  MyNetwork.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/18/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MyNetwork{
    var accessData: AccessData?
    var homePresenter : HomePresenterDelegate?
    var json :JSON?
    init(presenterDelegete : HomePresenterDelegate) {
        self.accessData = AccessData()
        self.homePresenter = presenterDelegete
        
        
    }
    func fetchMoviesData(){
        DispatchQueue.main.async {
            Alamofire.request("http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=a9d917538e1903249a735069026bccbc").responseJSON(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    self.json = JSON(value)
                    self.homePresenter?.setJSON(json: self.json!)
                    self.homePresenter?.setMoviesArr(moviesArr: (self.saveJSON(jsonData: self.json!)))
                    
                    //self.homePresenter.getJSON(json: json)
//                    print (self.json!)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    func fetchTrailerVideos(movieID: Int) -> Array<Trailer>{
        var movieTrailers = Array<Trailer>()
        Alamofire.request("https://api.themoviedb.org/3/movie/11852/videos?language=en-US&api_key=a9d917538e1903249a735069026bccbc").responseJSON { (response) in
            switch response.result{
            case .success(let value):
                    let trailers = JSON(value)["results"]
                    trailers.array?.forEach({(trailer) in
                        let trailerObj = Trailer(trailerName: trailer["name"].stringValue, key: trailer["key"].stringValue)
                         movieTrailers.append(trailerObj)
                    })
               
            case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        return movieTrailers
    }
    func saveJSON(jsonData : JSON) -> Array<HomeMovie> {
        let results = jsonData["results"]
        var moviesArr = Array<HomeMovie> ()
        results.array?.forEach({ (newMovie) in
            let movie = HomeMovie(movieID: newMovie["id"].intValue ,original_title: newMovie["original_title"].stringValue , poster_path: newMovie["poster_path"].stringValue , overview: newMovie["overview"].stringValue, release_date: newMovie["release_date"].stringValue , vote_Average: newMovie["vote_average"].floatValue , trailers:self.fetchTrailerVideos(movieID: newMovie["id"].intValue))
            moviesArr.append(movie)
        })
        return moviesArr
    }
    
   
    
}
