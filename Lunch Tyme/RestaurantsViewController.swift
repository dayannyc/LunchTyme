//
//  RestaurantsViewController.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/11/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var restaurantArr = [Restaurant]()
    var imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // parsing data from jSON url and store them in models
        let jsonURL = URL(string: "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json")
        let myRequest = URLRequest(url: jsonURL!)

        URLSession.shared.dataTask(with: myRequest) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let rData = try decoder.decode(AllRestaurants.self, from: data)
                self.restaurantArr = rData.restaurants

                if (self.restaurantArr.count) > 0 {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }

            } catch let err {
                print("Err", err)
            }
            }.resume()
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return restaurantArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCollectionViewCell
        cell.updateInfo(restaurantList: restaurantArr, index: indexPath[0], cache:imageCache, imageUrl: restaurantArr[indexPath[0]].backgroundImageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func logoutBttn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = storyboard.instantiateViewController(withIdentifier: "initialScreen") as! LoginViewController
        self.present(initialVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass correct information to the view controller that the segue that chosen goes to
        if segue.identifier == "listMapSeg" {
            let seg = segue.destination as! MapViewController
            seg.restaurantArr = restaurantArr
        } else if segue.identifier == "listDetailsSeg" {
            let seg = segue.destination as! DetailsViewController
            if let indexPath = self.collectionView.indexPathsForSelectedItems {
                let index = indexPath[0][0]
                let currRestaurant = restaurantArr[index]
                seg.currRestaurant = currRestaurant
                seg.restaurantArr = restaurantArr
            }
        }
    }
}
