//
//  FavoriteTableViewCell.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 18.06.2025.
//
import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let bgView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let newsImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "newsss")
        image.layer.cornerRadius = 10
        image.layer.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        return image
    }()
    
    private let contentLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "this is a news content,this is a news content,this is a news content,this is a news contentthis is a news contentthis is a news contentthis is a news content,this is a news content,this is a news content"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private let sourceLabel: UILabel = {
        var label = UILabel()
        label.textColor = .blue
        label.numberOfLines = 0
        label.text = "source: unknow"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        contentView.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
        
        stackContainerView.addArrangedSubview(newsImage)
        newsImage.autoSetDimension(.height, toSize: 100)
        newsImage.autoSetDimension(.width, toSize: 100)
        newsImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        stackContainerView.addArrangedSubview(bgView)
        bgView.autoPinEdge(.left, to: .right, of: newsImage)
        bgView.autoPinEdge(.top, to: .top, of: stackContainerView)
        bgView.autoPinEdge(.bottom, to: .bottom, of: stackContainerView)
        
        bgView.addSubview(sourceLabel)
        sourceLabel.autoPinEdge(.left, to: .left, of: bgView)
        sourceLabel.autoPinEdge(.bottom, to: .bottom, of: bgView, withOffset: -6)
        sourceLabel.autoSetDimension(.height, toSize: 16)
        
        bgView.addSubview(contentLabel)
        contentLabel.autoPinEdge(.left, to: .left, of: bgView, withOffset: 8)
        contentLabel.autoPinEdge(.top, to: .top, of: bgView)
        contentLabel.autoPinEdge(.bottom, to: .top, of: sourceLabel, withOffset: -8)
        contentLabel.autoPinEdge(.right, to: .right, of: bgView, withOffset: -8)
    }
}
