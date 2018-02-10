//
//  CustomPageViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 06.02.18.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class CustomPageViewController: UIPageViewController {
    
    private lazy var pages: [UIViewController] = {
        return [self.storyboard!.instantiateViewController(withIdentifier: "TimerPickerViewControllerID"),
                self.storyboard!.instantiateViewController(withIdentifier: "FavoriteCollectionViewControllerID")]
    }()
    
    private var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageControl()
        
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
    }
    
    private func configurePageControl() {
        pageControl = UIPageControl()
        pageControl.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let verticalConstraint = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal,
                                                    toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        let horizontalConstraint = NSLayoutConstraint(item: pageControl, attribute: .centerX, relatedBy: .equal,
                                                      toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: pageControl, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: pageControl, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)
        NSLayoutConstraint.activate([verticalConstraint, horizontalConstraint, widthConstraint, heightConstraint])
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }
    
    @objc func didChangeValue(_ sender: UIPageControl) {
        let index = sender.currentPage
        let nextViewController = pages[index]
        let direction: UIPageViewControllerNavigationDirection = index != 0 ? UIPageViewControllerNavigationDirection.forward : UIPageViewControllerNavigationDirection.reverse
        self.setViewControllers([nextViewController], direction: direction, animated: true, completion: nil)
    }
    

}

extension CustomPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getNextViewController(withAddingToCurrentIndex: -1, ofViewController: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(withAddingToCurrentIndex: 1, ofViewController: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentVC = pageViewController.viewControllers![0]
        pageControl.currentPage = pages.index(of: currentVC)!
    }
    
    private func getNextViewController(withAddingToCurrentIndex add: Int, ofViewController viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.index(of: viewController) else {
            return nil
        }
        let nextIndex = currentIndex + add
        
        if 0 ... pages.count - 1 ~= nextIndex {
            return pages[nextIndex]
        }
        return nil
    }
    
}
