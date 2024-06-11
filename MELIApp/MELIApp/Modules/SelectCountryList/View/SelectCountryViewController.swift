//
//  SelectCountryViewController.swift
//  MELIApp
//
//  Created by Jorge Menco on 10/06/24.
//

import UIKit
import Combine
import CoreLocation
import MELIAppData
import MELIAppDomain

final class SelectCountryViewController: UIViewController, SelectCountryViewType {
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 10
        static let paddingRight: CGFloat = 10
        static let paddingBottom: CGFloat = 10
        static let countryCellHeight: CGFloat = 50
        static let emptyStateNetworkImage = "wifi.slash"
    }
    
    // MARK: - Private properties -
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .meliLighGray
        label.numberOfLines = 0
        label.text = Strings.SelectCountry.titleTable
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductListTableViewCell.self, forCellReuseIdentifier: ProductListTableViewCell.reuseIdentifier)
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
    
    var countries: [Country] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: SelectCountryPresenterType?
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitleLabel()
        setupTableView()
        MELILocationManager.shared.requestLocationAuthorization()
        presenter?.fetchCountries()
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
    
    func showErrorView(text: String) {
        tableView.setEmptyState(text: text, image: Constants.emptyStateNetworkImage)
    }
    
    // MARK: - Private methods -
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.addConstraints(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            paddingTop: Constants.paddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.addConstraints(
            top: titleLabel.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: Constants.paddingTop)
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
}

// MARK: - UITableViewDelegate -

extension SelectCountryViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        presenter?.goToSearchProducts(idCountry: country.id)
    }
}

// MARK: - UITableViewDataSource -

extension SelectCountryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.countryCellHeight
    }
}
