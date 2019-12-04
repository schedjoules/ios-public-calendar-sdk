//
//  SJIntroViewController.swift
//  iOS-SDK
//
//  Created by Alberto Huerdo on 10/30/19.
//  Copyright © 2019 SchedJoules. All rights reserved.
//

import UIKit


class SJIntroViewController: UIViewController {
    
    //Properties
    var lastViewReached = false
    
    
    //UI
    let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .sjRed
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        return button
    }()
    
    let bottomContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .sjGrayLight
        return view
    }()
    
    let topContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .sjIntroBackground
        return view
    }()
    
    let pageViewController: SJIntroPageViewController = {
        let viewController = SJIntroPageViewController()
        return viewController
    }()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup the subviews
        view.addSubview(stackView)
        stackView.addArrangedSubview(topContainerView)
        stackView.addArrangedSubview(bottomContainerView)
        bottomContainerView.addSubview(nextButton)
        
        //Add the SJIntroPageViewController as a child vc
        topContainerView.addSubview(pageViewController.view)
        addChildViewController(pageViewController)
        pageViewController.didMove(toParentViewController: self)
        pageViewController.sjIntroPageDelegate = self
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nextButton.heightAnchor.constraint(equalToConstant: 64),
            nextButton.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            nextButton.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 64),
            nextButton.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -64),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
            pageViewController.view.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor)
        ])
    }
    
    //MARK: Actions
    
    @objc func goToNextPage() {
        if lastViewReached == true {
            self.dismiss(animated: true, completion: nil)
            UserDefaults.standard.hasSeenIntro = true
        } else {
            pageViewController.slideToNextPage()
        }
    }
    
}


extension SJIntroViewController: SJIntroPageDelegate {
    
    func lastViewReached(result: Bool) {
        self.lastViewReached = result
        
        var newTitle = "Next"
        if result == true {
            newTitle = "Start"
        }
        
        guard newTitle != nextButton.currentTitle else {
            return
        }
        
        nextButton.setTitle(newTitle, for: .normal)
    }
    
}
