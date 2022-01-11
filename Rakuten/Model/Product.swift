//
//  Product.swift
//  Rakuten
//
//  Created by Nordine Sayah on 13/11/2021.
//

import Foundation

struct ReponseApi: Codable {
    var totalResultProductsCount: Int
    var resultProductsCount: Int
    var pageNumber: Int
    var title: String
    var maxProductsPerPage: Int
    var maxPageNumber: Int
    var products: [Products]
}

struct Products: Codable {
    var id: Int
    var newBestPrice: Double
    var usedBestPrice: Double
    var headline: String
    var reviewsAverageNote: Double
    var nbReviews: Int
    var categoryRef: Int
    var imagesUrls: [String]
    var buybox: Buybox
}

struct Buybox: Codable {
    var salePrice: Double?
    var advertType: String
    var advertQuality: String
    var saleCrossedPrice: Double?
    var salePercentDiscount: Double?
}

struct Details: Codable {
    var productId: Int
    var salePrice: Double
    var newBestPrice: Double?
    var usedBestPrice: Double?
    var seller: Seller
    var quality: String
    var type: String
    var sellerComment: String
    var headline: String
    var categories: [String]
    var globalRating: GlobalRating
    var description: String
    var images: [ImageApi]
}

struct ImageApi: Codable {
    var id: Int
    var imagesUrls: ImagesUrls
}

struct ImagesUrls: Codable {
    var entry: [Imageurl]
}

struct Imageurl: Codable {
    var size: String
    var url: String
}

struct GlobalRating: Codable {
    var score: Double
    var nbReviews: Int
}

struct Seller: Codable {
    var id: Int
    var login: String
}
