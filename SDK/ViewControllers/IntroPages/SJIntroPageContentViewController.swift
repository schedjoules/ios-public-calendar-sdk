//
//  SJIntroPageContentViewController.swift
//  iOS-SDK
//
//  Created by Alberto Huerdo on 11/13/19.
//  Copyright © 2019 SchedJoules. All rights reserved.
//

import UIKit

class SJIntroPageContentViewController: UIViewController {
    
    enum Content {
        case discover
        case subscribe
        case enjoy
        case freeTrial
    }
    
    //UI
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 26)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    //Properties
    var content: SJIntroPageContent
    
    
    init(_ content: Content) {
        self.content = SJIntroPageContent(content)
        
        super.init(nibName: nil, bundle: nil)
        
        setupProperties()
    }
    
    private func setupProperties() {
        titleLabel.text = content.title.uppercased()
        descriptionLabel.text = content.description
        imageView.image = content.image
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .sjIntroBackground
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





struct SJIntroPageContent {
    let title: String
    let description: String
    let image: UIImage?
    
    init(_ content: SJIntroPageContentViewController.Content) {
        switch content {
        case .discover:
            title = "discover"
            description = "thousands of interesting calendars for holidays, sports, TV, weather and more"
            image = UIImage(named: "sj-walkthrough-screen-discover", in: Bundle.resourceBundle, compatibleWith: nil)
            break
        case .subscribe:
            title = "subscribe"
            description = "to your favourite calendars and enjoy automatic updates"
            image = UIImage(named: "sj-walkthrough-screen-subscribe", in: Bundle.resourceBundle, compatibleWith: nil)
            break
        case .enjoy:
            title = "enjoy"
            description = "lots of extra info and sports results before, during and after an event"
            image = UIImage(named: "sj-walkthrough-screen-enjoy", in: Bundle.resourceBundle, compatibleWith: nil)
            break
        case .freeTrial:
            title = "free trial"
            description = "enjoy our one month free trial with full access to all available calendars"
            image = UIImage(named: "sj-walkthrough-screen-free-trial", in: Bundle.resourceBundle, compatibleWith: nil)
            break
        }
        
    }
    
}
