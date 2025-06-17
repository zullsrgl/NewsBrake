//
//  NewsModels.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 17.06.2025.
//
import UIKit

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
}

struct Source: Decodable {
    let id: String?
    let name: String?
}
