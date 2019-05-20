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
    
    let imageLink : String = "http://image.tmdb.org/t/p/w185/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        detailsPresenter = DetailsPresenter(detailsViewDelegate: self)
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
        detailsPresenter?.saveMovieToFavorit(movie: movie!)
    }
    
    func setMovieToDisplayDetails(movie: HomeMovie) {
        self.movie = movie;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = UITableViewCell()
        let str :String = tableView.restorationIdentifier!
        if(str == "TrailerTable"){
             cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath)
            cell.textLabel?.text = "Trailer"
            cell.imageView?.image = UIImage(named: ("trailer.png"))
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
            cell.textLabel?.text = "Review"
            cell.imageView?.image = UIImage(named: ("review.jpg"))
        }
       
        return cell
    }
}

