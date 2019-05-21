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
    
    var detailsPresenter : DetailsPresenter? = nil

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var voteAverage: UILabel!
    
    @IBOutlet weak var overviewTextArea: UITextView!
    
    @IBOutlet weak var trailerTableView: UITableView!
    
    @IBOutlet weak var favoritBtn: UIButton!
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    
    let imageLink : String = "http://image.tmdb.org/t/p/w185/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.trailerTableView.delegate = self
        self.reviewTableView.delegate = self
        self.trailerTableView.dataSource = self
        self.reviewTableView.dataSource = self
        
        detailsPresenter = DetailsPresenter(detailsViewDelegate: self)
        
        //check if movie is favorite movie
        if(detailsPresenter?.isFavorite(movieID: (movie?.id)!))!{
            self.favoritBtn.setTitleColor(UIColor.red, for: .normal)
        }else{
            self.favoritBtn.setTitleColor(UIColor.darkGray, for: .normal)
        }
        
        var tempStrUrl: String = (movie?.poster_path)!
        tempStrUrl = imageLink + tempStrUrl
        print(tempStrUrl)
        posterImage.sd_setImage(with: URL(string: tempStrUrl), placeholderImage: UIImage(named: "placeholder.png"))
        movieTitleLabel.text = movie?.original_title
        releaseDateLabel.text=movie?.release_date
        voteAverage.text="\((movie?.vote_Average)!) "
        overviewTextArea.text = movie?.overview
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToFavoriteBtn(_ sender: UIButton) {
      
        if(sender.currentTitleColor == UIColor.darkGray)
        {
            sender.setTitleColor(UIColor.red, for: .normal)
            detailsPresenter?.saveMovieToFavorit(movie: movie!)
        }
        else{
            sender.setTitleColor(UIColor.darkGray, for: .normal)
            detailsPresenter?.deleteMovieFromFavorite(movieID : (movie?.id)!)
            //delete from favorit
        }
       
    }
    
    func setMovieToDisplayDetails(movie: HomeMovie) {
        self.movie = movie;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == reviewTableView){
            return 110
        }
        else{
             return 50
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = UITableViewCell()
        if(tableView == trailerTableView){
            cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath)
            cell.textLabel?.text = "Trailer"
            cell.imageView?.image = UIImage(named: ("trailer.png"))
        }
        else if(tableView == reviewTableView)
        {
            let revCell : ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
            
            revCell.reviewAuthorLabel.text = "Review"
            //revCell.reviewDetails.text = "details"
            cell = revCell
          
        }
       
        return cell
    }
}

