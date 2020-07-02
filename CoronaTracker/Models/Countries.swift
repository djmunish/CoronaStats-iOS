//
//  Countries.swift
//  CoronaTracker
//
//  Created by Ankur Sehdev on 01/07/20.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import Foundation
import UIKit

struct Country: Hashable {
    var name: String
    var code: String?
    var flagImage: UIImage
}
