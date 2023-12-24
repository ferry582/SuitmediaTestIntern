//
//  ThirdScreenViewController.swift
//  Suitmedia Test
//
//  Created by Ferry Dwianta P on 23/12/23.
//

import UIKit

protocol ThirdScreenDelegate: AnyObject {
    func userSelected(name: String)
}

class ThirdScreenViewController: UIViewController {
    
    // MARK: -Variables
    private var viewModel: ThirdScreenViewModel
    weak var delegate: ThirdScreenDelegate?
    var listUsers: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                if self.listUsers.isEmpty {
                    self.usersTableView.isHidden = true
                    self.emptyLabel.isHidden = false
                } else {
                    self.usersTableView.isHidden = false
                    self.emptyLabel.isHidden = true
                }
                self.usersTableView.reloadData()
            }
        }
    }
    private var currentPage: Int = 1
    
    // MARK: -UI Components
    private let separatorView = SeparatorView()
    
    private let usersTableView: UITableView = {
        let table = UITableView()
        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        table.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(tableViewRefreshed), for: .valueChanged)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Data is empty!"
        label.textColor = .primaryTextColor
        label.font = UIFont.poppinsRegular(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: -Life Cycle
    init(_ viewModel: ThirdScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.dataSource = self
        usersTableView.delegate = self
        
        setupNavBar()
        setupView()
        
        Task {
            await viewModel.getUserList(page: currentPage)
        }
        
        // Observe list users data
        viewModel.listUsers.bind { users in
            self.listUsers = users ?? []
        }
        
        // Observe refresh state
        viewModel.isRefreshing.bind { isRefreshing in
            DispatchQueue.main.async {
                if isRefreshing! {
                    self.usersTableView.refreshControl?.beginRefreshing()
                } else {
                    self.usersTableView.refreshControl?.endRefreshing()
                    self.usersTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: -UI Setup
    private func setupNavBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .backButtonColor
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Third Screen"
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(separatorView)
        separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        
        view.addSubview(usersTableView)
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: -Actions
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func tableViewRefreshed() {
        currentPage = 1
        viewModel.removeAllListUsers()
        Task {
            await viewModel.getUserList(page: currentPage)
        }
    }
    
}

extension ThirdScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentPage < viewModel.totalPage && indexPath.row == listUsers.count-1 {
            // show loading cell at bottom
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.identifier)
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell
            cell?.configure(with: listUsers[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if currentPage < viewModel.totalPage && indexPath.row == listUsers.count-1 {
            currentPage += 1
            Task {
                await viewModel.getUserList(page: currentPage)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.userSelected(name: "\(listUsers[indexPath.row].firstName) \(listUsers[indexPath.row].lastName)")
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
