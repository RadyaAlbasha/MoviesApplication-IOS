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
                    self.homePresenter?.setMoviesArr(moviesArr: (self.accessData?.saveJSON(jsonData: self.json!))!)
                    
                    //self.homePresenter.getJSON(json: json)
                    print (self.json!)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    
   
    
}
