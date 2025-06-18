//
//  DetailViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 17.06.2025.
//
import UIKit
import WebKit

class DetailViewController: UIViewController{
    
    var url: String?
    var click: Bool = false
    
    var webView: WKWebView = {
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
        
        loadUI()
    }
    
    func loadUI() {
        view.addSubview(webView)
        webView.autoPinEdge(.left, to: .left, of: view)
        webView.autoPinEdge(.right, to: .right, of: view)
        webView.autoPinEdge(.top, to: .top, of: view)
        webView.autoPinEdge(.bottom, to: .bottom, of: view)
        
        if let url = URL(string: url ?? "") {
           let request = URLRequest(url: url)
           webView.load(request)
            
        }
    }
    
    @objc func addToFavorites() {
        click.toggle()
        let imageName = click ? "heart.fill" : "heart"
        let favoriteButton = UIBarButtonItem(
              image: UIImage(systemName: imageName),
              style: .plain,
              target: self,
              action: #selector(addToFavorites)
          )
          favoriteButton.tintColor = .systemPurple
          navigationItem.rightBarButtonItem = favoriteButton
    }
    
//TODO: -delete this code
    
//    @objc func toggleFavorite() {
//        print("favorilere ekle")
//    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
