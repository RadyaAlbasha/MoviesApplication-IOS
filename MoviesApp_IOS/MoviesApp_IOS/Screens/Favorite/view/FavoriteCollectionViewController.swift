//
//  FavoriteViewController.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/13/19.
//  Copyright © 2019 iti. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
private let reuseIdentifier = "FavoriteCell"

class FavoriteCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    var moviesArr : Array<HomeMovie>?
    var favoritePresenter: FavoritePresenter?
    var imageLink : String = "http://image.tmdb.org/t/p/w185/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //bgeb ely 3amlalo save kolo
        self.favoritePresenter = FavoritePresenter()
        self.moviesArr = self.favoritePresenter?.fetchMoviesFromCoreData()
        self.favoritePresenter?.setDelegate(delegate: self)
        self.collectionView?.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        let detailsDelegate = segue.destination as! DetailsDelegate
        // Pass the selected object to the new view controller.
        detailsDelegate.setMovieToDisplayDetails(movie: moviesArr![(self.collectionView?.indexPath(for: sender as! UICollectionViewCell)?.row)!])
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return moviesArr!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoriteCollectionViewCell
        let image : String = moviesArr![indexPath.row].poster_path
        let finalImageLink = self.imageLink + image
        // Configure the cell
        cell.imageViewPoster.sd_setImage(with: URL(string: finalImageLink), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*let width = (self.view.frame.size.width - 1 * 2)/2 //some width
         let height = width * 275 / 185 // retio
         return CGSize(width: width, height: height)*/
        let width = collectionView.bounds.width/2 //some width
        let height = width * 275 / 185 // retio
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
