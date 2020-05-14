//
//  LoadingViewController.swift
//  RestTest
//
//  Created by Julian Flint Pearce on 13/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.85)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.color = .label
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NSLayoutConstraint(item: spinner,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerY,
                multiplier: 0.5, constant: 0)
        ])
    }
}
