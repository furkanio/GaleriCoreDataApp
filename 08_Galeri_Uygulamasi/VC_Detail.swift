//
//  VC_Detail.swift
//  08_Galeri_Uygulamasi
//
//  Created by Furkan Yıldız on 26.01.2022.
//

import UIKit

class VC_Detail: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var iv_Resim_Detail: UIImageView!
    @IBOutlet var txt_Baslik_Detail: UITextField!
    @IBOutlet var txt_Konum_Detail: UITextField!
    
    @IBOutlet var txt_Aciklama_Detail: UITextView!
        
    @IBOutlet var btn_Delete_OUT: UIButton!
    
    var updatePhoto : Photo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if updatePhoto != nil {
            txt_Baslik_Detail.text = updatePhoto?.baslik
            txt_Konum_Detail.text = updatePhoto?.konum
            txt_Aciklama_Detail.text = updatePhoto?.aciklama
            
            if updatePhoto?.resim != nil {
                iv_Resim_Detail.image = UIImage(data:updatePhoto!.resim!)
            } else {
                iv_Resim_Detail.image = UIImage(named: "uploadPhoto")
            }
            btn_Delete_OUT.isHidden = false
            
        } else {
            
            iv_Resim_Detail.image = UIImage(named: "uploadPhoto")
            
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
                            iv_Resim_Detail.addGestureRecognizer(tapGR)
                            iv_Resim_Detail.isUserInteractionEnabled = true

        }
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btn_Save_Photo_TUI(_ sender: UIButton) {
        
        if updatePhoto == nil {
            sender.setTitle("Kaydet", for: .normal)
            if let imageData = iv_Resim_Detail.image?.jpegData(compressionQuality: 0.3) {
    //            let r1 = UIImage(data: imageData)
                DAL.saveData(baslik: txt_Baslik_Detail.text!, aciklama: txt_Aciklama_Detail.text!, konum: txt_Konum_Detail.text!, resim: imageData)

            }
        } else {
            
            sender.setTitle("Güncelle", for: .normal)
            updatePhoto?.baslik = txt_Baslik_Detail.text
            updatePhoto?.konum = txt_Konum_Detail.text
            updatePhoto?.aciklama = txt_Aciklama_Detail.text
            
            DAL.update()
        }
       
        
        navigationController?.popViewController(animated: true)

        
    }
    
    @IBAction func btn_Delete_TUI(_ sender: Any) {
        
        if updatePhoto != nil {
            DAL.delete(photo: self.updatePhoto!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
                    if sender.state == .ended {
                        alertFunc()
                    }
            }
    
    
    func accessCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            print("Kamera yok")
        }
        
    }
    
    func accessMediaLibrary(){
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            print("Galeri yok")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let resim = info[.originalImage] as! UIImage
        iv_Resim_Detail.image = resim
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func alertFunc() {
        
        let popUp = UIAlertController(title: "Choose", message: "Camera or Photo Library", preferredStyle: .alert)

        let camera = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.accessCamera()
        })

        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler:  { (action) -> Void in
            self.accessMediaLibrary()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("cancel button tapped")
        }

        popUp.addAction(camera)
        popUp.addAction(photoLibrary)
        popUp.addAction(cancel)
        self.present(popUp, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
