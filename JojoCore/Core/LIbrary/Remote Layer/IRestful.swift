

//  ioscore
//
//  Created by Moses on 03/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

public enum HTTPBodyType {
    case payload, parameter
}

public protocol IRestful {
    func get(url: String, handle: @escaping ((Response) -> Void))
    func post(url: String, payload: Any, handle: @escaping ((Response) -> Void))
    func put(url: String, payload: Any, handle: @escaping ((Response) -> Void))
    func delete(url: String, handle: @escaping ((Response) -> Void))
}
