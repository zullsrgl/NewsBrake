//
//  ArticleStorageManager.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 19.06.2025.
//
import Foundation
import UIKit

final class ArticleStorageManager {
    
    static let shared = ArticleStorageManager()
    private let defaults = UserDefaults.standard
    private let key = "favoriteArticles"
    private init() {}

    func getFavorites() -> [Article] {
        guard let data = defaults.data(forKey: key),
              let articles = try? JSONDecoder().decode([Article].self, from: data) else {
            return []
        }
        return articles
    }

    func save(_ article: Article) {
        var current = getFavorites()
        guard !current.contains(where: { $0.url == article.url }) else { return }
        current.append(article)
        if let encoded = try? JSONEncoder().encode(current) {
            defaults.set(encoded, forKey: key)
        }
    }
    
    func remove(_ article: Article) {
        var current = getFavorites()
        current.removeAll { $0.url == article.url }
        if let encoded = try? JSONEncoder().encode(current) {
            defaults.set(encoded, forKey: key)
        }
    }

    func isFavorited(_ article: Article) -> Bool {
        return getFavorites().contains { $0.url == article.url }
    }
}
