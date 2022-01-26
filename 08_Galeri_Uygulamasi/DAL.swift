//
//  DAL.swift
//  08_Galeri_Uygulamasi
//
//  Created by Furkan Yıldız on 26.01.2022.
//

import Foundation
import CoreData
import UIKit

class DAL {
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func saveData(baslik:String, aciklama:String, konum:String, resim:Data) {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in: context)
        
        let photo = NSManagedObject(entity: entity!, insertInto: context)
        
        photo.setValue(baslik, forKey: "baslik")
        photo.setValue(aciklama, forKey: "aciklama")
        photo.setValue(konum, forKey: "konum")
        photo.setValue(resim, forKey: "resim")
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    static func getAllData() -> [Photo]? {
        
        let fetchRequest : NSFetchRequest<Photo> = Photo.fetchRequest()
        
        do {
            return try getContext().fetch(fetchRequest)
        } catch {
            
        }
        return nil
    }
    
    static func update() {
        
        try? getContext().save()
        
    }
    
    
    static func delete(photo:Photo) {
        
        getContext().delete(photo)
        try? getContext().save()
    }
    
}
