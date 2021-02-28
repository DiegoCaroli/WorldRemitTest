//
//  UsersViewController.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var usersTableView: UITableView!

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refreshControlDidFire),
                                 for: .valueChanged)
        usersTableView.refreshControl = refreshControl
        return refreshControl
    }()
    var viewModel: UsersViewModel!
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        configureNavigationBar()
        viewModel.fetchUsers()
        setupDataBinding()
    }

}

private extension UsersViewController {
    func setupTableView() {
        usersTableView.dataSource = self
        usersTableView.delegate = self

        usersTableView.register(UserCell.nib,
                                forCellReuseIdentifier: UserCell.reuseIdentifier)

        usersTableView.addSubview(refreshControl)
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }

    func setupDataBinding() {
        coordinator?.addErrorLoading()

        viewModel.onUsersUpdate = { [unowned self] in
            coordinator?.removeErrorLoading()
            self.usersTableView.reloadData()
        }

        viewModel.onErrorUpdate = { [weak self] error in
            DispatchQueue.main.async {
                self?.coordinator?.showError(error)
            }
        }
    }

    @objc func refreshControlDidFire() {
        viewModel.fetchUsers()
        usersTableView.refreshControl?.endRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserCell.reuseIdentifier,
            for: indexPath) as? UserCell else {
                fatalError("Expected UserCell")
        }

        let viewModel = self.viewModel.users[indexPath.row]
        cell.configure(for: viewModel)

        cell.didFollowTap = {
            viewModel.isFollowed.toggle()
        }

        cell.didBlockTap = {
            if viewModel.isExpand {
                cell.expandCollapse()
                viewModel.isExpand.toggle()
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            viewModel.isBlocked.toggle()
        }

        return cell
    }

}

// MARK: - UITableViewDelegate
extension UsersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }

        cell.expandCollapse()
        let viewModel = self.viewModel.users[indexPath.row]
        viewModel.isExpand.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
