//
//  NewsCacheManager.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 7.07.2025.
//

import UIKit

final class NewsCacheManager {
    
    private lazy var cacheKey = "cachedNews"
    private lazy var timestampKey = "cachedTimestamp"
    
    func saveNews(_ news: [Article]){
        if let encoded = try? JSONEncoder().encode(news){
            UserDefaults.standard.set(encoded, forKey: cacheKey)
            UserDefaults.standard.set(Date(), forKey: timestampKey)
        }
    }
    
    func loadNews() -> [Article]? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else {return nil}
        return try? JSONDecoder().decode([Article].self, from: data)
    }
    
    func isCacheExpired(maxInterval: TimeInterval = 3600) -> Bool {
        guard let timestamp = UserDefaults.standard.object(forKey: timestampKey) as? Date else {return true}
        
        return Date().timeIntervalSince(timestamp) > maxInterval
    }
}
