//
//  DataModel.swift
//  FSSTest
//
//  Created by Medshow on 30/04/24.
//

import Foundation

struct detailsResponseModel: Codable {
    let recipes: [Recipe]?
}

struct Recipe: Codable {
  let id: Int?
  let name: String?
  let ingredients: [String]?
  let instructions: [String]?
  let prepTimeMinutes: Int?
  let cookTimeMinutes: Int?
  let servings: Int?
  let difficulty: String?
  let cuisine: String?
  let caloriesPerServing: Int?
  let tags: [String]?
  let userId: Int?
  let image: String?
  let rating: Double?
  let reviewCount: Int?
  let mealType: [String]?
}


