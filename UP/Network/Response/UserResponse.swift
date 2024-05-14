//
//  UserResponse.swift
//  UP
//
//  Created by youngjoo on 5/14/24.
//

import Foundation

protocol ProfileDisplayable: Codable {
    var nick: String { get }
    var profileImage: String { get }
    var followers: [UserResponse.Follow] { get }
    var following: [UserResponse.Follow] { get }
    var posts: [String] { get }
}

enum UserResponse {
    struct Join: Decodable {
        let userID: String
        let email: String
        let nick: String
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case email
            case nick
        }
    }
    
    struct Login: Decodable {
        let userID: String
        let accessToken: String
        let refreshToken: String
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case accessToken
            case refreshToken
        }
        
    }

    struct ValidationEmail: Decodable {
        let message: String
    }
    
    struct MyProfile: Codable, ProfileDisplayable {
        let userID: String
        let email: String
        let nick: String
        let phoneNum: String
        let birthDay: String
        let profileImage: String
        let followers: [Follow]
        let following: [Follow]
        let posts: [String]
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case email
            case nick
            case phoneNum
            case birthDay
            case profileImage
            case followers
            case following
            case posts
        }
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<UserResponse.MyProfile.CodingKeys> = try decoder.container(keyedBy: UserResponse.MyProfile.CodingKeys.self)
            self.userID = try container.decode(String.self, forKey: UserResponse.MyProfile.CodingKeys.userID)
            self.email = try container.decode(String.self, forKey: UserResponse.MyProfile.CodingKeys.email)
            self.nick = try container.decode(String.self, forKey: UserResponse.MyProfile.CodingKeys.nick)
            self.phoneNum = try container.decodeIfPresent(String.self, forKey: UserResponse.MyProfile.CodingKeys.phoneNum) ?? ""
            self.birthDay = try container.decodeIfPresent(String.self, forKey: UserResponse.MyProfile.CodingKeys.birthDay) ?? ""
            self.profileImage = try container.decodeIfPresent(String.self, forKey: UserResponse.MyProfile.CodingKeys.profileImage) ?? ""
            self.followers = try container.decode([Follow].self, forKey: UserResponse.MyProfile.CodingKeys.followers)
            self.following = try container.decode([Follow].self, forKey: UserResponse.MyProfile.CodingKeys.following)
            self.posts = try container.decode([String].self, forKey: UserResponse.MyProfile.CodingKeys.posts)
        }
    }
    
    struct Follow: Codable {
        let userID: String
        let nick: String
        let profileImage: String
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case nick
            case profileImage
        }
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<UserResponse.Follow.CodingKeys> = try decoder.container(keyedBy: UserResponse.Follow.CodingKeys.self)
            self.userID = try container.decode(String.self, forKey: UserResponse.Follow.CodingKeys.userID)
            self.nick = try container.decode(String.self, forKey: UserResponse.Follow.CodingKeys.nick)
            self.profileImage = try container.decodeIfPresent(String.self, forKey: UserResponse.Follow.CodingKeys.profileImage) ?? ""
        }
    }
    
    struct OtherProfile: Codable, ProfileDisplayable {
        let userID: String
        let nick: String
        let profileImage: String
        let followers: [Follow]
        let following: [Follow]
        let posts: [String]
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case nick
            case profileImage
            case followers
            case following
            case posts
        }
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<UserResponse.MyProfile.CodingKeys> = try decoder.container(keyedBy: UserResponse.MyProfile.CodingKeys.self)
            self.userID = try container.decode(String.self, forKey: UserResponse.MyProfile.CodingKeys.userID)
            self.nick = try container.decode(String.self, forKey: UserResponse.MyProfile.CodingKeys.nick)
            self.profileImage = try container.decodeIfPresent(String.self, forKey: UserResponse.MyProfile.CodingKeys.profileImage) ?? ""
            self.followers = try container.decode([Follow].self, forKey: UserResponse.MyProfile.CodingKeys.followers)
            self.following = try container.decode([Follow].self, forKey: UserResponse.MyProfile.CodingKeys.following)
            self.posts = try container.decode([String].self, forKey: UserResponse.MyProfile.CodingKeys.posts)
        }
    }
    
    struct Refresh: Decodable {
        let accessToken: String
    }
}
