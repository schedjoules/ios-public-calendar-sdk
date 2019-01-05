//
//  SettingsObject.swift
//  iOS-SDK
//
//  Created by Alberto Huerdo on 12/17/18.
//  Copyright © 2018 SchedJoules. All rights reserved.
//

import Foundation
import SchedJoulesApiClient

struct SettingsObject: CodedOption {
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
        case path = "path"
    }
    
    
    var name: String
    var code: String
    var icon: URL?
    
    var path: String?
    
    init(name: String, code: String, iconURL: URL?) {
        self.name = name
        self.code = code
        self.icon = iconURL
    }
    
    init(object: CodedOption, type: SettingsManager.SettingsType) {
        self.name = object.name
        self.code = object.code
        self.icon = object.icon
        
        switch type {
        case .language:
            path = UserDefaultsKeys.Settings.language
        case .country:
            path = UserDefaultsKeys.Settings.country
        }
    }
    
    init() {
        self.name = "Default"
        self.code = "Default"
    }
}


//Management
extension SettingsObject {
    
    func save() {
        SettingsManager.save(self)
    }
    
}


extension SettingsObject: Codable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code, forKey: .code)
        try container.encode(name, forKey: .name)
        try container.encode(path, forKey: .path)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try values.decode(String.self, forKey: .code)
        self.name = try values.decode(String.self, forKey: .name)
        self.path = try values.decode(String.self, forKey: .path)
    }
}
