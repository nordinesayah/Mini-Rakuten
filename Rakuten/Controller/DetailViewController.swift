//
//  DetailViewController.swift
//  Rakuten
//
//  Created by Nordine Sayah on 11/11/2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var descriptionProductLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellerRateLabel: UILabel!
    
    var Backend = BackEndService()
    var image: UIImage = UIImage()
    var ImageService = ImageLoaderService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Backend.loadDetailProduct()
        productDetails()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Backend.loadDetailProduct()
        productDetails()
    }
    
    private func productDetails() {
        DispatchQueue.main.async {
            self.ImageService.loadImage(for: String(self.Backend.responseDetails?.images.first?.imagesUrls.entry.first?.url ?? "")) { image in
                DispatchQueue.main.async {
                    self.image = image
                    self.productImage.image = self.image
                }
            }
            self.productNameLabel.text = self.Backend.responseDetails?.headline
            self.descriptionProductLabel.text = self.Backend.responseDetails?.sellerComment
            self.priceLabel.text = String("\(self.Backend.responseDetails?.newBestPrice ?? 0) €")
            self.sellerNameLabel.text = self.Backend.responseDetails?.seller.login
            self.sellerRateLabel.text = String("\(self.Backend.responseDetails?.globalRating.score ?? 0)/5")
        }
    }
    
}
