//
//  CardCollectionValuesView.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/12/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class CardCollectionValuesView: GenericCardView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override var data: CardRow? {
        didSet {
            guard let data = data else {
                return
            }
            values = data.cardCollectionValues
        }
    }
    var values: [Value]? {
        didSet {
            self.setCollectionViewDataSourceDelegate()
            collectionView.reloadData()
            self.setNeedsLayout()
        }
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Collection View
    func setCollectionViewDataSourceDelegate() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 74)
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0.0
            flowLayout.minimumLineSpacing = 0.0
            flowLayout.headerReferenceSize = CGSize(width: 0, height: 0)
            flowLayout.footerReferenceSize = CGSize(width: 0, height: 0)
        }
        
        collectionView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: String(describing: CardCollectionValueCellCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "value")
        
        
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let values = values else {
            return 0
        }
        return values.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "value", for: indexPath) as! CardCollectionValueCellCollectionViewCell
        guard let values = values else {
            return UICollectionViewCell()
        }
        cell.label.text = values[indexPath.row].labels[0].text
        cell.value.text = values[indexPath.row].labels[1].text
        
        cell.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth, .flexibleHeight]
        return cell
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 12.0)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
