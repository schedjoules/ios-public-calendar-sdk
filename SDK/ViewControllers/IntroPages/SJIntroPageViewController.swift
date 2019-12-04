//
//  SJIntroPageViewController.swift
//  iOS-SDK
//
//  Created by Alberto Huerdo on 11/13/19.
//  Copyright © 2019 SchedJoules. All rights reserved.
//

import UIKit

protocol SJIntroPageDelegate: class {
    func lastViewReached(result: Bool)
}

class SJIntroPageViewController: UIPageViewController {
    
    //Properties
    weak var sjIntroPageDelegate: SJIntroPageDelegate?
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [SJIntroPageContentViewController(.discover),
                SJIntroPageContentViewController(.subscribe),
                SJIntroPageContentViewController(.enjoy),
                SJIntroPageContentViewController(.freeTrial)]
    }()
    
    private var currentIndex: Int = 0
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupProperties()
        setupUI()
    }
    
    func setupProperties() {
        dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        view.backgroundColor = .sjIntroBackground
    }
    
    
    
}

extension SJIntroPageViewController {
    
    func slideToNextPage() {
        guard let currentViewController = self.viewControllers?.first else {
            return
        }

        guard let nextViewController = dataSource?.pageViewController(self,
                                                                      viewControllerAfter: currentViewController ) else {
            return
        }

        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        setViewControllers([nextViewController], direction: .forward, animated: true) { (completed) in
            self.delegate?.pageViewController?(self,
                                               didFinishAnimating: true,
                                               previousViewControllers: [],
                                               transitionCompleted: completed)
        }
        
        sjIntroPageDelegate?.lastViewReached(result: currentIndex == (orderedViewControllers.count - 1))
    }
    
}


// MARK: UIPageViewControllerDataSource

extension SJIntroPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        sjIntroPageDelegate?.lastViewReached(result: orderedViewControllers.last == pendingViewControllers.first)
    }
}


// MARK: UIPageViewControllerDataSource

extension SJIntroPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        currentIndex = previousIndex
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        currentIndex = nextIndex
        return orderedViewControllers[nextIndex]
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = .gray
        appearance.currentPageIndicatorTintColor = .black
        appearance.backgroundColor = .sjGrayLight
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl()
        return self.orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}

