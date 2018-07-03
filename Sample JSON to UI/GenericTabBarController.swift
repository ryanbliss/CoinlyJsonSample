//
//  GenericTabBarController.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/29/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class GenericTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
    // UITabBarControllerDelegate
    var currentIndex = 0
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            self.selectedIndex = self.currentIndex
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "firstVC") as! FirstViewController
            vc.set(with: "addRipplePurchase")
            let navigationController = UINavigationController(rootViewController: vc)
            
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        } else if tabBarIndex == 2 {
            self.selectedIndex = self.currentIndex
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "jsonEdit") as! EditJsonViewController
            let navigationController = UINavigationController(rootViewController: vc)
            
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        } else {
            self.currentIndex = tabBarIndex
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
