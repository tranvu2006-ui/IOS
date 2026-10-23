//
//  KanaRepository.swift
//  AppHocTiengNhat
//

import Foundation

public final class KanaRepository {
    public static let shared = KanaRepository()
    
    private init() {}
    
    // MARK: - 46 Ký tự Hiragana cơ bản
    public let hiraganaList: [KanaCharacter] = [
        // Hàng A
        KanaCharacter(character: "あ", romaji: "a", type: .hiragana, rowGroup: "A", exampleWord: "あめ (ame)", exampleMeaning: "Cơn mưa / Kẹo"),
        KanaCharacter(character: "い", romaji: "i", type: .hiragana, rowGroup: "A", exampleWord: "いぬ (inu)", exampleMeaning: "Con chó"),
        KanaCharacter(character: "う", romaji: "u", type: .hiragana, rowGroup: "A", exampleWord: "うみ (umi)", exampleMeaning: "Biển"),
        KanaCharacter(character: "え", romaji: "e", type: .hiragana, rowGroup: "A", exampleWord: "えき (eki)", exampleMeaning: "Nhà ga"),
        KanaCharacter(character: "お", romaji: "o", type: .hiragana, rowGroup: "A", exampleWord: "おちゃ (ocha)", exampleMeaning: "Trà xanh"),
        
        // Hàng Ka
        KanaCharacter(character: "か", romaji: "ka", type: .hiragana, rowGroup: "Ka", exampleWord: "かさ (kasa)", exampleMeaning: "Cái ô/dù"),
        KanaCharacter(character: "き", romaji: "ki", type: .hiragana, rowGroup: "Ka", exampleWord: "き (ki)", exampleMeaning: "Cây cối"),
        KanaCharacter(character: "く", romaji: "ku", type: .hiragana, rowGroup: "Ka", exampleWord: "くるま (kuruma)", exampleMeaning: "Xe hơi"),
        KanaCharacter(character: "け", romaji: "ke", type: .hiragana, rowGroup: "Ka", exampleWord: "けさ (kesa)", exampleMeaning: "Sáng nay"),
        KanaCharacter(character: "こ", romaji: "ko", type: .hiragana, rowGroup: "Ka", exampleWord: "こども (kodomo)", exampleMeaning: "Trẻ em"),
        
        // Hàng Sa
        KanaCharacter(character: "さ", romaji: "sa", type: .hiragana, rowGroup: "Sa", exampleWord: "さくら (sakura)", exampleMeaning: "Hoa anh đào"),
        KanaCharacter(character: "し", romaji: "shi", type: .hiragana, rowGroup: "Sa", exampleWord: "しろ (shiro)", exampleMeaning: "Màu trắng"),
        KanaCharacter(character: "す", romaji: "su", type: .hiragana, rowGroup: "Sa", exampleWord: "すし (sushi)", exampleMeaning: "Món sushi"),
        KanaCharacter(character: "せ", romaji: "se", type: .hiragana, rowGroup: "Sa", exampleWord: "せんせい (sensei)", exampleMeaning: "Thầy/cô giáo"),
        KanaCharacter(character: "そ", romaji: "so", type: .hiragana, rowGroup: "Sa", exampleWord: "そら (sora)", exampleMeaning: "Bầu trời"),
        
        // Hàng Ta
        KanaCharacter(character: "た", romaji: "ta", type: .hiragana, rowGroup: "Ta", exampleWord: "たまご (tamago)", exampleMeaning: "Quả trứng"),
        KanaCharacter(character: "ち", romaji: "chi", type: .hiragana, rowGroup: "Ta", exampleWord: "ちず (chizu)", exampleMeaning: "Bản đồ"),
        KanaCharacter(character: "つ", romaji: "tsu", type: .hiragana, rowGroup: "Ta", exampleWord: "つき (tsuki)", exampleMeaning: "Mặt trăng"),
        KanaCharacter(character: "て", romaji: "te", type: .hiragana, rowGroup: "Ta", exampleWord: "て (te)", exampleMeaning: "Bàn tay"),
        KanaCharacter(character: "と", romaji: "to", type: .hiragana, rowGroup: "Ta", exampleWord: "ともだち (tomodachi)", exampleMeaning: "Bạn bè"),
        
        // Hàng Na
        KanaCharacter(character: "な", romaji: "na", type: .hiragana, rowGroup: "Na", exampleWord: "なつ (natsu)", exampleMeaning: "Mùa hè"),
        KanaCharacter(character: "に", romaji: "ni", type: .hiragana, rowGroup: "Na", exampleWord: "にほん (nihon)", exampleMeaning: "Nước Nhật"),
        KanaCharacter(character: "ぬ", romaji: "nu", type: .hiragana, rowGroup: "Na", exampleWord: "ぬいぐるみ (nuigurumi)", exampleMeaning: "Thú nhồi bông"),
        KanaCharacter(character: "ね", romaji: "ne", type: .hiragana, rowGroup: "Na", exampleWord: "ねこ (neko)", exampleMeaning: "Con mèo"),
        KanaCharacter(character: "の", romaji: "no", type: .hiragana, rowGroup: "Na", exampleWord: "のりもの (norimono)", exampleMeaning: "Phương tiện"),
        
        // Hàng Ha
        KanaCharacter(character: "は", romaji: "ha", type: .hiragana, rowGroup: "Ha", exampleWord: "はな (hana)", exampleMeaning: "Bông hoa / Cái mũi"),
        KanaCharacter(character: "ひ", romaji: "hi", type: .hiragana, rowGroup: "Ha", exampleWord: "ひと (hito)", exampleMeaning: "Con người"),
        KanaCharacter(character: "ふ", romaji: "fu", type: .hiragana, rowGroup: "Ha", exampleWord: "ふね (fune)", exampleMeaning: "Thuyền, tàu"),
        KanaCharacter(character: "へ", romaji: "he", type: .hiragana, rowGroup: "Ha", exampleWord: "へや (heya)", exampleMeaning: "Căn phòng"),
        KanaCharacter(character: "ほ", romaji: "ho", type: .hiragana, rowGroup: "Ha", exampleWord: "ほん (hon)", exampleMeaning: "Quyển sách"),
        
        // Hàng Ma
        KanaCharacter(character: "ま", romaji: "ma", type: .hiragana, rowGroup: "Ma", exampleWord: "まち (machi)", exampleMeaning: "Thành phố, phố"),
        KanaCharacter(character: "み", romaji: "mi", type: .hiragana, rowGroup: "Ma", exampleWord: "みず (mizu)", exampleMeaning: "Nước uống"),
        KanaCharacter(character: "む", romaji: "mu", type: .hiragana, rowGroup: "Ma", exampleWord: "むし (mushi)", exampleMeaning: "Côn trùng"),
        KanaCharacter(character: "め", romaji: "me", type: .hiragana, rowGroup: "Ma", exampleWord: "め (me)", exampleMeaning: "Mắt"),
        KanaCharacter(character: "も", romaji: "mo", type: .hiragana, rowGroup: "Ma", exampleWord: "もり (mori)", exampleMeaning: "Khu rừng"),
        
        // Hàng Ya
        KanaCharacter(character: "や", romaji: "ya", type: .hiragana, rowGroup: "Ya", exampleWord: "やま (yama)", exampleMeaning: "Ngọn núi"),
        KanaCharacter(character: "ゆ", romaji: "yu", type: .hiragana, rowGroup: "Ya", exampleWord: "ゆき (yuki)", exampleMeaning: "Tuyết"),
        KanaCharacter(character: "よ", romaji: "yo", type: .hiragana, rowGroup: "Ya", exampleWord: "よる (yoru)", exampleMeaning: "Buổi tối"),
        
        // Hàng Ra
        KanaCharacter(character: "ら", romaji: "ra", type: .hiragana, rowGroup: "Ra", exampleWord: "らいしゅう (raishuu)", exampleMeaning: "Tuần sau"),
        KanaCharacter(character: "り", romaji: "ri", type: .hiragana, rowGroup: "Ra", exampleWord: "りんご (ringo)", exampleMeaning: "Quả táo"),
        KanaCharacter(character: "る", romaji: "ru", type: .hiragana, rowGroup: "Ra", exampleWord: "るす (rusu)", exampleMeaning: "Vắng nhà"),
        KanaCharacter(character: "れ", romaji: "re", type: .hiragana, rowGroup: "Ra", exampleWord: "れきし (rekishi)", exampleMeaning: "Lịch sử"),
        KanaCharacter(character: "ろ", romaji: "ro", type: .hiragana, rowGroup: "Ra", exampleWord: "ろうそく (rousoku)", exampleMeaning: "Cây nến"),
        
        // Hàng Wa - Wo - N
        KanaCharacter(character: "わ", romaji: "wa", type: .hiragana, rowGroup: "Wa", exampleWord: "わたし (watashi)", exampleMeaning: "Tôi"),
        KanaCharacter(character: "を", romaji: "wo/o", type: .hiragana, rowGroup: "Wa", exampleWord: "ほん を よむ", exampleMeaning: "Đọc sách (trợ từ)"),
        KanaCharacter(character: "ん", romaji: "n", type: .hiragana, rowGroup: "Wa", exampleWord: "にほん (nihon)", exampleMeaning: "Nước Nhật (âm mũi)")
    ]
    
