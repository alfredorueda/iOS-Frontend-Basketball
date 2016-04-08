//
//  ViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 07/04/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import Foundation

public class Player {
	public var id : Int?
	public var name : String?
	public var baskets : Int?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Player] {
        var models:[Player] = []
        for item in array
        {
            models.append(Player(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		baskets = dictionary["baskets"] as? Int
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.baskets, forKey: "baskets")

		return dictionary
	}

}