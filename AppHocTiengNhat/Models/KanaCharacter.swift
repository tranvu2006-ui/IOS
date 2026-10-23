//
//  KanaCharacter.swift
//  AppHocTiengNhat
//

import Foundation

public enum KanaType: String, Codable, CaseIterable {
    case hiragana = "Hiragana"
    case katakana = "Katakana"
}

public struct KanaCharacter: Identifiable, Codable {
    public let id: String
    public let character: String       // e.g. "あ" or "ア"
    public let romaji: String          // e.g. "a"
    public let type: KanaType          // .hiragana or .katakana
    public let rowGroup: String        // e.g. "A", "Ka", "Sa"...
    public let exampleWord: String     // e.g. "あめ" (ame)
    public let exampleMeaning: String  // e.g. "Cơn mưa"
    
    public init(
        character: String,
        romaji: String,
        type: KanaType,
        rowGroup: String,
        exampleWord: String,
        exampleMeaning: String
    ) {
        self.id = "\(type.rawValue)_\(romaji)_\(character)"
        self.character = character
        self.romaji = romaji
        self.type = type
        self.rowGroup = rowGroup
        self.exampleWord = exampleWord
        self.exampleMeaning = exampleMeaning
    }
}
