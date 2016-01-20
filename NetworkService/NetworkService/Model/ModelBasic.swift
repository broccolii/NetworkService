//
//  TestModel.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/4.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import Argo
import Runes
import Curry

struct ModelBasic {
    let i: Int
    let s: String
    let b: Bool
    let d: Double
    let f: Double
    let l: Int
    let date: NSDate
}


extension ModelBasic: Decodable {
    static func decode(j: JSON) -> Decoded<ModelBasic> {
        let f = curry(ModelBasic.init)
        return f
            <^> j <| "i"
            <*> j <| "s"
            <*> j <| "b"
            <*> j <| "d"
            <*> j <| "f"
            <*> j <| "l"
            <*> (j <| "date" >>- toNSDate("yyyy-MM-dd HH:mm:ss"))
    }
}

// Wherever you receive JSON data:

//let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
//
//if let j: AnyObject = json {
//    let user: User? = decode(j)
//}
