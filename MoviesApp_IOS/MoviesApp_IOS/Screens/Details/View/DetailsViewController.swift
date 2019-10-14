//
//  ViewController.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/13/19.
//  Copyright © 2019 iti. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , DetailsDelegate{
    
    var movie : HomeMovie? = nil;
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var voteAverage: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var trailerTableView: UITableView!
    
    @IBOutlet weak var favoritBtn: UIButton!
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    
    let imageLink : String = "http://image.tmdb.org/t/p/w185/"
    var trailersArr : Array<Trailer>?
    var reviewsArr : Array<Review>?
    var detailsPresenterDelegate: DetailsPresenter?
    
    weak var  trailerNetworkIndicator : UIActivityIndicatorView!
    weak var  reviewNetworkIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.trailerTableView.delegate = self
        self.reviewTableView.delegate = self
        self.trailerTableView.dataSource = self
        self.reviewTableView.dataSource = self
        trailersArr = Array<Trailer>()
        reviewsArr = Array<Review>()
       
        if #available(iOS 13.0, *) {
           
            trailerTableView.backgroundView  = showNetworkIndicator()
            trailerNetworkIndicator = trailerTableView.backgroundView as? UIActivityIndicatorView
            trailerTableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            reviewTableView.backgroundView  = showNetworkIndicator()
            reviewNetworkIndicator = reviewTableView.backgroundView as? UIActivityIndicatorView
            reviewTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        }
      
        detailsPresenterDelegate = DetailsPresenter(detailsViewDelegate: self)
        detailsPresenterDelegate?.getTrailerOfMovies(movieId: (movie?.id)!)
        detailsPresenterDelegate?.getReviewsOfMovies(movieId: (movie?.id)!)
        //check if movie is favorite movie
        if(detailsPresenterDelegate?.isFavorite(movieID: (movie?.id)!))!{
            self.favoritBtn.setTitleColor(UIColor.red, for: .normal)
        }else{
            self.favoritBtn.setTitleColor(UIColor.darkGray, for: .normal)
        }
        
        var tempStrUrl: String = (movie?.poster_path)!
        tempStrUrl = imageLink + tempStrUrl
        print(tempStrUrl)
        posterImage.sd_setImage(with: URL(string: tempStrUrl), placeholderImage: UIImage(named: "placeholder.png"))
        movieTitleLabel.text = movie?.original_title
        releaseDateLabel.text = movie?.release_date
        voteAverage.text="\((movie?.vote_Average)!) "
        overviewLabel.text = movie?.overview
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToFavoriteBtn(_ sender: UIButton) {
        
        if(sender.currentTitleColor == UIColor.darkGray)
        {
            sender.setTitleColor(UIColor.red, for: .normal)
            detailsPresenterDelegate?.saveMovieToFavorit(movie: movie!)
        }
        else{
            sender.setTitleColor(UIColor.darkGray, for: .normal)
            detailsPresenterDelegate?.deleteMovieFromFavorite(movieID : (movie?.id)!)
            //delete from favorit
        }
        
    }
    
    func setMovieToDisplayDetails(movie: HomeMovie) {
        self.movie = movie;
    }
    
    func setTrailersForTable(trailerArr: [Trailer]) {
        self.trailersArr = trailerArr
        self.trailerTableView.reloadData()
    }
    
    func setReviewsForTable(reviewArr: [Review]) {
        self.reviewsArr = reviewArr
        self.reviewTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == reviewTableView){
            let count = (reviewsArr?.count)!
            if(count == 0){
                if reviewNetworkIndicator != nil{
                    reviewNetworkIndicator.stopAnimating()
                }
                
                reviewTableView.backgroundView  = notFoundLabel(msg: "There is no reviews")
            }
            return count
        }
        else{
            let count = (trailersArr?.count)!
                      if(count == 0){
                          if trailerNetworkIndicator != nil{
                              trailerNetworkIndicator.stopAnimating()
                          }
                        trailerTableView.backgroundView  = notFoundLabel(msg: "There is no trailers")
                      }
            return count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableViewAutomaticDimension
        if(tableView == trailerTableView){
            return 94
        }else{
            return UITableViewAutomaticDimension
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = UITableViewCell()
        if(tableView == trailerTableView){
            let trailerCell : TrailerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath) as! TrailerTableViewCell
            //trailerCell.TrailerNameLabel.text = "dcdcvdxscdsc"
            trailerCell.TrailerNameLabel.text = trailersArr![indexPath.row].trailerName
            //print(trailersArr![indexPath.row].trailerName)
            trailerCell.trailerImageView.sd_setImage(with: URL(string: "http://img.youtube.com/vi/" + trailersArr![indexPath.row].key + "/maxresdefault.jpg"), placeholderImage: UIImage(named: "trailer.png"))
            cell = trailerCell
            if trailerNetworkIndicator != nil{
                trailerNetworkIndicator.stopAnimating()
            }
        }
        else if(tableView == reviewTableView)
        {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            let revCell : ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
            
            revCell.reviewAuthorLabel.text = reviewsArr![indexPath.row].reviewAuthor
            revCell.reviewDetails.text = reviewsArr![indexPath.row].reviewContent
            cell = revCell
            if reviewNetworkIndicator != nil{
                reviewNetworkIndicator.stopAnimating()
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == trailerTableView){
            let urlStr = "http://www.youtube.com/watch?v=" + trailersArr![indexPath.row].key
            if let url = URL(string: urlStr){
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @available(iOS 13.0, *)
    func showNetworkIndicator() -> UIActivityIndicatorView
    {
        let networkIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorView.Style.large)
        networkIndicator.color = #colorLiteral(red: 0.9137254902, green: 0.1450980392, blue: 0.1294117647, alpha: 1)
        networkIndicator.center = view.center
        networkIndicator.startAnimating()
        //view.addSubview(networkIndicator)
        return networkIndicator
    }
    
    func notFoundLabel(msg : String) -> UILabel {
         let lbl  = UILabel()
                    lbl.text = msg
                    lbl.font = UIFont(name: lbl.font.fontName, size: 30)
                    lbl.textAlignment = .center
                    lbl.textColor = #colorLiteral(red: 0.9137254902, green: 0.1450980392, blue: 0.1294117647, alpha: 1)
                    lbl.sizeToFit()
        
        return lbl
    }
}

