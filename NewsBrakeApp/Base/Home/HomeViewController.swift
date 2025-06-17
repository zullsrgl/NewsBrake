//
//  ViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//
import PureLayout

class HomeViewController: UIViewController {
    
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
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
               self.articles = self.viewModel.articals
               self.homeNewsColleciton.article = self.articles
           }
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
}

