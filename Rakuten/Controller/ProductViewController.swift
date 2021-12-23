//
//  ProductViewController.swift
//  Rakuten
//
//  Created by Nordine Sayah on 11/11/2021.
//

import UIKit
import Network

class ProductViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewController: UITableView!
    
    var Backend = BackEndService()
    var image: UIImage = UIImage()
    var ImageService = ImageLoaderService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewController.isHidden = true
        Backend.searchKeyword()
        self.tableViewController.reloadData()
    }
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            // Custom text field
            let image = UIImage(named: "searchIcon")!.withRenderingMode(.alwaysTemplate)
            textField.tintColor = UIColor.lightGray
            textField.setIcon(image)
            textField.layer.cornerRadius = 10.0
            textField.clipsToBounds = true
            textField.clearButtonMode = .whileEditing
            textField.returnKeyType = UIReturnKeyType.search
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performAction()
        return true
    }
    
    private func performAction() {
        // action button search
        tableViewController.isHidden = false
        self.view.endEditing(true)
        Backend.searchKeyword()
        self.tableViewController.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Backend.responseApi?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct") as! ProductTableViewCell
        ImageService.loadImage(for: Backend.responseApi!.products[indexPath.row].imagesUrls.first ?? "") { image in
            DispatchQueue.main.async {
                self.image = image
                cell.productImage.image = self.image
            }
        }
        cell.nameProductLabel.text = Backend.responseApi?.products[indexPath.row].headline
        cell.rateLabel.text = String("Rate \(Int(Backend.responseApi!.products[indexPath.row].reviewsAverageNote))/5")
        cell.reviewLabel.text = String("\(Backend.responseApi!.products[indexPath.row].nbReviews) Reviews")
        if (Backend.responseApi!.products[indexPath.row].newBestPrice != 0) {
            cell.newPriceLabel.text = String("New from \(Int(Backend.responseApi!.products[indexPath.row].newBestPrice)) €")
        } else {
            cell.newPriceLabel.text = ""
        }
        if (Backend.responseApi!.products[indexPath.row].usedBestPrice != 0) {
            cell.occasionPriceLabel.text = String("Used product from \(Int(Backend.responseApi!.products[indexPath.row].usedBestPrice)) €")
        } else {
            cell.occasionPriceLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueDetailsProduct", sender: self)
    }
    
}

// Add icon on TextField
extension UITextField {
    
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
}
