//
//  NewsModels.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 17.06.2025.
//
import UIKit

struct NewsResponse: Codable {
let status: String?
let totalResults: Int?
let articles: [Article]?
}

struct Article: Codable {
let source: Source?
let author: String?
let description: String?
let title: String?
let url: String?
let urlToImage: String?
let publishedAt: String?
let content: String?
}

struct Source: Codable {
let id: String?
let name: String?
}
