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

    
    //var movies: [[String: Any]] = []
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged) //when event is changed it triggers didPullToRefresh, passing itself in
        
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        
        activityIndicator.startAnimating()  // Start the activity indicator
        fetchMovies()
        //activityIndicator.stopAnimating()
    }

    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
        
    }
    
    
    func fetchMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=ae7642cec5716f5a124b2109d9483291")! //get url and update API key
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            //this will run when the network request returns data
            if let error = error{
                //check if its nil & act accordingly. Returns whatever value assigned to 'error' if not nil
                print(error.localizedDescription) //if error exists
            } else if let data = data{
                
                let dataDictionary = try!JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] //stores movies in a dictionary
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                
                self.movies = movies            //movie list
                self.tableView.reloadData()     //make updates
                self.refreshControl.endRefreshing()  //stops a refresh operation
                self.activityIndicator.stopAnimating()
                
                
            }
        }
        
        task.resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell //use cell as of type MovieCell
        
        cell.movie = movies[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
