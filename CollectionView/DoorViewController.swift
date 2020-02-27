//
//  DoorViewController.swift
//  CollectionView
//
//  Created by Admin on 27/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DoorViewController: UIViewController {

    @IBOutlet weak var doorImagesScrollView: UIScrollView!
    @IBOutlet weak var doorImagesPageControll: UIPageControl!
    @IBOutlet weak var doorDescription: UITextView!
    @IBOutlet weak var doorPrice: UILabel!
    @IBOutlet weak var doorBuyButton: UIButton!
    
    var door: Door? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = door?.title
        
        let size = door?.imageUrls.count
        
        for i in 0..<size! {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            do {
                image.image = try UIImage(data: Data(contentsOf: URL(string: door!.imageUrls[i] as! String)!))
            }
            catch {
                print("Error to create UIImage")
            }
            let xPos = CGFloat(i)*self.view.bounds.size.width
            image.frame = CGRect(x: xPos, y: 0, width: view.frame.size.width, height: doorImagesScrollView.frame.size.height)
            doorImagesScrollView.contentSize.width = view.frame.size.width*CGFloat(i+1)
            doorImagesScrollView.addSubview(image)
            
        }
        
        doorImagesScrollView.delegate = self
        
        doorImagesPageControll.numberOfPages = (door?.imageUrls.count)!
        
        doorDescription.text = door?.description
        doorPrice.text = "от \(door!.price) руб."
        
        configureButton()
        
        
    }
    
    func configureButton() {
        doorBuyButton.layer.cornerRadius = 20
    }
    
}

extension DoorViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        
        self.doorImagesPageControll.currentPage = Int(page)
    }
}
