//
//  Category.swift
//  Tudu
//
//  Created by Victor Hugo on 3/26/19.
//  Copyright © 2019 Vintage Robot. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
