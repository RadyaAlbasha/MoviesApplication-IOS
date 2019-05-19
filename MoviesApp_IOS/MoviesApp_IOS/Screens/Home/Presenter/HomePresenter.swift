//
//  HomePresenter.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/18/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
import CoreData
import Alamofire
import SwiftyJSON

class HomePresenter : HomePresenterDelegate {
    var homeDelegate: HomeDelegate?
    var network : MyNetwork?
    //var AccessData: AccessCoreData?
    var json : JSON?
    var moviesArr : Array<HomeMovies>?
    init() {
        // here we can send the NW Services
        self.network = MyNetwork(presenterDelegete: self)
        //self.AccessData = AccessCoreData()
        self.network?.fetchMoviesData()
        self.moviesArr = Array<HomeMovies>()
        /*json = self.network?.getJSON()
        if(json != nil){
            AccessData?.saveJSON(jsonData: json!)
        }*/
       
    }
   func setDelegate(delegate: HomeDelegate){
        self.homeDelegate = delegate
       
    }
    func setJSON(json : JSON) {
        self.json = json
    }
    func setMoviesArr(moviesArr : Array<HomeMovies>){
        self.moviesArr = moviesArr
        self.homeDelegate?.setMoviesArr(moviesArr: moviesArr)
    }
    
    /*
    func fetchMoviesFromCoreData(appDeleget: AppDelegate , moviesArr : inout Array<NSManagedObject>)
    {
        let manegerContext = appDeleget.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        do{
            moviesArr = try manegerContext.fetch(fetchRequest)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }*/
    
    
   /* func getJSON(json : JSON) {
        self.json=json
        checkJSON=true
    }*/
   /* func fetchMoviesData(){
        DispatchQueue.main.async {
            Alamofire.request("http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=a9d917538e1903249a735069026bccbc").responseJSON(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    print (json)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }*/
    
}
