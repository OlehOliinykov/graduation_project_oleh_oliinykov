//
//  SongsModel.swift
//  GraduationProject
//
//  Created by Влад Овсюк on 22.02.2022.
//

import Foundation

struct SongsModel: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
