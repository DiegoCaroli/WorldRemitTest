//
//  UserCell.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell, Reusable {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var reputationLabel: UILabel!
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var blockButton: UIButton!
    @IBOutlet private weak var innerStackView: UIStackView!
    @IBOutlet private weak var followImageView: UIImageView!

    var didBlockTap: (() -> ())?
    var didFollowTap: (() -> ())?

    private lazy var overlayView: UIView = {
        let view = UIView(frame: contentView.frame)
        view.autoresizingMask = [.flexibleWidth]
        view.backgroundColor = .lightGray
        view.accessibilityIdentifier = "overlayView"
        view.alpha = 0.7
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        followButton.layer.cornerRadius = 7
        blockButton.layer.cornerRadius = 7

        followImageView.image = followImageView.image?.withRenderingMode(.alwaysTemplate)
        followImageView.tintColor = .blue
        followImageView.isHidden = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        followButton.setTitle("Follow", for: .normal)
        isUserInteractionEnabled = true
        overlayView.removeFromSuperview()
        innerStackView.isHidden = true
        profileImageView.image = UIImage(named: "placeholderProfile")
        followImageView.isHidden = true
    }

    func configure(for viewModel: UserViewModel) {
        nameLabel.text = viewModel.name
        reputationLabel.text = viewModel.reputation

        if viewModel.isExpand {
            innerStackView.isHidden = false
        }

        followButton.setTitle(viewModel.isFollowed ? "Unfollow" : "Follow", for: .normal)
        followImageView.isHidden = viewModel.isFollowed ? false : true

        if viewModel.isBlocked {
            setupBlock()
        }

        viewModel.fetchImage { [weak self] image in
            self?.profileImageView.image = image
        }

    }

    func expandCollapse() {
        innerStackView.isHidden.toggle()
    }

    private func setupBlock() {
        contentView.addSubview(overlayView)
        isUserInteractionEnabled = false
    }

    @IBAction private func followButtonTapped() {
        followButton.setTitle(followButton.titleLabel?.text == "Follow" ? "Unfollow" : "Follow", for: .normal)
        followImageView.isHidden.toggle()
        didFollowTap?()
    }

    @IBAction private func blockButtonTapped() {
        setupBlock()
        didBlockTap?()
    }
}
