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
    var imageUrlString: String?
    
    // update cell information
    func updateInfo(restaurantList:[Restaurant], index:Int, cache:NSCache<NSString, UIImage>, imageUrl: String?) {
        imageUrlString = imageUrl
        
        let currRestaurant = restaurantList[index]
        name.text = currRestaurant.name
        category.text = currRestaurant.category
        

        restaurantImg.image = nil

        // image in cache already so just get it
        if cache.object(forKey: currRestaurant.name! as NSString) != nil {
            restaurantImg.image = cache.object(forKey: currRestaurant.name! as NSString)
        } else { // get image from imageURL then store in cache
            let imageUrl:URL = URL(string: currRestaurant.backgroundImageURL!)!
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response
                , error) in

                    if error == nil {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data!)

                            if self.imageUrlString == currRestaurant.backgroundImageURL! {
                            // Update the cell
                                self.restaurantImg.image = image
                            }
                            
                            // Store the image in to our cache
                            cache.setObject(image!, forKey: currRestaurant.name! as NSString)
                        }


                    }
            }).resume()

        }
    }
}
