//
//  SecondViewController.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class EditJsonViewController: UITableViewController {
    
    var viewModel = EditJsonViewModel()
    var navigatingForward = false
    
    @objc func returnHome(_ sender: Any) {
        viewModel.reset()
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = viewModel.getNavTitle()
        extendedLayoutIncludesOpaqueBars = true
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let barButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(returnHome(_:)))
        
        self.navigationItem.rightBarButtonItems = [barButton, self.editButtonItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !navigatingForward {
            viewModel.goBack()
        } else {
            navigatingForward = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    
    
    @available(iOS 2.0, *)
    open override func numberOfSections(in tableView: UITableView) -> Int {
        let count = 1
        return count
    }
    
    @available(iOS 2.0, *)
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    @available(iOS 2.0, *)
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getCellType(for: indexPath.row) {
        case .value:
            let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "valueCell")
            cell.textLabel?.text = viewModel.getTitle(for: indexPath.row)
            cell.detailTextLabel?.text = viewModel.getSubtitle(for: indexPath.row)
            return cell
        case .more:
            let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "moreCell")
            cell.textLabel?.text = viewModel.getTitle(for: indexPath.row)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .disclosureIndicator {
            //TODO: Go to new page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "jsonEdit") as! EditJsonViewController
            viewModel.setNextSubJson(for: cell!.textLabel?.text)
            navigatingForward = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            
            let alert = UIAlertController(title: "Edit Value", message: nil, preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = cell?.detailTextLabel?.text
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
                self.viewModel.editValue(for: cell!.textLabel!.text!, with: textField.text!)
                tableView.reloadData()
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        }
        cell?.isSelected = false
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        guard let cell = tableView.cellForRow(at: indexPath) else { return .none }
        let number = Int(cell.textLabel!.text!)
        if number != nil {
            return .delete
        } else {
            return .none
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel.remove(for: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        viewModel.reorder(fromRow: fromIndexPath.row, toRow: to.row)
    }
    
    override func tableView(_ tableView: UITableView,
                            shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        guard let cell = tableView.cellForRow(at: indexPath) else { return false }
        let number = Int(cell.textLabel!.text!)
        if number != nil {
            return true
        } else {
            return false
        }
    }

}

