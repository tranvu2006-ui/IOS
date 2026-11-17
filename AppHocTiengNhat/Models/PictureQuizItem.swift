//
//  PictureQuizItem.swift
//  AppHocTiengNhat
//

import Foundation

public struct PictureQuizItem: Identifiable {
    public let id: String
    public let emoji: String              // Biểu tượng hình ảnh lớn (🐶, 🐱, 🍎...)
    public let sfSymbolName: String       // SF Symbol dự phòng (nếu cần)
    public let vietnameseMeaning: String  // Ví dụ: "Con chó"
    public let japaneseWord: String       // Ví dụ: "いぬ" hoặc "犬"
    public let romaji: String             // Ví dụ: "inu"
    public let category: String           // "Động vật", "Hoa quả", "Giao thông"...
    
    public init(
        emoji: String,
        sfSymbolName: String,
        vietnameseMeaning: String,
        japaneseWord: String,
        romaji: String,
        category: String
    ) {
        self.id = "pic_\(romaji)"
        self.emoji = emoji
        self.sfSymbolName = sfSymbolName
        self.vietnameseMeaning = vietnameseMeaning
        self.japaneseWord = japaneseWord
        self.romaji = romaji
        self.category = category
    }
}
