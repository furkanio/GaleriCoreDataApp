//
//  CV_Photo.swift
//  08_Galeri_Uygulamasi
//
//  Created by Furkan Yıldız on 26.01.2022.
//

import UIKit

class CV_Photo: UICollectionViewCell {
    
    @IBOutlet var iv_Photo: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(photo:Photo) {
        
        iv_Photo.image = UIImage(data: photo.resim!)
        
    }

}
