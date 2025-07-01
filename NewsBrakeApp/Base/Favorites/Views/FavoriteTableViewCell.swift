//
//  FavoriteTableViewCell.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 18.06.2025.
//
import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let identifier = "favoriteTableViewIdentifier"
    
    private let bgView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let newsImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private let contentLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let sourceLabel: UILabel = {
        var label = UILabel()
        label.textColor = .purple
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        contentView.addSubview(newsImage)
        newsImage.autoSetDimension(.height, toSize: 100)
        newsImage.autoSetDimension(.width, toSize: 100)
        newsImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        newsImage.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16)
        
        contentView.addSubview(bgView)
        bgView.autoPinEdge(.left, to: .right, of: newsImage, withOffset: 10)
        bgView.autoPinEdge(.top, to: .top, of: contentView)
        bgView.autoPinEdge(.bottom, to: .bottom, of: contentView)
        bgView.autoPinEdge(.right, to: .right, of: contentView)
        
        bgView.addSubview(sourceLabel)
        sourceLabel.autoPinEdge(.left, to: .left, of: bgView, withOffset: 8)
        sourceLabel.autoPinEdge(.bottom, to: .bottom, of: bgView, withOffset: -24)
        sourceLabel.autoSetDimension(.height, toSize: 16)
        
        bgView.addSubview(contentLabel)
        contentLabel.autoPinEdge(.left, to: .left, of: bgView, withOffset: 8)
        contentLabel.autoPinEdge(.top, to: .top, of: bgView)
        contentLabel.autoPinEdge(.bottom, to: .top, of: sourceLabel, withOffset: -8)
        contentLabel.autoPinEdge(.right, to: .right, of: bgView, withOffset: -8)
    }
    
    func setData(articals: Article){
        
        contentLabel.text = articals.title
        sourceLabel.text = articals.source?.name
        
        if let urlString = articals.urlToImage, let imageUrl = URL(string: urlString) {
            newsImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        } else {
            newsImage.contentMode = .scaleAspectFit
            newsImage.image = UIImage(systemName: "magnifyingglass.circle")
        }
    }
}
