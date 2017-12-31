//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Malvern Madondo on 6/21/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = [];
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()  //pull to refresh and load movies
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged) //when event is changed it triggers didPullToRefresh, passing itself in
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.delegate = self
        
        activityIndicator.startAnimating()  // Start the activity indicator
        fetchMovies()  //network request to get movies
        //activityIndicator.stopAnimating()
    }

    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
        
    }
    
    func fetchMovies(){
            MovieAPIManager().nowPlayingMovies(completion: { (movies, error) in
                if let movies = movies{
                    self.movies = movies            //movie list
                    self.tableView.reloadData()     //make updates
                    self.refreshControl.endRefreshing()  //stops a refresh operation
                    self.activityIndicator.stopAnimating()

                }
            })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell //use cell as of type MovieCell
        
        let movie = movies[indexPath.row]
        let movieTitle = movie.title;
        let movieOverview = movie.overview
        
        cell.titleLabel.text = movieTitle;
        cell.overviewLabel.text = movieOverview;
        cell.posterImageView.af_setImage(withURL: movie.posterUrl)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie;
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
