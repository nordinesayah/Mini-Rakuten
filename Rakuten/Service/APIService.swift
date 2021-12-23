//
//  APIService.swift
//  Rakuten
//
//  Created by Nordine Sayah on 14/11/2021.
//

import Foundation
import UIKit

class BackEndService {
    
    var responseApi: ReponseApi?
    var responseDetails: Details?
    var isLoading = false
    
    func searchKeyword() {
        isLoading = true
        guard let url = URL(string: "https://4206121f-64a1-4256-a73d-2ac541b3efe4.mock.pstmn.io/products/search?keyword=samsung") else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                if let reponse = try? JSONDecoder().decode(ReponseApi.self, from: data) {
                    DispatchQueue.main.async {
                        self.responseApi = reponse
                        self.isLoading = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
    
    func loadDetailProduct() {
        guard let url = URL(string: "https://4206121f-64a1-4256-a73d-2ac541b3efe4.mock.pstmn.io/products/detail?id=6035914280") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let Reponse = try? JSONDecoder().decode(Details.self, from: data) {
                    
                    DispatchQueue.main.async {
                        self.responseDetails = Reponse
                        self.isLoading = false
                    }
                } else {
                    self.isLoading = false
                }
            } else {
                self.isLoading = false
            }
        }.resume()
    }
    
}

class ImageLoaderService {

    func loadImage(for urlString: String, completion: @escaping(UIImage)->() ) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let ImageComp = UIImage(data: data) ?? UIImage()
            completion(ImageComp)
        }
        task.resume()
    }
    
}
