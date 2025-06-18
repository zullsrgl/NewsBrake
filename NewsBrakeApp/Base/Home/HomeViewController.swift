//
//  ViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//
import PureLayout

protocol DetailViewDelegate: AnyObject {
    func navigateToDetail(url: String)
}

class HomeViewController: UIViewController, DetailViewDelegate, NewsDelegate {
    
    let viewModel = HomeViewModel()
    let homeNewsColleciton = HomeNewsCollectionView()
    var articles: [Article] = []
    
    let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "News Brake"
        viewModel.newsDelegate = self
        homeNewsColleciton.delegate = self
        didUpdateNews()
        viewModel.fetchNews()
        loadUI()
    }
    
    func loadUI(){
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
        
        stackContainerView.addArrangedSubview(homeNewsColleciton)
        homeNewsColleciton.autoMatch(.width, to: .width, of: stackContainerView)
        homeNewsColleciton.autoSetDimension(.height, toSize: UIScreen.main.bounds.height)
    }
    func navigateToDetail(url: String) {
        let vc = DetailViewController()
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didUpdateNews() {
        print("news delegate")
        self.articles = self.viewModel.articals
        self.homeNewsColleciton.article = self.articles
    }
    
}

