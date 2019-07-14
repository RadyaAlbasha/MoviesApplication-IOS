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
    var detailsPresenter: DetailsPresenterDelegate?
    var json :JSON?
    init() {
        self.accessData = AccessData()
        
    }
    func setHomePresenterDelegete(homePresenterDelegete : HomePresenterDelegate)
    {
        self.homePresenter = homePresenterDelegete
    }
    func setDetailsPresenterDelegete(detailsPresenterDelegate : DetailsPresenterDelegate)
    {
        self.detailsPresenter = detailsPresenterDelegate
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
                    self.homePresenter?.showAlert()
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    func fetchMoviesDataByHighestRated(){
        DispatchQueue.main.async {
            Alamofire.request("http://api.themoviedb.org/3/discover/movie?sort_by=vote_average.desc&api_key=a9d917538e1903249a735069026bccbc").responseJSON(completionHandler: { (response) in
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
    
    func fetchMoviesReview(movieID : Int32){
        var reviewArr = [Review]()
        print("https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=a9d917538e1903249a735069026bccbc")
        Alamofire.request("https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=a9d917538e1903249a735069026bccbc").responseJSON{ (response) in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let results = json["results"]
                results.array?.forEach({(rev) in
                    let review = Review(author: rev["author"].stringValue,content: rev["content"].stringValue)
                    reviewArr.append(review)
                })
                self.detailsPresenter!.setReviewArray(reviewsOfMovie : reviewArr)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMoviesTraliers(movieID : Int32){
        var traliersArr = [Trailer]()
        Alamofire.request("https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a9d917538e1903249a735069026bccbc").responseJSON{ (response) in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let results = json["results"]
                results.array?.forEach({(tralier) in
                    let outTralier = Trailer(trailerName: tralier["name"].stringValue, key: tralier["key"].stringValue)
                    traliersArr.append(outTralier)
                })
                self.detailsPresenter!.setTrailerArray(trailersOfMovie: traliersArr)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveJSON(jsonData : JSON) -> Array<HomeMovie> {
        let results = jsonData["results"]
        var moviesArr = Array<HomeMovie> ()
        results.array?.forEach({ (newMovie) in
            let movie = HomeMovie(id: newMovie["id"].int32Value,original_title: newMovie["original_title"].stringValue , poster_path: newMovie["poster_path"].stringValue , overview: newMovie["overview"].stringValue, release_date: newMovie["release_date"].stringValue , vote_Average: newMovie["vote_average"].floatValue)
            moviesArr.append(movie)
        })
        return moviesArr
    }
    
    
    
}
