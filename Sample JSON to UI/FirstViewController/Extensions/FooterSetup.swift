//
//  FooterSetup.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 4/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

protocol FooterDelegate {
    func left()
    func right()
}

extension FirstViewController: FooterDelegate {
    func setupFooter() {
        let footer = viewModel.getFooter()
        let view = UINib(nibName: "FooterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FooterView
        
        guard let footerData = footer else { return }
        
        view.leftButton.setTitle(footerData.cancelButton.text, for: .normal)
        view.rightButton.setTitle(footerData.submitButton.text, for: .normal)
        view.backgroundColor = viewModel.getPrimaryColor()
        view.delegate = self
        
        footerHeight.constant = 60
        footerView.frame = view.frame
        footerView.addSubview(view)
    }
    
    // Footer Delegate
    func left() {
        self.dismiss(animated: true, completion: nil)
    }
    func right() {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(viewModel.base!)
        print(String(data: data, encoding: .utf8)!)
        self.dismiss(animated: true, completion: nil)
    }
}
