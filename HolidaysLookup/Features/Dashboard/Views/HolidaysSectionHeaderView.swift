//
//  HolidaysSectionHeaderView.swift
//  HolidaysLookup
//
//  Created by Julian Flint Pearce on 20/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import UIKit

class HolidaysSectionHeaderView: UITableViewHeaderFooterView {
    
    private let titleLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        newLabel.font = .preferredFont(forTextStyle: .title2)
        
        return newLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        backgroundView = UIView(frame: bounds)
        backgroundView?.backgroundColor = UIColor(white: 1, alpha: 0.98)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)])
    }
    
    func setText(_ text: String) {
        titleLabel.text = text
    }
    
    func setTextColor(_ color: UIColor) {
        titleLabel.textColor = color
    }
    
}
