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
     
        NotificationCenter.default.addObserver(self, selector: #selector(newsAdded), name: .didAddFavoriteNews, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNews), name: .removeFavoriteNews, object: nil)
        
        favoritesTableView.delegate = self
        loadUI()
    }
    
    private func loadUI(){
        view.addSubview(favoritesTableView)
        favoritesTableView.autoPinEdge(.left, to: .left, of: view)
        favoritesTableView.autoPinEdge(.right, to: .right, of: view)
        favoritesTableView.autoPinEdge(.top, to: .top, of: view)
        favoritesTableView.autoPinEdge(.bottom, to: .bottom, of: view)
        
    }
    
    @objc func newsAdded(){
        favoritesTableView.articleData = ArticleStorageManager.shared.getFavorites()
        favoritesTableView.reloadData()
    }
    
    @objc func deleteNews(){
        favoritesTableView.articleData = ArticleStorageManager.shared.getFavorites()
        favoritesTableView.reloadData()
    }
}

extension FavoritesViewController:  DetailViewControllerDelegate{
    func didSelectNews(data: Article) {
        let vc = DetailViewController(data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}
