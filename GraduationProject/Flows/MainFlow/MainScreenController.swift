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
    
    var albums = [Album]()
    var timer: Timer?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let nib = UINib(nibName: "AlbumsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AlbumsTableViewCell")
    }
    
    
    
    private func fetchAlbums(albumName: String) {
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"

        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] albumModel, error in
            if error == nil {
                guard let albumModel = albumModel else { return }
                
                if albumModel.results != [] {
                    self?.albums = albumModel.results
                    self?.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Error", message: "Song not found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                        switch action.style {
                            case .default:
                            print("default")
                            
                            case .cancel:
                            print("cancel")
                            
                            case .destructive:
                            print("destructive")
                            
                        @unknown default:
                            fatalError("Error")
                        }
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}

extension MainScreenController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsTableViewCell", for: indexPath) as! AlbumsTableViewCell
        let album = albums[indexPath.row]
        cell.setup(item: album)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScreen = UIStoryboard(name: "DetailScreen", bundle: nil).instantiateViewController(withIdentifier: "DetailScreen") as! DetailScreen
        let navDetail = UINavigationController(rootViewController: detailScreen)
        
        let album = albums[indexPath.row]
        detailScreen.album = album
        detailScreen.title = album.artistName
        
        self.present(navDetail, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension MainScreenController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.fetchAlbums(albumName: text!)
            })
        }
    }
}

