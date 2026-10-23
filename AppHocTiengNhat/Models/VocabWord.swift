//
//  VocabWord.swift
//  AppHocTiengNhat
//

import Foundation

public struct VocabTopic: Identifiable, Codable {
    public let id: String
    public let title: String
    public let iconName: String
    public let detail: String
    
    public init(id: String, title: String, iconName: String, detail: String) {
        self.id = id
        self.title = title
        self.iconName = iconName
        self.detail = detail
    }
}

public struct VocabWord: Identifiable, Codable {
    public let id: String
    public let kanji: String?
    public let kana: String
    public let romaji: String
    public let meaningVi: String
    public let topicId: String
    public let exampleJp: String?
    public let exampleVi: String?
    
    public init(
        kanji: String?,
        kana: String,
        romaji: String,
        meaningVi: String,
        topicId: String,
        exampleJp: String? = nil,
        exampleVi: String? = nil
    ) {
        self.id = "vocab_\(topicId)_\(kana)"
        self.kanji = kanji
        self.kana = kana
        self.romaji = romaji
        self.meaningVi = meaningVi
        self.topicId = topicId
        self.exampleJp = exampleJp
        self.exampleVi = exampleVi
    }
    
    public var displayText: String {
        if let kanji = kanji, !kanji.isEmpty {
            return kanji
        }
        return kana
    }
    
    public var speechText: String {
        return kana
    }
}
