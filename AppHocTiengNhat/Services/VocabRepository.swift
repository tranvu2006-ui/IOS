//
//  VocabRepository.swift
//  AppHocTiengNhat
//

import Foundation

public final class VocabRepository {
    public static let shared = VocabRepository()
    
    private init() {}
    
    public let topics: [VocabTopic] = [
        VocabTopic(id: "greeting", title: "Chào hỏi & Giao tiếp", iconName: "bubble.left.and.bubble.right.fill", detail: "Câu cửa miệng và chào hỏi hàng ngày"),
        VocabTopic(id: "family", title: "Gia đình & Bản thân", iconName: "person.2.fill", detail: "Thành viên gia đình và xưng hô"),
        VocabTopic(id: "time", title: "Thời gian & Lịch trình", iconName: "clock.fill", detail: "Giờ giấc, các buổi, ngày tháng"),
        VocabTopic(id: "food", title: "Ẩm thực & Nhà hàng", iconName: "fork.knife", detail: "Món ăn, đồ uống, hương vị"),
        VocabTopic(id: "travel", title: "Đi lại & Phương tiện", iconName: "tram.fill", detail: "Tàu điện, xe bus, hỏi đường")
    ]
    
    public let vocabList: [VocabWord] = [
        // MARK: - Chào hỏi & Giao tiếp
        VocabWord(kanji: nil, kana: "おはようございます", romaji: "ohayou gozaimasu", meaningVi: "Chào buổi sáng (lịch sự)", topicId: "greeting", exampleJp: "先生、おはようございます。", exampleVi: "Chào buổi sáng thầy giáo ạ."),
        VocabWord(kanji: nil, kana: "こんにちは", romaji: "konnichiwa", meaningVi: "Xin chào (buổi trưa/chiều)", topicId: "greeting", exampleJp: "みなさん、こんにちは。", exampleVi: "Xin chào mọi người."),
        VocabWord(kanji: nil, kana: "こんばんは", romaji: "konbanwa", meaningVi: "Chào buổi tối", topicId: "greeting", exampleJp: "こんばんは、お元気ですか。", exampleVi: "Chào buổi tối, bạn khỏe không?"),
        VocabWord(kanji: nil, kana: "ありがとうございます", romaji: "arigatou gozaimasu", meaningVi: "Cảm ơn bạn rất nhiều", topicId: "greeting", exampleJp: "手伝ってくれて、ありがとうございます。", exampleVi: "Cảm ơn bạn đã giúp đỡ tôi."),
        VocabWord(kanji: nil, kana: "すみません", romaji: "sumimasen", meaningVi: "Xin lỗi / Cho tôi hỏi...", topicId: "greeting", exampleJp: "すみません、駅はどこですか。", exampleVi: "Xin lỗi, nhà ga ở đâu ạ?"),
        VocabWord(kanji: nil, kana: "さようなら", romaji: "sayounara", meaningVi: "Tạm biệt", topicId: "greeting", exampleJp: "また明日、さようなら。", exampleVi: "Hẹn gặp lại ngày mai, tạm biệt."),
        
        // MARK: - Gia đình & Bản thân
        VocabWord(kanji: "家族", kana: "かぞく", romaji: "kazoku", meaningVi: "Gia đình", topicId: "family", exampleJp: "家族は四人です。", exampleVi: "Gia đình tôi có 4 người."),
        VocabWord(kanji: "父", kana: "ちち", romaji: "chichi", meaningVi: "Bố (của mình)", topicId: "family", exampleJp: "父は会社員です。", exampleVi: "Bố tôi là nhân viên công ty."),
        VocabWord(kanji: "母", kana: "はは", romaji: "haha", meaningVi: "Mẹ (của mình)", topicId: "family", exampleJp: "母の料理はおいしいです。", exampleVi: "Món mẹ nấu rất ngon."),
        VocabWord(kanji: "兄", kana: "あに", romaji: "ani", meaningVi: "Anh trai (của mình)", topicId: "family", exampleJp: "兄は東京に住んでいます。", exampleVi: "Anh trai tôi đang sống ở Tokyo."),
        VocabWord(kanji: "姉", kana: "あね", romaji: "ane", meaningVi: "Chị gái (của mình)", topicId: "family", exampleJp: "姉は先生です。", exampleVi: "Chị gái tôi là giáo viên."),
        VocabWord(kanji: "友達", kana: "ともだち", romaji: "tomodachi", meaningVi: "Bạn bè", topicId: "family", exampleJp: "友達と映画を見ます。", exampleVi: "Tôi xem phim cùng bạn."),
        
        // MARK: - Thời gian & Lịch trình
        VocabWord(kanji: "今日", kana: "きょう", romaji: "kyou", meaningVi: "Hôm nay", topicId: "time", exampleJp: "今日はいい天気ですね。", exampleVi: "Hôm nay thời tiết đẹp nhỉ."),
        VocabWord(kanji: "明日", kana: "あした", romaji: "ashita", meaningVi: "Ngày mai", topicId: "time", exampleJp: "明日は休みです。", exampleVi: "Ngày mai được nghỉ."),
        VocabWord(kanji: "昨日", kana: "きのう", romaji: "kinou", meaningVi: "Hôm qua", topicId: "time", exampleJp: "昨日は本を読みました。", exampleVi: "Hôm qua tôi đã đọc sách."),
        VocabWord(kanji: "今", kana: "いま", romaji: "ima", meaningVi: "Bây giờ", topicId: "time", exampleJp: "今、何時ですか。", exampleVi: "Bây giờ là mấy giờ?"),
        VocabWord(kanji: "朝", kana: "あさ", romaji: "asa", meaningVi: "Buổi sáng", topicId: "time", exampleJp: "朝六時に起きます。", exampleVi: "Tôi thức dậy lúc 6 giờ sáng."),
        VocabWord(kanji: "夜", kana: "よる", romaji: "yoru", meaningVi: "Buổi tối, đêm", topicId: "time", exampleJp: "夜、日本語を勉強します。", exampleVi: "Buổi tối tôi học tiếng Nhật."),
        
        // MARK: - Ẩm thực & Nhà hàng
        VocabWord(kanji: "ご飯", kana: "ごはん", romaji: "gohan", meaningVi: "Cơm, bữa ăn", topicId: "food", exampleJp: "朝ご飯を食べます。", exampleVi: "Tôi ăn bữa sáng."),
        VocabWord(kanji: "水", kana: "みず", romaji: "mizu", meaningVi: "Nước uống", topicId: "food", exampleJp: "お水をください。", exampleVi: "Làm ơn cho tôi xin nước."),
        VocabWord(kanji: "魚", kana: "さかな", romaji: "sakana", meaningVi: "Cá", topicId: "food", exampleJp: "魚が好きです。", exampleVi: "Tôi thích cá."),
        VocabWord(kanji: "肉", kana: "にく", romaji: "niku", meaningVi: "Thịt", topicId: "food", exampleJp: "牛肉を食べます。", exampleVi: "Tôi ăn thịt bò."),
        VocabWord(kanji: "野菜", kana: "やさい", romaji: "yasai", meaningVi: "Rau củ", topicId: "food", exampleJp: "新鮮な野菜です。", exampleVi: "Rau củ tươi ngon."),
        VocabWord(kanji: "おいしい", kana: "おいしい", romaji: "oishii", meaningVi: "Ngon miệng", topicId: "food", exampleJp: "このラーメンはおいしいです。", exampleVi: "Món mì ramen này rất ngon."),
        
        // MARK: - Đi lại & Phương tiện
        VocabWord(kanji: "電車", kana: "でんしゃ", romaji: "densha", meaningVi: "Tàu điện", topicId: "travel", exampleJp: "電車で学校へ行きます。", exampleVi: "Tôi đi học bằng tàu điện."),
        VocabWord(kanji: "駅", kana: "えき", romaji: "eki", meaningVi: "Nhà ga", topicId: "travel", exampleJp: "駅の前で会いましょう。", exampleVi: "Hãy gặp nhau trước nhà ga nhé."),
        VocabWord(kanji: "車", kana: "くるま", romaji: "kuruma", meaningVi: "Xe hơi", topicId: "travel", exampleJp: "父の車です。", exampleVi: "Đó là xe hơi của bố tôi."),
        VocabWord(kanji: "空港", kana: "くうこう", romaji: "kuukou", meaningVi: "Sân bay", topicId: "travel", exampleJp: "空港へ友達を迎えに行きます。", exampleVi: "Tôi đến sân bay đón bạn."),
        VocabWord(kanji: "自転車", kana: "じてんしゃ", romaji: "jitensha", meaningVi: "Xe đạp", topicId: "travel", exampleJp: "自転車に乗ります。", exampleVi: "Tôi đạp xe đạp.")
    ]
    
    public func getWords(for topicId: String) -> [VocabWord] {
        return vocabList.filter { $0.topicId == topicId }
    }
}
