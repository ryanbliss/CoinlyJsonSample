//
//  FirstViewController.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

protocol ButtonAction {
    func pressedButton(with endpoint: String)
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ButtonAction {
    
    @IBOutlet var tableView: UITableView!
    var cellHeights: [IndexPath: CGFloat?] = [:]
    
    var viewModel: FirstViewControllerViewModel = FirstViewControllerViewModel()
    
    @IBOutlet var footerView: UIView!
    @IBOutlet var footerHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
        
        self.tableView.bounces = false
        self.tableView.delegate = self
        
        // Scroll View Tap Gesture
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
        
    }
    
    func setup() {
        viewModel.base = NetworkingManager().getData(for: viewModel.endpoint)
        
        let nibs = viewModel.getNibs()
        for nib in nibs {
            tableView.register(nib.value, forCellReuseIdentifier: nib.key)
        }
        
        self.view.backgroundColor = viewModel.getPrimaryColor()
        self.tableView.backgroundColor = viewModel.getBackgroundColor()
        
        setupFooter()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setup()
        tableView.setNeedsLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(presentController), name: NSNotification.Name(rawValue: "presentController"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadPage), name: NSNotification.Name(rawValue: "reloadPage"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    var newEndpoint = ""
    func set(with endpoint: String) {
        self.viewModel.endpoint = endpoint
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Button Action
    
    func pressedButton(with endpoint: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "firstVC") as! FirstViewController
        vc.set(with: endpoint)
        self.newEndpoint = endpoint
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table View
    
    @available(iOS 2.0, *)
    open func numberOfSections(in tableView: UITableView) -> Int {
        let count = viewModel.getNumSections()
        return count
    }
    
    @available(iOS 2.0, *)
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    @available(iOS 2.0, *)
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = self.viewModel.getReuseIdentifier(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! GenericTableViewCell
        cell.data = viewModel.getCellData(for: indexPath)
        cell.buttonDelegate = self
        cell.updateDelegate = self
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cellHeights[indexPath] {
            return height ?? UITableViewAutomaticDimension
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func dismissPicker() {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Notification Listeners
    
    @objc func presentController(for notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        for item in userInfo {
            if let controller = item.value as? UIAlertController {
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    @objc func reloadPage(for notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        for item in userInfo {
            if let endpoint = item.value as? String {
                if endpoint != self.viewModel.endpoint {
                    self.set(with: endpoint)
                    self.setup()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


