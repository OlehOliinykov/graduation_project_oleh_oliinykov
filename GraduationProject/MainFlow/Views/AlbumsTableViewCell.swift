//
//  AlbumsTableViewCell.swift
//  GraduationProject
//
//  Created by Олег Олейников on 27.12.2021.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "AlbumsTableViewCell"
    
    @IBOutlet weak var albumPhoto: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackValue: UILabel!
    
    func setup(item: AlbumInfoSetting) {
        albumPhoto.image = item.image
        albumName.text = item.name
        artistName.text = item.artist
        trackValue.int = item.trackValue
    }
}
