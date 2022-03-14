//
//  AlbumsTableViewCell.swift
//  GraduationProject
//
//  Created by Олег Олейников on 27.12.2021.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumPhoto: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackValue: UILabel!
    
    func setup(item: Album) {
        if let urlString = item.artworkUrl60 {
            NetworkRequest.shared.requestData(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumPhoto.image = image
                case .failure(let error):
                    print("No album photo")
                }
            }
        } else {
            albumPhoto.image = nil
        }
        albumName.text = item.collectionName
        artistName.text = item.artistName
        trackValue.text = "\(item.trackCount) tracks"
    }
}