    // MARK: - 46 Ký tự Katakana cơ bản
    public let katakanaList: [KanaCharacter] = [
        // Hàng A
        KanaCharacter(character: "ア", romaji: "a", type: .katakana, rowGroup: "A", exampleWord: "アイス (aisu)", exampleMeaning: "Kem (Ice-cream)"),
        KanaCharacter(character: "イ", romaji: "i", type: .katakana, rowGroup: "A", exampleWord: "インク (inku)", exampleMeaning: "Mực in"),
        KanaCharacter(character: "ウ", romaji: "u", type: .katakana, rowGroup: "A", exampleWord: "ウェブ (webu)", exampleMeaning: "Trang web"),
        KanaCharacter(character: "エ", romaji: "e", type: .katakana, rowGroup: "A", exampleWord: "エレベーター (erebeetaa)", exampleMeaning: "Thang máy"),
        KanaCharacter(character: "オ", romaji: "o", type: .katakana, rowGroup: "A", exampleWord: "オレンジ (orenji)", exampleMeaning: "Quả cam"),
        
        // Hàng Ka
        KanaCharacter(character: "カ", romaji: "ka", type: .katakana, rowGroup: "Ka", exampleWord: "カメラ (kamera)", exampleMeaning: "Máy ảnh"),
        KanaCharacter(character: "キ", romaji: "ki", type: .katakana, rowGroup: "Ka", exampleWord: "キッチン (kicchin)", exampleMeaning: "Nhà bếp"),
        KanaCharacter(character: "ク", romaji: "ku", type: .katakana, rowGroup: "Ka", exampleWord: "クラス (kurasu)", exampleMeaning: "Lớp học"),
        KanaCharacter(character: "ケ", romaji: "ke", type: .katakana, rowGroup: "Ka", exampleWord: "ケーキ (keeki)", exampleMeaning: "Bánh kem"),
        KanaCharacter(character: "コ", romaji: "ko", type: .katakana, rowGroup: "Ka", exampleWord: "コーヒー (koohii)", exampleMeaning: "Cà phê"),
        
        // Hàng Sa
        KanaCharacter(character: "サ", romaji: "sa", type: .katakana, rowGroup: "Sa", exampleWord: "サラダ (sarada)", exampleMeaning: "Món salad"),
        KanaCharacter(character: "シ", romaji: "shi", type: .katakana, rowGroup: "Sa", exampleWord: "シャツ (shatsu)", exampleMeaning: "Áo sơ mi"),
        KanaCharacter(character: "ス", romaji: "su", type: .katakana, rowGroup: "Sa", exampleWord: "スポーツ (supootsu)", exampleMeaning: "Thể thao"),
        KanaCharacter(character: "セ", romaji: "se", type: .katakana, rowGroup: "Sa", exampleWord: "セーター (seetaa)", exampleMeaning: "Áo len"),
        KanaCharacter(character: "ソ", romaji: "so", type: .katakana, rowGroup: "Sa", exampleWord: "ソファ (sofa)", exampleMeaning: "Ghế sofa"),
        
        // Hàng Ta
        KanaCharacter(character: "タ", romaji: "ta", type: .katakana, rowGroup: "Ta", exampleWord: "タクシー (takushii)", exampleMeaning: "Xe taxi"),
        KanaCharacter(character: "チ", romaji: "chi", type: .katakana, rowGroup: "Ta", exampleWord: "チーズ (chiizu)", exampleMeaning: "Phô mai"),
        KanaCharacter(character: "ツ", romaji: "tsu", type: .katakana, rowGroup: "Ta", exampleWord: "ツアー (tsuaa)", exampleMeaning: "Chuyến du lịch (tour)"),
        KanaCharacter(character: "テ", romaji: "te", type: .katakana, rowGroup: "Ta", exampleWord: "テレビ (terebi)", exampleMeaning: "Tivi"),
        KanaCharacter(character: "ト", romaji: "to", type: .katakana, rowGroup: "Ta", exampleWord: "トイレ (toire)", exampleMeaning: "Nhà vệ sinh"),
        
        // Hàng Na
        KanaCharacter(character: "ナ", romaji: "na", type: .katakana, rowGroup: "Na", exampleWord: "ナイフ (naifu)", exampleMeaning: "Con dao"),
        KanaCharacter(character: "ニ", romaji: "ni", type: .katakana, rowGroup: "Na", exampleWord: "ニュース (nyuusu)", exampleMeaning: "Tin tức"),
        KanaCharacter(character: "ヌ", romaji: "nu", type: .katakana, rowGroup: "Na", exampleWord: "ヌードル (nuudoru)", exampleMeaning: "Mì sợi (noodle)"),
        KanaCharacter(character: "ネ", romaji: "ne", type: .katakana, rowGroup: "Na", exampleWord: "ネクタイ (nekutai)", exampleMeaning: "Cà vạt"),
        KanaCharacter(character: "ノ", romaji: "no", type: .katakana, rowGroup: "Na", exampleWord: "ノート (nooto)", exampleMeaning: "Vở ghi chép"),
        
        // Hàng Ha
        KanaCharacter(character: "ハ", romaji: "ha", type: .katakana, rowGroup: "Ha", exampleWord: "ハンバーガー (hanbaagaa)", exampleMeaning: "Bánh burger"),
        KanaCharacter(character: "ヒ", romaji: "hi", type: .katakana, rowGroup: "Ha", exampleWord: "ヒーター (hiitaa)", exampleMeaning: "Máy sưởi"),
        KanaCharacter(character: "フ", romaji: "fu", type: .katakana, rowGroup: "Ha", exampleWord: "フォーク (fooku)", exampleMeaning: "Cái nĩa"),
        KanaCharacter(character: "ヘ", romaji: "he", type: .katakana, rowGroup: "Ha", exampleWord: "ヘルメット (herumetto)", exampleMeaning: "Mũ bảo hiểm"),
        KanaCharacter(character: "ホ", romaji: "ho", type: .katakana, rowGroup: "Ha", exampleWord: "ホテル (hoteru)", exampleMeaning: "Khách sạn"),
        
        // Hàng Ma
        KanaCharacter(character: "マ", romaji: "ma", type: .katakana, rowGroup: "Ma", exampleWord: "マスク (masuku)", exampleMeaning: "Khẩu trang"),
        KanaCharacter(character: "ミ", romaji: "mi", type: .katakana, rowGroup: "Ma", exampleWord: "ミルク (miruku)", exampleMeaning: "Sữa"),
        KanaCharacter(character: "ム", romaji: "mu", type: .katakana, rowGroup: "Ma", exampleWord: "ムービー (muubii)", exampleMeaning: "Phim ảnh"),
        KanaCharacter(character: "メ", romaji: "me", type: .katakana, rowGroup: "Ma", exampleWord: "メニュー (menyuu)", exampleMeaning: "Thực đơn"),
        KanaCharacter(character: "モ", romaji: "mo", type: .katakana, rowGroup: "Ma", exampleWord: "モデル (moderu)", exampleMeaning: "Người mẫu / Mô hình"),
        
        // Hàng Ya
        KanaCharacter(character: "ヤ", romaji: "ya", type: .katakana, rowGroup: "Ya", exampleWord: "ヤング (yangu)", exampleMeaning: "Tuổi trẻ (Young)"),
        KanaCharacter(character: "ユ", romaji: "yu", type: .katakana, rowGroup: "Ya", exampleWord: "ユニフォーム (yunifoomu)", exampleMeaning: "Đồng phục"),
        KanaCharacter(character: "ヨ", romaji: "yo", type: .katakana, rowGroup: "Ya", exampleWord: "ヨーグルト (yooguruto)", exampleMeaning: "Sữa chua"),
        
        // Hàng Ra
        KanaCharacter(character: "ラ", romaji: "ra", type: .katakana, rowGroup: "Ra", exampleWord: "ラジオ (rajio)", exampleMeaning: "Đài radio"),
        KanaCharacter(character: "リ", romaji: "ri", type: .katakana, rowGroup: "Ra", exampleWord: "リモコン (rimokon)", exampleMeaning: "Điều khiển từ xa"),
        KanaCharacter(character: "ル", romaji: "ru", type: .katakana, rowGroup: "Ra", exampleWord: "ルール (ruuru)", exampleMeaning: "Luật lệ (rule)"),
        KanaCharacter(character: "レ", romaji: "re", type: .katakana, rowGroup: "Ra", exampleWord: "レストラン (resutoran)", exampleMeaning: "Nhà hàng"),
        KanaCharacter(character: "ロ", romaji: "ro", type: .katakana, rowGroup: "Ra", exampleWord: "ロボット (robotto)", exampleMeaning: "Người máy robot"),
        
        // Hàng Wa - Wo - N
        KanaCharacter(character: "ワ", romaji: "wa", type: .katakana, rowGroup: "Wa", exampleWord: "ワイン (wain)", exampleMeaning: "Rượu vang"),
        KanaCharacter(character: "ヲ", romaji: "wo/o", type: .katakana, rowGroup: "Wa", exampleWord: "ヲ (wo)", exampleMeaning: "Ký tự Katakana Wo"),
        KanaCharacter(character: "ン", romaji: "n", type: .katakana, rowGroup: "Wa", exampleWord: "パン (pan)", exampleMeaning: "Bánh mì")
    ]
    
    public func getCharacters(for type: KanaType) -> [KanaCharacter] {
        switch type {
        case .hiragana:
            return hiraganaList
        case .katakana:
            return katakanaList
        }
    }
}
