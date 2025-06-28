//
//  FavoritesViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//

import PureLayout

class FavoritesViewController: UIViewController {
    
    private let favoritesTableView = FavoritesTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
    
        NotificationCenter.default.addObserver(self, selector: #selector(updateArticles), name: .didChangeFavoriteNews, object: nil)
        
        favoritesTableView.delegate = self
        loadUI()
    }
    
    private func loadUI(){
        view.addSubview(favoritesTableView)
        favoritesTableView.autoPinEdgesToSuperviewEdges()
    }
    
    @objc func updateArticles(){
        favoritesTableView.articles = ArticleStorageManager.shared.getFavorites()
    }
}

extension FavoritesViewController: FavoritesTableViewDelegate{
    func didSelectNews(data: Article) {
        let vc = DetailViewController(data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}
