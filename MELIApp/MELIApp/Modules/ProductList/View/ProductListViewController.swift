//
//  ProductListViewController.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit
import MELIAppDomain
import MELIAppData

final class ProductListViewController: UIViewController, ProductListViewType {
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 10
        static let paddingRight: CGFloat = 10
        static let paddingBottom: CGFloat = 10
        static let contentViewCornerRadius: CGFloat = 10
        static let contentViewPaddingTop: CGFloat = 150
        static let contentViewShadowRadius: CGFloat = 4
        static let shadowOpacity: Float = 0.3
        static let searchViewHeight: CGFloat = 150
        static let productRowHeight: CGFloat = 140
        static let emptyStateImage = "magnifyingglass.circle"
        static let emptyStateNetworkImage = "wifi.slash"
    }
    
    // MARK: - Private properties -
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = Strings.ProductList.searchBarPlaceholder
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 20
        searchBar.delegate = self
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    private lazy var ContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .meliGrayBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductListTableViewCell.self, forCellReuseIdentifier: ProductListTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var loadingView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()
    
    // MARK: - internal Properties -

    
    var items: [ProductInformation] = [] {
        didSet {
            if items.isEmpty {
                productListState = .emptyResults
            }
            tableView.reloadData()
        }
    }

    var productListState: ProductListState = .initialEmpty {
        didSet {
            checkEmptyState()
        }
    }
    
    var presenter: ProductListPresenterType?
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.meliGrayBackground
        setupSearchBar()
        setupContentView()
        setupTableView()
        checkEmptyState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setupNavigationBarAppearance()
    }
    
    // MARK: - internal methods -

    func removeLoadingView() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    // MARK: - Private methods -
    
    private func setupSearchBar() {
        self.navigationItem.titleView = searchBar
    }
    
    private func setupContentView() {
        view.addSubview(ContentView)
        ContentView.backgroundColor = .white
        ContentView.layer.cornerRadius = Constants.contentViewCornerRadius
        ContentView.layer.shadowColor = UIColor.black.cgColor
        ContentView.layer.shadowOpacity = Constants.shadowOpacity
        ContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        ContentView.layer.shadowRadius = Constants.contentViewShadowRadius
        
        ContentView.addConstraints(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingLeft: Constants.paddingLeft,
            paddingBottom: Constants.paddingBottom,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupTableView() {
        ContentView.addSubview(tableView)
        tableView.addConstraints(
            top: ContentView.topAnchor,
            leading: ContentView.leadingAnchor,
            bottom: ContentView.bottomAnchor,
            trailing: ContentView.trailingAnchor)
    }
    
    private func showLoadingView() {
        loadingView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        loadingView.backgroundColor = .meliLighBlue
        activityIndicator.center = self.view.center
        activityIndicator.color = .meliBlue
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    private func checkEmptyState() {
        switch productListState {
        case .initialEmpty:
            tableView.setEmptyState(
                text: Strings.ProductList.emptyStateTitle,
                image: Constants.emptyStateImage)
        case .emptyResults:
            tableView.setEmptyState(
                text: Strings.ProductList.emptyStateResultTitle,
                image: Constants.emptyStateImage)
        case .NetworkError:
            items = []
            tableView.setEmptyState(
                text: Strings.ProductList.emptyStateNetworkTitle,
                image: Constants.emptyStateNetworkImage)
        case .filled, .searchring:
            tableView.backgroundView = nil
        }
    }
}

// MARK: - UITableViewDelegate -

extension ProductListViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        presenter?.goToProductDeatil(item)
    }
}

// MARK: - UITableViewDataSource -

extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.reuseIdentifier, for: indexPath) as! ProductListTableViewCell
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.productRowHeight
    }
}

// MARK: - UITableViewDataSource -

extension ProductListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            productListState = .searchring
            showLoadingView()
            presenter?.searchProducts(query: searchText)
        } else {
            items = []
        }
    }
}
