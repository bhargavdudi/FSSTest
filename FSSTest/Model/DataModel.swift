//
//  DataModel.swift
//  FSSTest
//
//  Created by Medshow on 30/04/24.
//

import Foundation

struct detailsResponseModel: Codable {
    let userID, id: Int?
    let title: String?
    let completed: Bool?
}
