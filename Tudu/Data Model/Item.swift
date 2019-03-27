//
//  Item.swift
//  Tudu
//
//  Created by Victor Hugo on 3/26/19.
//  Copyright © 2019 Vintage Robot. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    //Specify the inverse relationship that links each item back to a parent category.
}
