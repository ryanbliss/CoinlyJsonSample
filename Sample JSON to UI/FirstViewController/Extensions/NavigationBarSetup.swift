//
//  NavigationControllerSetup.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 4/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

// Navigation Bar Setup12
extension FirstViewController {
    @objc func titleWasTapped() {
        print("cool")
    }
    
    func addTitleToNavigationBar() {
        let titleView = UILabel()
        titleView.text = self.viewModel.getNavTitle()
        titleView.font = UIFont(name: "futura-bold", size: 18)
        titleView.textColor = UIColor.white
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        
        var height: CGFloat = 0
        if self.navigationController?.navigationBar.frame.height != nil {
            height = self.navigationController!.navigationBar.frame.height
        }
        
        titleView.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: width, height: height))
        self.navigationItem.titleView = titleView
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(titleWasTapped))
        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(recognizer)
    }
    
    func setupNavigationBarLayout() {
        navigationController?.navigationBar.barTintColor = viewModel.getPrimaryColor()
        navigationController?.navigationBar.isTranslucent = false
        let dividerColor = ColorHelper.hexStringToUIColor(hex: "#EFEFF4")
        self.navigationController?.navigationBar.shadowImage = dividerColor.as1ptImage()
        self.navigationController?.navigationBar.setBackgroundImage(viewModel.getPrimaryColor().as1ptImage(), for: .default)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = self.viewModel.shouldShowNavBar()
        addTitleToNavigationBar()
    }
}

