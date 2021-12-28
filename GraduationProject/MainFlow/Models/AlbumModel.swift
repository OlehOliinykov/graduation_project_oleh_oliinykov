//
//  AlbumModel.swift
//  GraduationProject
//
//  Created by Олег Олейников on 27.12.2021.
//

import Foundation

struct AlbumModel: Decodable {
    let result: [Album]
}

struct Album: Decodable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: String?
    let trackOut: Int
    let releaseDate: String
}
