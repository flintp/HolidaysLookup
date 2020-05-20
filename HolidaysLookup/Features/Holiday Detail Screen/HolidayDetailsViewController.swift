//
//  HolidayDetailsViewController.swift
//  RestTest
//
//  Created by Julian Flint Pearce on 09/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import UIKit

class HolidayDetailsViewController: UIViewController {
    var model: HolidayDetailsModelController!
        
    let holidayNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = .label
        
        return label
    }()
    
    let holidayDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .label
        
        return label
    }()
    
    let holidayTypeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .label
        
        return label
    }()
    
    let holidayDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        
        
        return label
    }()
    
    //MARK: - Initalization
    
    init(model: Holiday) {
        self.model = HolidayDetailsModelController(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupUI()
    }
    
    private func setupConstraints() {
        //TODO: Maybe refactor this into a stackview?
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.addSubview(holidayNameLabel)
        containerView.addSubview(holidayDateLabel)
        containerView.addSubview(holidayTypeLabel)
        containerView.addSubview(holidayDescriptionLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
        ])

        NSLayoutConstraint.activate([
            holidayNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            holidayNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            holidayNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            holidayDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            holidayDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            holidayDateLabel.topAnchor.constraint(equalTo: holidayNameLabel.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            holidayTypeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            holidayTypeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            holidayTypeLabel.topAnchor.constraint(equalTo: holidayDateLabel.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            holidayDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            holidayDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            holidayDescriptionLabel.topAnchor.constraint(equalTo: holidayTypeLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        holidayNameLabel.text = model.getName
        holidayDateLabel.text = model.getDate
        holidayDescriptionLabel.text = model.getDescription
        holidayTypeLabel.text = model.getType
    }
}
