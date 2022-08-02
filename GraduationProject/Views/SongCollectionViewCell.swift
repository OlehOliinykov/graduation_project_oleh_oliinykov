//
//  CollectionViewCell.swift
//  GraduationProject
//
//  Created by Влад Овсюк on 22.02.2022.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var songStackView: UIStackView!
    @IBOutlet weak var trackName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        trackName.font = UIFont.systemFont(ofSize: 17)
    }

    func setup(title: String) {
        trackName.text = title
    }
}
