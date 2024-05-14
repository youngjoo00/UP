//
//  User.swift
//  UP
//
//  Created by youngjoo on 5/14/24.
//

import Foundation

enum UserRequest {
    struct Join: Encodable {
        let email: String
        let password: String
        let nick: String
        let phoneNum: String
        let birthDay: String
    }

    struct Login: Encodable {
        let email: String
        let password: String
    }

    struct ValidationEmail: Encodable {
        let email: String
    }

    struct EditProfileImage: Encodable {
        let profile: String
    }
    
    struct EditNickname: Encodable {
        let nick: String
    }
    
    struct EditPhone: Encodable {
        let phoneNum: String
    }
    
    struct EditBirthDay: Encodable {
        let birthDay: String
    }
}
