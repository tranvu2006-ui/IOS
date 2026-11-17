//
//  PictureQuizRepository.swift
//  AppHocTiengNhat
//

import Foundation

public final class PictureQuizRepository {
    public static let shared = PictureQuizRepository()
    
    private init() {}
    
    public let allItems: [PictureQuizItem] = [
        // MARK: - Động vật (Đặc biệt: Con chó 🐶, Con mèo 🐱)
        PictureQuizItem(emoji: "🐶", sfSymbolName: "dog.fill", vietnameseMeaning: "Con chó", japaneseWord: "いぬ (犬)", romaji: "inu", category: "Động vật"),
        PictureQuizItem(emoji: "🐱", sfSymbolName: "cat.fill", vietnameseMeaning: "Con mèo", japaneseWord: "ねこ (猫)", romaji: "neko", category: "Động vật"),
        PictureQuizItem(emoji: "🐟", sfSymbolName: "fish.fill", vietnameseMeaning: "Con cá", japaneseWord: "さかな (魚)", romaji: "sakana", category: "Động vật"),
        PictureQuizItem(emoji: "🐦", sfSymbolName: "bird.fill", vietnameseMeaning: "Con chim", japaneseWord: "とり (鳥)", romaji: "tori", category: "Động vật"),
        PictureQuizItem(emoji: "🐴", sfSymbolName: "hare.fill", vietnameseMeaning: "Con ngựa", japaneseWord: "うま (馬)", romaji: "uma", category: "Động vật"),
        PictureQuizItem(emoji: "🐮", sfSymbolName: "tortoise.fill", vietnameseMeaning: "Con bò", japaneseWord: "うし (牛)", romaji: "ushi", category: "Động vật"),
        PictureQuizItem(emoji: "🐷", sfSymbolName: "pawprint.fill", vietnameseMeaning: "Con heo / lợn", japaneseWord: "ぶた (豚)", romaji: "buta", category: "Động vật"),
        PictureQuizItem(emoji: "🐘", sfSymbolName: "pawprint.fill", vietnameseMeaning: "Con voi", japaneseWord: "ぞう (象)", romaji: "zou", category: "Động vật"),
        
        // MARK: - Hoa quả & Đồ ăn
        PictureQuizItem(emoji: "🍎", sfSymbolName: "applelogo", vietnameseMeaning: "Quả táo", japaneseWord: "りんご", romaji: "ringo", category: "Hoa quả"),
        PictureQuizItem(emoji: "🍌", sfSymbolName: "leaf.fill", vietnameseMeaning: "Quả chuối", japaneseWord: "バナナ", romaji: "banana", category: "Hoa quả"),
        PictureQuizItem(emoji: "🍉", sfSymbolName: "drop.fill", vietnameseMeaning: "Dưa hấu", japaneseWord: "すいか", romaji: "suika", category: "Hoa quả"),
        PictureQuizItem(emoji: "🍚", sfSymbolName: "cup.and.saucer.fill", vietnameseMeaning: "Cơm / Bữa ăn", japaneseWord: "ごはん (ご飯)", romaji: "gohan", category: "Ẩm thực"),
        PictureQuizItem(emoji: "🍜", sfSymbolName: "fork.knife", vietnameseMeaning: "Mì ramen", japaneseWord: "ラーメン", romaji: "raamen", category: "Ẩm thực"),
        PictureQuizItem(emoji: "🍣", sfSymbolName: "fork.knife", vietnameseMeaning: "Món sushi", japaneseWord: "すし (寿司)", romaji: "sushi", category: "Ẩm thực"),
        PictureQuizItem(emoji: "🍵", sfSymbolName: "cup.and.saucer.fill", vietnameseMeaning: "Trà xanh", japaneseWord: "おちゃ (お茶)", romaji: "ocha", category: "Đồ uống"),
        PictureQuizItem(emoji: "💧", sfSymbolName: "drop.fill", vietnameseMeaning: "Nước uống", japaneseWord: "みず (水)", romaji: "mizu", category: "Đồ uống"),
        PictureQuizItem(emoji: "🍞", sfSymbolName: "takeoutbag.and.cup.and.straw.fill", vietnameseMeaning: "Bánh mì", japaneseWord: "パン", romaji: "pan", category: "Ẩm thực"),
        
        // MARK: - Phương tiện & Đồ vật
        PictureQuizItem(emoji: "🚗", sfSymbolName: "car.fill", vietnameseMeaning: "Xe hơi / Ô tô", japaneseWord: "くるま (車)", romaji: "kuruma", category: "Phương tiện"),
        PictureQuizItem(emoji: "🚆", sfSymbolName: "tram.fill", vietnameseMeaning: "Tàu điện", japaneseWord: "でんしゃ (電車)", romaji: "densha", category: "Phương tiện"),
        PictureQuizItem(emoji: "🚲", sfSymbolName: "bicycle", vietnameseMeaning: "Xe đạp", japaneseWord: "じてんしゃ (自転車)", romaji: "jitensha", category: "Phương tiện"),
        PictureQuizItem(emoji: "✈️", sfSymbolName: "airplane", vietnameseMeaning: "Máy bay", japaneseWord: "ひこうき (飛行機)", romaji: "hikouki", category: "Phương tiện"),
        PictureQuizItem(emoji: "📖", sfSymbolName: "book.fill", vietnameseMeaning: "Quyển sách", japaneseWord: "ほん (本)", romaji: "hon", category: "Đồ vật"),
        PictureQuizItem(emoji: "☔️", sfSymbolName: "umbrella.fill", vietnameseMeaning: "Cái ô / Dù", japaneseWord: "かさ (傘)", romaji: "kasa", category: "Đồ vật"),
        PictureQuizItem(emoji: "📱", sfSymbolName: "iphone", vietnameseMeaning: "Điện thoại", japaneseWord: "でんわ (電話)", romaji: "denwa", category: "Đồ vật"),
        PictureQuizItem(emoji: "🌸", sfSymbolName: "flower.fill", vietnameseMeaning: "Hoa anh đào", japaneseWord: "さくら (桜)", romaji: "sakura", category: "Thiên nhiên"),
        PictureQuizItem(emoji: "☀️", sfSymbolName: "sun.max.fill", vietnameseMeaning: "Mặt trời", japaneseWord: "たいよう (太陽)", romaji: "taiyou", category: "Thiên nhiên"),
        PictureQuizItem(emoji: "🌙", sfSymbolName: "moon.fill", vietnameseMeaning: "Mặt trăng", japaneseWord: "つき (月)", romaji: "tsuki", category: "Thiên nhiên")
    ]
}
