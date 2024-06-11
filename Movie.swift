//
//  Movie.swift
//  A3_Aditya_Rahman

import Foundation
import UIKit

class Movie {
    let title: String
    let year: Int
    let imdbID: String
    let type: String
    let poster: String
    
    init(title: String, year: Int, imdbID: String, type: String, poster: String){
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
        
    }
}
