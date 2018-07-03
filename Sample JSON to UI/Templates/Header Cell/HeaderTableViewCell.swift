//
//  HeaderTableViewCell.swift
//  Sample JSON to UI
//
//  Created by Ryan Bliss on 3/10/18.
//  Copyright © 2018 Ryan Bliss. All rights reserved.
//

import UIKit

class HeaderTableViewCell: GenericTableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var bg: UIView!
    
    override var data: Section? {
        didSet {
            guard let data = data else {
                return
            }
            header = data.header
        }
    }
    var header: Header? {
        didSet {
            bg.backgroundColor = ColorHelper.hexStringToUIColor(hex: header!.theme)
            setupTitle()
            setupValue()
            setupSubValue()
        }
    }
    
    @IBOutlet var title: UILabel!
    @IBOutlet var value: UILabel!
    @IBOutlet var subValue: UILabel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    func setupTitle() {
        let label = header!.labels[0]
        self.title.text = label.text
        self.title.font = UIFont(name: label.attributes.font, size: CGFloat(label.attributes.fontSize))
        self.title.textColor = ColorHelper.hexStringToUIColor(hex: label.attributes.color)
    }
    func setupValue() {
        let label = header!.labels[1]
        self.value.text = label.text
        self.value.font = UIFont(name: label.attributes.font, size: CGFloat(label.attributes.fontSize))
        self.value.textColor = ColorHelper.hexStringToUIColor(hex: label.attributes.color)
    }
    func setupSubValue() {
        let label = header!.labels[2]
        self.subValue.text = label.text
        self.subValue.font = UIFont(name: label.attributes.font, size: CGFloat(label.attributes.fontSize))
        self.subValue.textColor = ColorHelper.hexStringToUIColor(hex: label.attributes.color)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setCollectionViewDataSourceDelegate()
        collectionView.reloadData()
        self.setNeedsLayout()
    }
    
    // MARK: - Collection View
    func setCollectionViewDataSourceDelegate() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 78)
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0.0
            flowLayout.minimumLineSpacing = 0.0
            flowLayout.headerReferenceSize = CGSize(width: 0, height: 0)
            flowLayout.footerReferenceSize = CGSize(width: 0, height: 0)
        }
        
        collectionView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: String(describing: HeaderValueCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "value")
        
        
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data!.header!.values.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "value", for: indexPath) as! HeaderValueCollectionViewCell
        cell.label.text = header!.values[indexPath.row].labels[0].text
        cell.value.text = header!.values[indexPath.row].labels[1].text
        
        cell.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth, .flexibleHeight]
        return cell
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 12.0)
    }
    
    // MARK: Other

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

