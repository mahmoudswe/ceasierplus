//
//  ViewController.swift
//  josnApp
//
//  Created by use on 11/16/17.
//  Copyright © 2017 use. All rights reserved.
//

import UIKit

class ViewController:UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource {
    var listmhm = Array<clsitem>()
    @IBOutlet weak var collviewlist: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url:String="http://iosmhm-001-site1.ftempurl.com/api/Food/GetFoodItems"
       // let url:String="http://www.ios.somee.com/api/Food/GetFoodItems"
        ReadFromURL(url: url)
        //self.collviewlist.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listmhm.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mhm", for: indexPath) as! CollectionViewCell
        cell.lblfirst.text = listmhm[indexPath.row].name!
        cell.lblsecond.text = listmhm[indexPath.row].image!
        return cell
    }
    
    


    func ReadFromURL(url:String){
        
        DispatchQueue.global().async {
            
            
            do{
                // load json server
                let AppURL=URL(string: url)!
                let data=try Data(contentsOf: AppURL)
                let json=try JSONSerialization.jsonObject(with: data ) as! [String:Any]
                let mhmList = json["mhm"] as! [[String:Any]]
                
                //print(json)
                // access to UI
               DispatchQueue.global().sync {
                for food in mhmList {
                    self.listmhm.append(clsitem (name: food["name"] as! String , image: food["image"] as! String))
                        
                    }
               //   self.laReulst.text="Sunset at:\(astronomy["sunset"]!)"
                    self.collviewlist.reloadData()
                }
               
            }
            catch{
                print("Error")
                
           
       }
            
        }
    }
}



