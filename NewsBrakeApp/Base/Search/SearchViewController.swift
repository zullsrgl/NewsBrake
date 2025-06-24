//
//  SearchViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//

import PureLayout

protocol SearchCategoryDelegate {
    func didSelectCategory(category: String)
}

class SearchViewController: UIViewController, SearchDelegate, DetailViewDelegate, SearchCategoryDelegate {
    
    private let searchBar = UISearchBar()
    let segmentView = SearchCatogoryView()
    private let collectionView = SearchCollectionView()
    let viewModel = SearchViewModel()
    var articals : [Article] = []
    var filteredArticles: [Article] = []
    
    let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        viewModel.fetchNews()
        viewModel.searchDelegate = self
        collectionView.delegate = self
        searchBar.delegate = self
        segmentView.delegate = self
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewSafeArea()
        
        stackContainerView.addArrangedSubview(searchBar)
        stackContainerView.addArrangedSubview(segmentView)
        
        searchBar.placeholder = "search anythink"
        searchBar.keyboardType = .default
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        searchBar.autoSetDimension(.height, toSize: 36)
        searchBar.autoPinEdge(.top, to: .top, of: stackContainerView)
        
        stackContainerView.addArrangedSubview(segmentView)
        segmentView.stackView.autoSetDimension(.height, toSize: 32)
        segmentView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        stackContainerView.addArrangedSubview(collectionView)
        
    }
    
    func didUpload() {
        self.articals = viewModel.articals
        self.collectionView.articals = self.articals
    }
    
    func navigateToDetail(data: Article) {
        let vc = DetailViewController()
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectCategory(category: String) {
        filteredArticles = articals.filter { article in
            article.content?.lowercased().contains(category.lowercased()) == true ||
            article.description?.lowercased().contains(category.lowercased()) == true
        }
        collectionView.articals = filteredArticles
        collectionView.collectionView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredArticles = articals
        }else {
            filteredArticles = articals.filter{
                $0.description?.localizedCaseInsensitiveContains(searchText) ?? true || $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        collectionView.articals = filteredArticles
        collectionView.collectionView.reloadData()
    }
}
