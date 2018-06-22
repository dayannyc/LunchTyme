//
//  RestaurantCollectionViewCell.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/13/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var name: UILabel!
    
    // update cell information
    func updateInfo(restaurantList:[Restaurant], index:Int, cache:NSCache<NSString, UIImage>) {
        let currRestaurant = restaurantList[index]
        name.text = currRestaurant.name
        category.text = currRestaurant.category
        
        
        if cache.object(forKey: currRestaurant.name! as NSString) != nil {
            restaurantImg.image = cache.object(forKey: currRestaurant.name! as NSString)
        } else {
            let imageUrl:URL = URL(string: currRestaurant.backgroundImageURL!)!
            let request = URLRequest(url: imageUrl)
            let mainQueue = OperationQueue.main
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data!)
                    // Store the image in to our cache
                    cache.setObject(image!, forKey: currRestaurant.name! as NSString)
                    // Update the cell
                    self.restaurantImg.image = image

                }
            })
        }
    }
}
