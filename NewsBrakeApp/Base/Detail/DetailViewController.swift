//
//  DetailViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 17.06.2025.
//
import UIKit
import WebKit

class DetailViewController: UIViewController{
    
    init(data: Article) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var isFavorite: Bool {
        get {
            return ArticleStorageManager.shared.isFavorited(data)
        }
    }
    
    var data: Article
    
    private var webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        navigationItem.title = "NEWS"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action:  #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .systemPurple
        
        updateFavoriteButton()
        loadUI()
    }
    
    private func loadUI() {
        view.addSubview(webView)
        webView.autoPinEdge(.left, to: .left, of: view)
        webView.autoPinEdge(.right, to: .right, of: view)
        webView.autoPinEdge(.top, to: .top, of: view)
        webView.autoPinEdge(.bottom, to: .bottom, of: view)
        
        if let url = URL(string: data.url) {
            let request = URLRequest(url: url)
            webView.load(request)
            
        }
    }
    
    private func updateFavoriteButton() {
        let imageName = isFavorite ? "heart.fill" : "heart"
        let button = UIBarButtonItem(
            image: UIImage(systemName: imageName),
            style: .plain,
            target: self,
            action: #selector(addToFavorites)
        )
        button.tintColor = .systemPurple
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func addToFavorites() {
        
        if isFavorite {
            ArticleStorageManager.shared.remove(data)
        } else {
            ArticleStorageManager.shared.save(data)
        }
        
        NotificationCenter.default.post(name: .didChangeFavoriteNews, object: nil)
        
        updateFavoriteButton()
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
