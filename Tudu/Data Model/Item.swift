//
//  Item.swift
//  Tudu
//
//  Created by Victor Hugo on 2/27/19.
//  Copyright © 2019 Vintage Robot. All rights reserved.
//

import Foundation

class Item : Encodable, Decodable //Esto se puede reemplazar por Codable
{
    var title : String = ""
    var done : Bool = false
}
