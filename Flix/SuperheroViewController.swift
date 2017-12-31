//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Malvern Madondo on 6/23/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import AlamofireImage

class SuperheroViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var movies: [Movie] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Adjust presentation size
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        
        let cellsPerLine: CGFloat = 2;
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1);
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine;
        layout.itemSize = CGSize(width: width, height: width * 3 / 2);
        
        fetchMovies()
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let movie = movies[indexPath.item]
        
        cell.posterImageView.af_setImage(withURL: movie.posterUrl)
        
        return cell
    }
    
    func fetchMovies(){
        MovieAPIManager().superHeroMovies{(movies, error) in
            if let movies = movies{
                self.movies = movies            //movie list
                self.collectionView.reloadData()     //make updates
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController;
        let movieItem = sender as! UICollectionViewCell;
        
        if let indexPath = collectionView.indexPath(for: movieItem){
            let movie = movies[indexPath.item]
            destinationVC.movie = movie;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
