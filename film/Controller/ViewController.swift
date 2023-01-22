//
//  ViewController.swift
//  film
//
//  Created by İlker Yasin Memişoğlu on 15.01.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var movie = [MovieModel]()
    var filteredMovie = [MovieModel]()
    let apiRequest = ApiRequest(s: "", i: "", t: "")
    
    let searchController = UISearchController(searchResultsController: nil)
//    var isSearchBarEmpty: Bool {
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//    
    
    @IBOutlet weak var dataTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Navigation Bar Configuration
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .black
        title = "Movie Search"
        
        
        // Search Controller configuration
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.backgroundColor = .white
        
        
        // Register data tableview cell
        dataTableView.register(DataTableViewCell.self, forCellReuseIdentifier: "dataCell")
        
        
        dataTableView.dataSource = self
        dataTableView.delegate = self

        networkRequest()
        
    }
    
    func networkRequest () {
        apiRequest.movieRequest() { response in
            switch response {
                
            case .success(let movie):
                self.movie.append(movie)
                self.dataTableView.reloadData()
                
            case .failure(let error ):
                print(error)
                
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movie.isEmpty ? 1 : movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! DataTableViewCell
        
        if movie.isEmpty {
            cell = DataTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "dataCell")
        } else {
            
            cell.movie = movie[indexPath.row]
        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // set properties for Second VC if movie is not empty
        if !movie.isEmpty {
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
            
            secondVC.imageUrl = movie[indexPath.row].Poster
            secondVC.explanation = movie[indexPath.row].Plot
            secondVC.actor = movie[indexPath.row].Actors
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if movie.isEmpty {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
}
extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // Check if searchTextField is Empty
        if searchController.searchBar.searchTextField.state.isEmpty {
            movie = []
            dataTableView.reloadData()
        }
        
        // Getting searchbar text safely and parsing it to searchRequest
        guard let text  = searchController.searchBar.text  else {return}
        
        let searchRequest = ApiRequest(s: "", i: "", t: text)
        searchRequest.movieRequest() { [self] response in
            
            switch response {
                
            case .success(let data):
                movie = []
                movie.append(data)
                DispatchQueue.main.async {
                    self.dataTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        // When cancel Button is tapped, clear tableview
        if !searchController.isActive {
            movie = []
            dataTableView.reloadData()
        }
        
    }
    
}

