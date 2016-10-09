//
//  VisitorCount.swift
//  RealmAndCharts-example
//
//  Created by Sami Korpela on 8.10.2016.
//  Copyright © 2016 skipadu. All rights reserved.
//

import Foundation
import RealmSwift

class VisitorCount: Object {
  dynamic var date: Date = Date()
  dynamic var count: Int = Int(0)
  
  func save() {
    do {
      let realm = try Realm()
      try realm.write {
        realm.add(self)
      }
    } catch let error as NSError {
      fatalError(error.localizedDescription)
    }
  }
  
}
