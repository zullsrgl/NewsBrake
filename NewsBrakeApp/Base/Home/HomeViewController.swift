//
//  ViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//
import PureLayout

protocol HomeViewControllerDelegate: AnyObject {
    func didSelectArticle(data: Article)
}

class HomeViewController: UIViewController{
    
    private  let viewModel = HomeViewModel()
    private let homeNewsColleciton = HomeNewsCollectionView()
    
    private let stackContainerView: UIStackView = {
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
        
        viewModel.delegate = self
        homeNewsColleciton.delegate = self
        viewModel.fetchNews()
        
        loadUI()
    }
    
    private func loadUI(){
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewEdges()
        
        stackContainerView.addArrangedSubview(homeNewsColleciton)
        homeNewsColleciton.autoMatch(.width, to: .width, of: stackContainerView)
        homeNewsColleciton.autoSetDimension(.height, toSize: UIScreen.main.bounds.height)
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    func didSelectArticle(data: Article) {
        let vc = DetailViewController(data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didUpdateNews(articals: [Article]) {
        homeNewsColleciton.articles = articals
    }
}

