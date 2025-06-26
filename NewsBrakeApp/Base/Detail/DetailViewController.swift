//
//  DetailViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 17.06.2025.
//
import UIKit
import WebKit

protocol DetailViewControllerDelegate: AnyObject {
    func didSelectNews(data: Article)
}

class DetailViewController: UIViewController{
    
    var data: Article?
    private var click: Bool = false
    private var webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        title = "NEWS"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action:  #selector(addToFavorites))
        navigationItem.rightBarButtonItem?.tintColor = .systemPurple
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action:  #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .systemPurple
        
        click = ArticleStorageManager.shared.isFavorited(data!)
        updateFavoriteButton()
        loadUI()
    }
    
    private func loadUI() {
        view.addSubview(webView)
        webView.autoPinEdge(.left, to: .left, of: view)
        webView.autoPinEdge(.right, to: .right, of: view)
        webView.autoPinEdge(.top, to: .top, of: view)
        webView.autoPinEdge(.bottom, to: .bottom, of: view)
        
        if let url = URL(string: data?.url ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
            
        }
    }
    
    private func updateFavoriteButton() {
        let imageName = click ? "heart.fill" : "heart"
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
        guard let article = data else { return }
        click.toggle()
        
        if click {
            ArticleStorageManager.shared.save(article)
            NotificationCenter.default.post(name: .didAddFavoriteNews, object: nil)
        } else {
            ArticleStorageManager.shared.remove(article)
            NotificationCenter.default.post(name: .removeFavoriteNews, object: nil)
        }
        updateFavoriteButton()
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
