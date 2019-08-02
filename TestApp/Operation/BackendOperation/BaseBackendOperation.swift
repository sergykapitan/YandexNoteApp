//
//  BaseBackendOperation.swift
//  TestApp
//
//  Created by Sergey Koriukin on 02/08/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import Foundation

enum NetworkError {
    case unreachable
}

class BaseBackendOperation: AsyncOperation {
    override init() {
        super.init()
    }
}
