//
//  RestaurantPresenter.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/26/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import Foundation
import UIKit

class RestaurantPresenter {
    private var restaurantsView: RestaurantsViewController?
    var listLayout:ListLayout!
    var gridLayout:GridLayout!
    
    init(view: RestaurantsViewController) {
        restaurantsView =  view
        setUpLayouts()
    }
    
    func setUpLayouts() {
        listLayout = ListLayout()
        gridLayout = GridLayout()
        restaurantsView?.collectionView.collectionViewLayout = listLayout
    }
    
    func makePicker() {
        // instantiates UIPickerView
        restaurantsView?.picker.isHidden = true
        restaurantsView?.picker.dataSource = restaurantsView
        restaurantsView?.picker.delegate = restaurantsView
        restaurantsView?.view.addSubview((restaurantsView?.picker)!)
        restaurantsView?.picker.frame = CGRect(x: 0, y: (restaurantsView?.view.frame.maxY)!/15, width: (restaurantsView?.view.frame.width)!, height: (restaurantsView?.view.frame.height)!/6)
        restaurantsView?.picker.backgroundColor = UIColor.white
        restaurantsView?.picker.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        restaurantsView?.picker.layer.borderWidth = 0.70
    }
}
