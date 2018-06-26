//
//  ListLayout.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/26/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import UIKit

class ListLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setup()
    }
    
    func setup() {
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var itemSize: CGSize {
        get {
            if let collectionView = collectionView {
                return CGSize(width: collectionView.frame.width, height:180)
            }
            
            return CGSize(width: 100, height:100)
        }
        set {
            super.itemSize = newValue
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return proposedContentOffset
    }
}
