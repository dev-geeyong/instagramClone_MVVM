//
//  Constaants.swift
//  instagramClone
//
//  Created by dev.geeyong on 2021/02/09.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")