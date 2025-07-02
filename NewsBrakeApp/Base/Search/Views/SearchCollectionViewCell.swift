//
//  SearchCollectionViewCell.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 23.06.2025.
//
import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    private let gradientLayer = CAGradientLayer()
    
    private let bgView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let gradiantView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let newsImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray
        view.tintColor = .gray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentLabel: UILabel = {
        var lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        return lbl
    }()
    
    private let sourceLabel: UILabel = {
        var lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradiantView.bounds
    }
    
    private func setUpUI(){
        
        self.addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdges()
        
        bgView.addSubview(newsImage)
        newsImage.autoPinEdgesToSuperviewEdges()
        
        contentView.addSubview(gradiantView)
        gradiantView.autoPinEdgesToSuperviewEdges()
        
        gradiantView.addSubview(sourceLabel)
        sourceLabel.autoPinEdge(.left, to: .left, of: bgView, withOffset: 8)
        sourceLabel.autoPinEdge(.bottom, to: .bottom, of: bgView)
        sourceLabel.autoPinEdge(.right, to: .right, of: bgView, withOffset: -8)
        
        gradiantView.addSubview(contentLabel)
        contentLabel.autoPinEdge(.bottom, to: .top, of: sourceLabel, withOffset: -24)
        contentLabel.autoPinEdge(.left, to: .left, of: bgView, withOffset: 8)
        contentLabel.autoPinEdge(.right, to: .right, of: bgView, withOffset: -8)
        
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.5).cgColor,UIColor.clear.cgColor]
        gradientLayer.cornerRadius = 10
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradiantView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setData(article: Article){
        
        contentLabel.text = article.content
        sourceLabel.text = article.source?.name
        
        if let urlString = article.urlToImage, let url = URL(string: urlString){
            newsImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            newsImage.image = UIImage(systemName: "magnifyingglass.circle")
        }
    }
}
