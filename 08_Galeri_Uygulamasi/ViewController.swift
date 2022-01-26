//
//  ViewController.swift
//  08_Galeri_Uygulamasi
//
//  Created by Furkan Yıldız on 26.01.2022.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var model = [Photo]()

    
    @IBOutlet var cvList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cvList.register(UINib(nibName: "CV_Photo", bundle: nil), forCellWithReuseIdentifier: "CV_Photo")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        DAL.getContext().rollback()
        model = DAL.getAllData() ?? []
        cvList.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        
        viewFunc()
        
    }
    
    
    func viewFunc() {
        let layout = cvList.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        
        layout.minimumInteritemSpacing = 1


        if self.view.frame.size.width < self.view.frame.size.height {
             // Portrait
                    let spacing = self.view.frame.size.width - 20
                    let width = spacing / 3
                    let height = width * 2/3
            layout.itemSize = CGSize(width: width, height: height)
        }
        else {
             // Landscape
                    let spacing = self.view.frame.size.width - 5
                    let width = spacing / 5
                    let height = width * 2/3
            layout.itemSize = CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let p = model[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CV_Photo", for: indexPath) as! CV_Photo
        cell.bindData(photo: p)
//        cell.iv_Photo.image = UIImage(data:p.resim!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgUpdate", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgUpdate" {
            let photoDetail = segue.destination as! VC_Detail
            photoDetail.updatePhoto = model[sender as! Int]
        }
    }
    

    
    
    
    


}

