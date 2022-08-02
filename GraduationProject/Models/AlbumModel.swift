//
//  AlbumModel.swift
//  GraduationProject
//
//  Created by Олег Олейников on 27.12.2021.
//

import Foundation

struct AlbumModel: Decodable, Equatable {
    let results: [Album]
}

struct Album: Decodable, Equatable {
    let artistName: String
    let collectionName: String
    let artworkUrl60: String?
    let trackCount: Int
    let releaseDate: String
    let collectionId: Int
}
