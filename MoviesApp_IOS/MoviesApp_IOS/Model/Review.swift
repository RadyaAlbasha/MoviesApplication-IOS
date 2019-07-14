//
//  Review.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/24/19.
//  Copyright © 2019 iti. All rights reserved.
//

import Foundation
class Review{
    var reviewAuthor: String
    var reviewContent :String
    
    init(author: String,content: String) {
        self.reviewAuthor = author
        self.reviewContent = content
    }
}
