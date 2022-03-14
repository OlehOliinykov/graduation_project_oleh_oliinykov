//
//  DetailScreen.swift
//  GraduationProject
//
//  Created by Влад Овсюк on 27.12.2021.
//

import Foundation
import UIKit

class DetailScreen: UIViewController {
    
    
    @IBOutlet weak var albumLogo: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var tracksCount: UILabel!
    @IBOutlet weak var SongsCollectionViewCell: UICollectionView!
    
    var album: Album?
    var song = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: String(describing: "SongCollectionViewCell"), bundle: nil)
        self.SongsCollectionViewCell.register(nib, forCellWithReuseIdentifier: "SongCollectionViewCell")
        fetchSong(album: album)
        setModel()
        
        guard let url = album?.artworkUrl60 else { return }
        
        setImage(urlString: url)
    }
    
    private func setModel() {
        guard let album = album else { return }
        
        albumName.text = album.collectionName
        artistName.text = album.artistName
        tracksCount.text = "\(album.trackCount) tracks:"
        releaseDate.text = setDataFormat(date: album.releaseDate)
    }
    
    private func setDataFormat(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy' - 'MM' - 'dd'T'HH' : 'mm' : 'ssZZZ"
        guard let backendData = dateFormatter.date(from: date) else { return "" }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd - MM - yyyy"
        let date = formatDate.string(from: backendData)
        return date
    }
    
    private func setImage(urlString: String?) {
       
        if let url = urlString {
            NetworkRequest.shared.requestData(urlString: url) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumLogo.image = image
                case .failure(let error):
                    print("No album photo")
                }
            }
        } else {
            albumLogo.image = nil
        }
    }
    
    private func fetchSong(album: Album?) {
        guard let album = album else { return }
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        
        NetworkDataFetch.shared.fetchSongs(urlString: urlString) { [weak self] songsModel, error in
            if error == nil {
                
                guard let songsModel = songsModel else { return }
                self?.song = songsModel.results
                self?.SongsCollectionViewCell.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}

extension DetailScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        song.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = SongsCollectionViewCell.dequeueReusableCell(withReuseIdentifier: "SongCollectionViewCell", for: indexPath) as! SongCollectionViewCell
        let song = song[indexPath.row].trackName
        cell.trackName.text = song
        return cell
    }
}
