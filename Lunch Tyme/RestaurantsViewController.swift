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
    var chosenCategory: String?
    var categories = [String]()
    var category = "Everything"
    @IBOutlet weak var resetBttn: UIButton!
    @IBOutlet weak var categoryBttn: UIButton!
    @IBOutlet weak var listBttn: UIButton!
    @IBOutlet weak var gridBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bttnBorder(button:resetBttn)
        bttnBorder(button:categoryBttn)
        bttnBorder(button:listBttn)
        bttnBorder(button:gridBttn)
        
        
        
//        // parsing data from jSON url and store them in models
//        let jsonURL = URL(string: "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json")
//        let myRequest = URLRequest(url: jsonURL!)
//
//        URLSession.shared.dataTask(with: myRequest) { (data, response
//            , error) in
//            guard let data = data else { return }
//            do {
//                let decoder = JSONDecoder()
//                let rData = try decoder.decode(AllRestaurants.self, from: data)
//                self.restaurantArr = rData.restaurants
//
//                for restaurant in rData.restaurants {
//                    if self.categories.contains(restaurant.category!) == false {
//                        self.categories.append(restaurant.category!)
//                    }
//                }
//                if (self.restaurantArr.count) > 0 {
//                    DispatchQueue.main.async {
//                        self.collectionView.reloadData()
//                    }
//                }
//
//            } catch let err {
//                print("Err", err)
//            }
//            }.resume()
        getRestaurants { (dataArray) in
            self.tempRestaurantArr = dataArray
            self.allRestaurantArr = dataArray
            for restaurant in dataArray {
                if self.categories.contains(restaurant.category!) == false {
                    self.categories.append(restaurant.category!)
                }
            }
            print(self.categories.count , " COUNT IS ****")
            
            DispatchQueue.main.async {
                self.makePicker()
            }
        }

        collectionView.dataSource = self
    }
    
    func bttnBorder(button:UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
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
        // instantiates UIPickerView
       // picker.isHidden = true
        picker.dataSource = self
        picker.delegate = self
        self.view.addSubview(picker)
        self.picker.frame = CGRect(x: 0, y: view.frame.maxY/15, width: view.frame.width, height: view.frame.height/6)
        self.picker.backgroundColor = UIColor.white
        self.picker.layer.borderColor = UIColor.black.cgColor
        self.picker.layer.borderWidth = 1
        
        makePickerButton(button:btnConfirm, xVal:view.frame.minX, btnColor:UIColor.blue, btnTitle:"Confirm", btnAc:#selector(confirmBttn))
        makePickerButton(button:btnCancel, xVal:view.frame.width/2, btnColor:UIColor.red, btnTitle: "Cancel", btnAc:#selector(cancelBttn))
    }
    
    
    @IBAction func resetBttn(_ sender: Any) {
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
        category = categories[categoryIndex]
        tempRestaurantArr = allRestaurantArr.filter({$0.category == self.category})
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        print("CATEGORY IS !!!!!! ", category)
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
    
    // creates a button inside of the picker
    func makePickerButton(button:UIButton, xVal:CGFloat, btnColor:UIColor, btnTitle:String, btnAc:Selector) {
        button.isHidden = false
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tempRestaurantArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCollectionViewCell
        cell.updateInfo(restaurantList: tempRestaurantArr, index: indexPath[0], cache:imageCache, imageUrl: tempRestaurantArr[indexPath[0]].backgroundImageURL)
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
            seg.restaurantArr = allRestaurantArr
        } else if segue.identifier == "listDetailsSeg" {
            let seg = segue.destination as! DetailsViewController
            if let indexPath = self.collectionView.indexPathsForSelectedItems {
                let index = indexPath[0][0]
                let currRestaurant = tempRestaurantArr[index]
                seg.currRestaurant = currRestaurant
                seg.restaurantArr = allRestaurantArr
            }
        }
    }
}
