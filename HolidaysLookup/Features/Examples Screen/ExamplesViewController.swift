//
//  ExamplesViewController.swift
//  RestTest
//
//  Created by Julian Flint Pearce on 09/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import UIKit

class ExamplesViewController: UIViewController {
    let largeTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "Large Title"
        label.textColor = .systemRed
        
        return label
    }()
    
    let title1Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "Title 1"
        label.textColor = .systemIndigo
        
        return label
    }()
    
    let title2Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = "Title 2"
        label.textColor = .systemPurple
        
        return label
    }()
    
    let title3Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = "Title 3"
        label.textColor = .systemPink
        
        return label
    }()

    let headlineLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Headline"
        label.textColor = .systemBlue
        
        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Body"
        label.textColor = .systemTeal
        
        return label
    }()
    
    let calloutLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        label.text = "Callout"
        label.textColor = .systemYellow
        
        return label
    }()
    
    let subheadLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "Subhead"
        label.textColor = .systemOrange
        
        return label
    }()
    
    let footnoteLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.text = "Footnote"
        label.textColor = .systemGreen
        
        return label
    }()
    
    let caption1Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.text = "Caption 1"
        label.textColor = .systemGray
        
        return label
    }()
    
    let caption2Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption2)
        label.text = "Caption 2"
        label.textColor = .systemGray6
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let stackView = UIStackView(arrangedSubviews: [
            largeTitleLabel,
            title1Label,
            title2Label,
            title3Label,
            headlineLabel,
            bodyLabel,
            calloutLabel,
            subheadLabel,
            footnoteLabel,
            caption1Label,
            caption2Label
        ])
        
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
    }
}
