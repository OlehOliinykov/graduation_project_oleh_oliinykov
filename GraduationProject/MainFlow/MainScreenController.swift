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
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "AlbumsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AlbumsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
                            
                        }
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
                
                
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
//    func getSong(named term: String, limit: Int, completion: @escaping (Result<SearchResults, Error>) -> Void) {
//        dataTask?.cancel()
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "itunes.apple.com"
//        urlComponents.path = "/search"
//        urlComponents.queryItems = [URLQueryItem(name: "media", value: "ebook"),
//                                    URLQueryItem(name: "term", value: term),
//                                    URLQueryItem(name: "limit", value: String(limit))]
//        guard let url = urlComponents.url else { return }
//
//        dataTask = session.dataTask(with: url) { [weak self] data, response, error in
//            if let error = error {
//                // TODO (Displaying error)
//                print("[QueryService] getSong(names: complition) ", error.localizedDescription)
//            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                guard let results = self?.searchResults(from: data) else { return }
//                DispatchQueue.main.async {
//                    completion(.success(results))
//                }
//            }
//        }
//        dataTask?.resume()
//    }
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
        let detailScreen = DetailScreen()
        let album = albums[indexPath.row]
        detailScreen.album = album
        detailScreen.title = album.artistName
        navigationController?.pushViewController(detailScreen, animated: true)
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

 
