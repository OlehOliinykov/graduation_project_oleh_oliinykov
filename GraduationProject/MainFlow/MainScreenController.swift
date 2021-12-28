//
//  MainScreenController.swift
//  GraduationProject
//
//  Created by Олег Олейников on 27.12.2021.
//

import Foundation
import UIKit
 
class MainScreenController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchController: UISearchBar!
    
    var albums = [Album] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchAlbums(albumName: "Sheffield")
    }
    func setupTableView() {
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchAlbums(albumName: String) {
        let urlString = "https://itunes.apple.com/search/term=\(albumName)&entity=album&attribute=albumTerm"
        
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] albumModel, error in
            if error == nil {
                guard let albumModel = albumModel else { return }
                
                self?.albums = albumModel.result
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
}


extension MainScreenController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension MainScreenController: UITableViewDelegate {
    
}

extension MainScreenController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != " " {
            fetchAlbums(albumName: searchText)
        }
    }
}
