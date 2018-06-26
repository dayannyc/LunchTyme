//
//  RestaurantsViewController.swift
//  Lunch Tyme
//
//  Created by Dayanny Caballero on 6/11/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var tempRestaurantArr = [Restaurant]()
    var allRestaurantArr = [Restaurant]()
    var imageCache = NSCache<NSString, UIImage>()
    var picker:UIPickerView = UIPickerView()
    var btnConfirm:UIButton = UIButton()
    var btnCancel:UIButton = UIButton()
    var categories = [String]()
    var restaurantPresenter: RestaurantPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantPresenter = RestaurantPresenter(view: self)

        getRestaurants { (dataArray) in
            self.tempRestaurantArr = dataArray
            self.allRestaurantArr = dataArray
            for restaurant in dataArray {
                if self.categories.contains(restaurant.category!) == false {
                    self.categories.append(restaurant.category!)
                }
            }
            
            DispatchQueue.main.async {
                self.makePicker()
            }
        }

        collectionView.dataSource = self
    }
    
    @IBAction func categoryBttn(_ sender: Any) {
        btnConfirm.isHidden = false
        btnCancel.isHidden = false
        picker.isHidden = false
    }
    
    func getRestaurants(completion: @escaping ([Restaurant])->()) {
        // parsing data from jSON url and store them in models
        let jsonURL = URL(string: "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json")
        let myRequest = URLRequest(url: jsonURL!)
        
        URLSession.shared.dataTask(with: myRequest) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let rData = try decoder.decode(AllRestaurants.self, from: data)
                completion(rData.restaurants)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
    func makePicker() {
        restaurantPresenter?.makePicker()
        makePickerButton(button:btnConfirm, xVal:view.frame.minX, btnColor:UIColor.black, btnTitle:"Confirm", btnAc:#selector(confirmBttn))
        makePickerButton(button:btnCancel, xVal:view.frame.width/2, btnColor:UIColor.red, btnTitle: "Cancel", btnAc:#selector(cancelBttn))
    }
    
    // creates a button inside of the picker
    func makePickerButton(button:UIButton, xVal:CGFloat, btnColor:UIColor, btnTitle:String, btnAc:Selector) {
        button.isHidden = true
        button.frame = CGRect(x: xVal, y: (view.frame.height/6)+45, width: view.frame.width/2, height: 25)
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(btnColor, for: .normal)
        button.setTitle(btnTitle, for: .normal)
        button.addTarget(self, action: btnAc, for: .touchUpInside)
        button.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(button)
    }
    
    @objc func cancelBttn(sender: UIButton!) {
        btnConfirm.isHidden = true
        btnCancel.isHidden = true
        picker.isHidden = true
    }
    
    // action for confirm button in picker
    @objc func confirmBttn(sender: UIButton!) {
        btnConfirm.isHidden = true
        btnCancel.isHidden = true
        picker.isHidden = true
        
        let categoryIndex = picker.selectedRow(inComponent: 0)
        let category = categories[categoryIndex]
        tempRestaurantArr = allRestaurantArr.filter({$0.category == category})
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // Returns number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Returns number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    //Returns the information in the rows
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    @IBAction func resetBttn(_ sender: Any) {
        tempRestaurantArr = allRestaurantArr
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    @IBAction func gridBttn(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout((self.restaurantPresenter?.gridLayout)!, animated: false)
        }
    }
    
    @IBAction func listBttn(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout((self.restaurantPresenter?.listLayout)!, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCollectionViewCell
        cell.updateInfo(restaurantList: tempRestaurantArr, index: indexPath.item, cache:imageCache, imageUrl: tempRestaurantArr[indexPath.item].backgroundImageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempRestaurantArr.count
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
            seg.restaurantArr = allRestaurantArr
        } else if segue.identifier == "listDetailsSeg" {
            let seg = segue.destination as! DetailsViewController
            
            if let indexPath = self.collectionView.indexPathsForSelectedItems {
                let index = indexPath[0][1]
                let currRestaurant = tempRestaurantArr[index]
                seg.currRestaurant = currRestaurant
                seg.restaurantArr = allRestaurantArr
            }
        }
    }
}
