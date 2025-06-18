//
//  FavoritesViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//

import PureLayout

class FavoritesViewController: UIViewController {
    
    let favoritesTableView = FavoritesTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        loadUI()
     
    }
    
    private func loadUI(){
        view.addSubview(favoritesTableView)
        favoritesTableView.autoPinEdge(.left, to: .left, of: view)
        favoritesTableView.autoPinEdge(.right, to: .right, of: view)
        favoritesTableView.autoPinEdge(.top, to: .top, of: view)
        favoritesTableView.autoPinEdge(.bottom, to: .bottom, of: view)
        
    }
}
