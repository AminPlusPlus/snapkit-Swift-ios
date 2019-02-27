//
//  IssMember.swift
//  test
//
//  Created by Aminjoni Abdullozoda on 2/23/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import Foundation

struct ISSMember: Codable {
    let people: [Person]
    let number: Int
    let message: String
}

struct Person: Codable {
    let name, craft: String
}
