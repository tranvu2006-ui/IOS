//
//  KanjiRepository.swift
//  AppHocTiengNhat
//

import Foundation

public final class KanjiRepository {
    public static let shared = KanjiRepository()
    
    private init() {}
    
    // MARK: - Kanji JLPT N5 (27 Chữ căn bản)
    public let n5KanjiList: [KanjiCharacter] = [
        // MARK: - Thiên nhiên & Thứ trong tuần
        KanjiCharacter(
            kanji: "日",
            hanViet: "NHẬT",
            onyomi: "ニチ, ジツ",
            kunyomi: "ひ, -び, -か",
            meaningVi: "Ngày, mặt trời",
            strokeCount: 4,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "日本", reading: "にほん (nihon)", meaning: "Nước Nhật"),
                KanjiExample(word: "日曜日", reading: "にちようび (nichiyoubi)", meaning: "Chủ nhật"),
                KanjiExample(word: "毎日", reading: "まいにち (mainichi)", meaning: "Mỗi ngày")
            ]
        ),
        KanjiCharacter(
            kanji: "月",
            hanViet: "NGUYỆT",
            onyomi: "ゲツ, ガツ",
            kunyomi: "つき",
            meaningVi: "Mặt trăng, tháng",
            strokeCount: 4,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "月曜日", reading: "げつようび (getsuyoubi)", meaning: "Thứ hai"),
                KanjiExample(word: "今月", reading: "こんげつ (kongetsu)", meaning: "Tháng này"),
                KanjiExample(word: "一月", reading: "いちがつ (ichigatsu)", meaning: "Tháng một")
            ]
        ),
        KanjiCharacter(
            kanji: "火",
            hanViet: "HỎA",
            onyomi: "カ",
            kunyomi: "ひ",
            meaningVi: "Lửa",
            strokeCount: 4,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "火曜日", reading: "かようび (kayoubi)", meaning: "Thứ ba"),
                KanjiExample(word: "火", reading: "ひ (hi)", meaning: "Ngọn lửa"),
                KanjiExample(word: "火山", reading: "かざん (kazan)", meaning: "Núi lửa")
            ]
        ),
        KanjiCharacter(
            kanji: "水",
            hanViet: "THỦY",
            onyomi: "スイ",
            kunyomi: "みず",
            meaningVi: "Nước",
            strokeCount: 4,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "水曜日", reading: "すいようび (suiyoubi)", meaning: "Thứ tư"),
                KanjiExample(word: "水", reading: "みず (mizu)", meaning: "Nước uống"),
                KanjiExample(word: "水泳", reading: "すいえい (suiei)", meaning: "Bơi lội")
            ]
        ),
        KanjiCharacter(
            kanji: "木",
            hanViet: "MỘC",
            onyomi: "モク, ボク",
            kunyomi: "き",
            meaningVi: "Cây, gỗ",
            strokeCount: 4,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "木曜日", reading: "もくようび (mokuyoubi)", meaning: "Thứ năm"),
                KanjiExample(word: "木", reading: "き (ki)", meaning: "Cái cây"),
                KanjiExample(word: "木材", reading: "もくざい (mokuzai)", meaning: "Gỗ xây dựng")
            ]
        ),
        KanjiCharacter(
            kanji: "金",
            hanViet: "KIM",
            onyomi: "キン, コン",
            kunyomi: "かね, かな-",
            meaningVi: "Vàng, tiền",
            strokeCount: 8,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "金曜日", reading: "きんようび (kinyoubi)", meaning: "Thứ sáu"),
                KanjiExample(word: "お金", reading: "おかね (okane)", meaning: "Tiền bạc"),
                KanjiExample(word: "金", reading: "きん (kin)", meaning: "Vàng")
            ]
        ),
        KanjiCharacter(
            kanji: "土",
            hanViet: "THỔ",
            onyomi: "ド, ト",
            kunyomi: "つち",
            meaningVi: "Đất",
            strokeCount: 3,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "土曜日", reading: "どようび (doyoubi)", meaning: "Thứ bảy"),
                KanjiExample(word: "土", reading: "つち (tsuchi)", meaning: "Đất cát"),
                KanjiExample(word: "土地", reading: "とち (tochi)", meaning: "Khu đất")
            ]
        ),
        // MARK: - Con người & Gia đình
        KanjiCharacter(
            kanji: "人",
            hanViet: "NHÂN",
            onyomi: "ジン, ニン",
            kunyomi: "ひと",
            meaningVi: "Người",
            strokeCount: 2,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "日本人", reading: "にほんじん (nihonjin)", meaning: "Người Nhật"),
                KanjiExample(word: "人", reading: "ひと (hito)", meaning: "Con người"),
                KanjiExample(word: "三人", reading: "さんにん (sannin)", meaning: "Ba người")
            ]
        ),
        KanjiCharacter(
            kanji: "本",
            hanViet: "BẢN / BỔN",
            onyomi: "ホン",
            kunyomi: "もと",
            meaningVi: "Sách, gốc rễ",
            strokeCount: 5,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "本", reading: "ほん (hon)", meaning: "Quyển sách"),
                KanjiExample(word: "日本", reading: "にほん (nihon)", meaning: "Nước Nhật"),
                KanjiExample(word: "山本", reading: "やまもと (yamamoto)", meaning: "Họ Yamamoto")
            ]
        ),
        KanjiCharacter(
            kanji: "学",
            hanViet: "HỌC",
            onyomi: "ガク",
            kunyomi: "まな・ぶ",
            meaningVi: "Học tập",
            strokeCount: 8,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "学生", reading: "がくせい (gakusei)", meaning: "Học sinh/Sinh viên"),
                KanjiExample(word: "学校", reading: "がっこう (gakkou)", meaning: "Trường học"),
                KanjiExample(word: "大学", reading: "だいがく (daigaku)", meaning: "Đại học")
            ]
        ),
        KanjiCharacter(
            kanji: "生",
            hanViet: "SINH",
            onyomi: "セイ, ショウ",
            kunyomi: "い・きる, う・まれる, なま",
            meaningVi: "Sinh sống, sinh ra",
            strokeCount: 5,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "先生", reading: "せんせい (sensei)", meaning: "Thầy/Cô giáo"),
                KanjiExample(word: "誕生日", reading: "たんじょうび (tanjoubi)", meaning: "Sinh nhật"),
                KanjiExample(word: "生きる", reading: "いきる (ikiru)", meaning: "Sống")
            ]
        ),
        KanjiCharacter(
            kanji: "先",
            hanViet: "TIÊN",
            onyomi: "セン",
            kunyomi: "さき, ま・ず",
            meaningVi: "Trước, đi trước",
            strokeCount: 6,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "先生", reading: "せんせい (sensei)", meaning: "Giáo viên"),
                KanjiExample(word: "先週", reading: "せんしゅう (senshuu)", meaning: "Tuần trước"),
                KanjiExample(word: "お先に", reading: "おさきに (osakini)", meaning: "Trước (tôi xin phép về trước)")
            ]
        ),
        KanjiCharacter(
            kanji: "友",
            hanViet: "HỮU",
            onyomi: "ユウ",
            kunyomi: "とも",
            meaningVi: "Bạn bè",
            strokeCount: 4,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "友達", reading: "ともだち (tomodachi)", meaning: "Bạn bè"),
                KanjiExample(word: "友人", reading: "ゆうじん (yuujin)", meaning: "Bạn thân"),
                KanjiExample(word: "親友", reading: "しんゆう (shinyuu)", meaning: "Bạn chí cốt")
            ]
        ),
        // MARK: - Chữ số & Kích thước
        KanjiCharacter(
            kanji: "一",
            hanViet: "NHẤT",
            onyomi: "イチ, イツ",
            kunyomi: "ひと, ひと・つ",
            meaningVi: "Số một",
            strokeCount: 1,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "一つ", reading: "ひとつ (hitotsu)", meaning: "Một cái"),
                KanjiExample(word: "一人", reading: "ひとり (hitori)", meaning: "Một người"),
                KanjiExample(word: "一日", reading: "ついたち (tsuitachi)", meaning: "Ngày mùng một")
            ]
        ),
        KanjiCharacter(
            kanji: "二",
            hanViet: "NHỊ",
            onyomi: "ニ",
            kunyomi: "ふた, ふた・つ",
            meaningVi: "Số hai",
            strokeCount: 2,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "二つ", reading: "ふたつ (futatsu)", meaning: "Hai cái"),
                KanjiExample(word: "二人", reading: "ふたり (futari)", meaning: "Hai người"),
                KanjiExample(word: "二月", reading: "にがつ (nigatsu)", meaning: "Tháng hai")
            ]
        ),
        KanjiCharacter(
            kanji: "三",
            hanViet: "TAM",
            onyomi: "サン",
            kunyomi: "み, み・つ, みっ・つ",
            meaningVi: "Số ba",
            strokeCount: 3,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "三つ", reading: "みっつ (mittsu)", meaning: "Ba cái"),
                KanjiExample(word: "三人", reading: "さんにん (sannin)", meaning: "Ba người"),
                KanjiExample(word: "三日", reading: "みっか (mikka)", meaning: "Ngày mùng ba")
            ]
        ),
        KanjiCharacter(
            kanji: "大",
            hanViet: "ĐẠI",
            onyomi: "ダイ, タイ",
            kunyomi: "おお・きい",
            meaningVi: "To, lớn",
            strokeCount: 3,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "大きい", reading: "おおきい (ookii)", meaning: "To lớn"),
                KanjiExample(word: "大学", reading: "だいがく (daigaku)", meaning: "Đại học"),
                KanjiExample(word: "大人", reading: "おとな (otona)", meaning: "Người lớn")
            ]
        ),
        KanjiCharacter(
            kanji: "小",
            hanViet: "TIỂU",
            onyomi: "ショウ",
            kunyomi: "ちい・さい, こ-, お-",
            meaningVi: "Nhỏ, bé",
            strokeCount: 3,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "小さい", reading: "ちいさい (chiisai)", meaning: "Nhỏ bé"),
                KanjiExample(word: "小学校", reading: "しょうがっこう (shougakkou)", meaning: "Trường tiểu học"),
                KanjiExample(word: "小川", reading: "おがわ (ogawa)", meaning: "Con suối nhỏ")
            ]
        ),
        KanjiCharacter(
            kanji: "中",
            hanViet: "TRUNG",
            onyomi: "チュウ",
            kunyomi: "なか",
            meaningVi: "Trong, ở giữa",
            strokeCount: 4,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "中", reading: "なか (naka)", meaning: "Bên trong"),
                KanjiExample(word: "中学校", reading: "ちゅうがっこう (chuugakkou)", meaning: "Trường THCS"),
                KanjiExample(word: "一日中", reading: "いちにちじゅう (ichinichijuu)", meaning: "Suốt cả ngày")
            ]
        ),
        // MARK: - Động từ & Hành động
        KanjiCharacter(
            kanji: "行",
            hanViet: "HÀNH",
            onyomi: "コウ, ギョウ",
            kunyomi: "い・く, ゆ・く, おこな・う",
            meaningVi: "Đi, tiến hành",
            strokeCount: 6,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "行く", reading: "いく (iku)", meaning: "Đi"),
                KanjiExample(word: "旅行", reading: "りょこう (ryokou)", meaning: "Du lịch"),
                KanjiExample(word: "銀行", reading: "ぎんこう (ginkou)", meaning: "Ngân hàng")
            ]
        ),
        KanjiCharacter(
            kanji: "来",
            hanViet: "LAI",
            onyomi: "ライ",
            kunyomi: "く・る, きた・る",
            meaningVi: "Đến, tới",
            strokeCount: 7,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "来る", reading: "くる (kuru)", meaning: "Đến"),
                KanjiExample(word: "来週", reading: "らいしゅう (raishuu)", meaning: "Tuần sau"),
                KanjiExample(word: "来年", reading: "らいねん (rainen)", meaning: "Năm sau")
            ]
        ),
        KanjiCharacter(
            kanji: "食",
            hanViet: "THỰC",
            onyomi: "ショク",
            kunyomi: "た・べる, く・う",
            meaningVi: "Ăn, đồ ăn",
            strokeCount: 9,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "食べる", reading: "たべる (taberu)", meaning: "Ăn"),
                KanjiExample(word: "食べ物", reading: "たべもの (tabemono)", meaning: "Đồ ăn"),
                KanjiExample(word: "食堂", reading: "しょくどう (shokudou)", meaning: "Nhà ăn")
            ]
        ),
        KanjiCharacter(
            kanji: "飲",
            hanViet: "ẨM",
            onyomi: "イン",
            kunyomi: "の・む",
            meaningVi: "Uống",
            strokeCount: 12,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "飲む", reading: "のむ (nomu)", meaning: "Uống"),
                KanjiExample(word: "飲み物", reading: "のみもの (nomimono)", meaning: "Đồ uống"),
                KanjiExample(word: "飲食店", reading: "いんしょくてん (inshokuten)", meaning: "Quán ăn uống")
            ]
        ),
        KanjiCharacter(
            kanji: "見",
            hanViet: "KIẾN",
            onyomi: "ケン",
            kunyomi: "み・る, み・える, み・せる",
            meaningVi: "Nhìn, thấy",
            strokeCount: 7,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "見る", reading: "みる (miru)", meaning: "Xem, nhìn"),
                KanjiExample(word: "見せる", reading: "みせる (miseru)", meaning: "Cho xem"),
                KanjiExample(word: "意見", reading: "いけん (iken)", meaning: "Ý kiến")
            ]
        ),
        KanjiCharacter(
            kanji: "聞",
            hanViet: "VĂN / VẤN",
            onyomi: "ブン, モン",
            kunyomi: "き・く, き・こえる",
            meaningVi: "Nghe, hỏi",
            strokeCount: 14,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "聞く", reading: "きく (kiku)", meaning: "Nghe / Hỏi"),
                KanjiExample(word: "新聞", reading: "しんぶん (shinbun)", meaning: "Báo chí"),
                KanjiExample(word: "聞こえる", reading: "きこえる (kikoeru)", meaning: "Nghe thấy")
            ]
        ),
        KanjiCharacter(
            kanji: "車",
            hanViet: "XA",
            onyomi: "シャ",
            kunyomi: "くるま",
            meaningVi: "Xe hơi, bánh xe",
            strokeCount: 7,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "車", reading: "くるま (kuruma)", meaning: "Xe ô tô"),
                KanjiExample(word: "電車", reading: "でんしゃ (densha)", meaning: "Tàu điện"),
                KanjiExample(word: "自転車", reading: "じてんしゃ (jitensha)", meaning: "Xe đạp")
            ]
        ),
        KanjiCharacter(
            kanji: "駅",
            hanViet: "DỊCH",
            onyomi: "エキ",
            kunyomi: "-",
            meaningVi: "Nhà ga",
            strokeCount: 14,
            jlptLevel: "N5",
            examples: [
                KanjiExample(word: "駅", reading: "えき (eki)", meaning: "Nhà ga"),
                KanjiExample(word: "駅前", reading: "えきまえ (ekimae)", meaning: "Trước nhà ga"),
                KanjiExample(word: "東京駅", reading: "とうきょうえき (toukyoueki)", meaning: "Ga Tokyo")
            ]
        )
    ]

    // MARK: - Kanji JLPT N4 (40 Chữ trọng tâm)
    public let n4KanjiList: [KanjiCharacter] = [
        // 1. Giao tiếp & Xã hội
        KanjiCharacter(
            kanji: "会",
            hanViet: "HỘI",
            onyomi: "カイ, エ",
            kunyomi: "あ・う",
            meaningVi: "Gặp gỡ, hội họp",
            strokeCount: 6,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "会う", reading: "あう (au)", meaning: "Gặp mặt"),
                KanjiExample(word: "会社", reading: "かいしゃ (kaisha)", meaning: "Công ty"),
                KanjiExample(word: "会話", reading: "かいわ (kaiwa)", meaning: "Hội thoại")
            ]
        ),
        KanjiCharacter(
            kanji: "社",
            hanViet: "XÃ",
            onyomi: "シャ",
            kunyomi: "やしろ",
            meaningVi: "Xã hội, công ty, đền thờ",
            strokeCount: 7,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "社会", reading: "しゃかい (shakai)", meaning: "Xã hội"),
                KanjiExample(word: "神社", reading: "じんじゃ (jinja)", meaning: "Đền Thần đạo"),
                KanjiExample(word: "社員", reading: "しゃいん (shain)", meaning: "Nhân viên công ty")
            ]
        ),
        KanjiCharacter(
            kanji: "店",
            hanViet: "ĐIẾM",
            onyomi: "テン",
            kunyomi: "みせ",
            meaningVi: "Cửa hàng, tiệm",
            strokeCount: 8,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "店", reading: "みせ (mise)", meaning: "Cửa hàng"),
                KanjiExample(word: "店員", reading: "てんいん (ten'in)", meaning: "Nhân viên bán hàng"),
                KanjiExample(word: "喫茶店", reading: "きっさてん (kissaten)", meaning: "Quán cà phê")
            ]
        ),
        KanjiCharacter(
            kanji: "言",
            hanViet: "NGÔN",
            onyomi: "ゲン, ゴン",
            kunyomi: "い・う, こと",
            meaningVi: "Nói, lời nói",
            strokeCount: 7,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "言う", reading: "いう (iu)", meaning: "Nói"),
                KanjiExample(word: "言葉", reading: "ことば (kotoba)", meaning: "Từ vựng, ngôn ngữ"),
                KanjiExample(word: "伝言", reading: "でんごん (dengon)", meaning: "Tin nhắn để lại")
            ]
        ),
        KanjiCharacter(
            kanji: "話",
            hanViet: "THOẠI",
            onyomi: "ワ",
            kunyomi: "はな・す, はなし",
            meaningVi: "Nói chuyện, câu chuyện",
            strokeCount: 13,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "話す", reading: "はなす (hanasu)", meaning: "Nói chuyện"),
                KanjiExample(word: "電話", reading: "でんわ (denwa)", meaning: "Điện thoại"),
                KanjiExample(word: "昔話", reading: "むかしばなし (mukashibanashi)", meaning: "Chuyện cổ tích")
            ]
        ),
        KanjiCharacter(
            kanji: "語",
            hanViet: "NGỮ",
            onyomi: "ゴ",
            kunyomi: "かた・る",
            meaningVi: "Ngôn ngữ, kể chuyện",
            strokeCount: 14,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "日本語", reading: "にほんご (nihongo)", meaning: "Tiếng Nhật"),
                KanjiExample(word: "英語", reading: "えいご (eigo)", meaning: "Tiếng Anh"),
                KanjiExample(word: "物語", reading: "ものがたり (monogatari)", meaning: "Câu chuyện kể")
            ]
        ),
        // 2. Mua bán & Nhân sự
        KanjiCharacter(
            kanji: "買",
            hanViet: "MÃI",
            onyomi: "バイ",
            kunyomi: "か・う",
            meaningVi: "Mua",
            strokeCount: 12,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "買う", reading: "かう (kau)", meaning: "Mua sắm"),
                KanjiExample(word: "買い物", reading: "かいもの (kaimono)", meaning: "Mua đồ"),
                KanjiExample(word: "売買", reading: "ばいばい (baibai)", meaning: "Mua bán")
            ]
        ),
        KanjiCharacter(
            kanji: "売",
            hanViet: "MẠI",
            onyomi: "バイ",
            kunyomi: "う・る, う・れる",
            meaningVi: "Bán",
            strokeCount: 7,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "売る", reading: "うる (uru)", meaning: "Bán"),
                KanjiExample(word: "売り場", reading: "うりば (uriba)", meaning: "Quầy bán hàng"),
                KanjiExample(word: "自動販売機", reading: "じどうはんばいき (jidouhanbaiki)", meaning: "Máy bán hàng tự động")
            ]
        ),
        KanjiCharacter(
            kanji: "員",
            hanViet: "VIÊN",
            onyomi: "イン",
            kunyomi: "-",
            meaningVi: "Thành viên, nhân viên",
            strokeCount: 10,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "会社員", reading: "かいしゃいん (kaishain)", meaning: "Nhân viên công ty"),
                KanjiExample(word: "銀行員", reading: "ぎんこういん (ginkouin)", meaning: "Nhân viên ngân hàng"),
                KanjiExample(word: "全員", reading: "ぜんいん (zen'in)", meaning: "Toàn thể mọi người")
            ]
        ),
        KanjiCharacter(
            kanji: "銀",
            hanViet: "NGÂN",
            onyomi: "ギン",
            kunyomi: "しろがね",
            meaningVi: "Bạc, tiền bạc",
            strokeCount: 14,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "銀行", reading: "ぎんこう (ginkou)", meaning: "Ngân hàng"),
                KanjiExample(word: "銀色", reading: "ぎんいろ (gin'iro)", meaning: "Màu bạc"),
                KanjiExample(word: "銀メダル", reading: "ぎんメダル (gin medaru)", meaning: "Huy chương bạc")
            ]
        ),
        // 3. Hoạt động & Hành động
        KanjiCharacter(
            kanji: "読",
            hanViet: "ĐỘC",
            onyomi: "ドク, トク",
            kunyomi: "よ・む",
            meaningVi: "Đọc",
            strokeCount: 14,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "読む", reading: "よむ (yomu)", meaning: "Đọc sách"),
                KanjiExample(word: "読書", reading: "どくしょ (dokusho)", meaning: "Đọc sách (sở thích)"),
                KanjiExample(word: "読解", reading: "どっかい (dokkai)", meaning: "Đọc hiểu")
            ]
        ),
        KanjiCharacter(
            kanji: "書",
            hanViet: "THƯ",
            onyomi: "ショ",
            kunyomi: "か・く",
            meaningVi: "Viết, sách",
            strokeCount: 10,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "書く", reading: "かく (kaku)", meaning: "Viết"),
                KanjiExample(word: "辞書", reading: "じしょ (jisho)", meaning: "Từ điển"),
                KanjiExample(word: "図書館", reading: "としょかん (toshokan)", meaning: "Thư viện")
            ]
        ),
        KanjiCharacter(
            kanji: "思",
            hanViet: "TƯ",
            onyomi: "シ",
            kunyomi: "おも・う",
            meaningVi: "Nghĩ, suy nghĩ",
            strokeCount: 9,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "思う", reading: "おもう (omou)", meaning: "Nghĩ rằng"),
                KanjiExample(word: "思い出", reading: "おもいで (omoide)", meaning: "Kỷ niệm"),
                KanjiExample(word: "不思議", reading: "ふしぎ (fushigi)", meaning: "Kỳ lạ, kỳ diệu")
            ]
        ),
        KanjiCharacter(
            kanji: "知",
            hanViet: "TRI",
            onyomi: "チ",
            kunyomi: "し・る",
            meaningVi: "Biết, hiểu biết",
            strokeCount: 8,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "知る", reading: "しる (shiru)", meaning: "Biết"),
                KanjiExample(word: "知らせる", reading: "しらせる (shiraseru)", meaning: "Thông báo"),
                KanjiExample(word: "知識", reading: "ちしき (chishiki)", meaning: "Tri thức, kiến thức")
            ]
        ),
        KanjiCharacter(
            kanji: "作",
            hanViet: "TÁC",
            onyomi: "サク, サ",
            kunyomi: "つく・る",
            meaningVi: "Làm, chế tạo",
            strokeCount: 7,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "作る", reading: "つくる (tsukuru)", meaning: "Chế tạo, nấu ăn"),
                KanjiExample(word: "作文", reading: "さくぶん (sakubun)", meaning: "Bài tập làm văn"),
                KanjiExample(word: "作品", reading: "さくひん (sakuhin)", meaning: "Tác phẩm nghệ thuật")
            ]
        ),
        KanjiCharacter(
            kanji: "使",
            hanViet: "SỬ / SỨ",
            onyomi: "シ",
            kunyomi: "つか・う",
            meaningVi: "Sử dụng, sai khiến",
            strokeCount: 8,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "使う", reading: "つかう (tsukau)", meaning: "Sử dụng"),
                KanjiExample(word: "大使館", reading: "たいしかん (taishikan)", meaning: "Đại sứ quán"),
                KanjiExample(word: "使い方", reading: "つかいかた (tsukaikata)", meaning: "Cách sử dụng")
            ]
        ),
        KanjiCharacter(
            kanji: "待",
            hanViet: "ĐÃI",
            onyomi: "タイ",
            kunyomi: "ま・つ",
            meaningVi: "Đợi, chờ đợi",
            strokeCount: 9,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "待つ", reading: "まつ (matsu)", meaning: "Chờ đợi"),
                KanjiExample(word: "待合室", reading: "まちあいしつ (machiaishitsu)", meaning: "Phòng chờ"),
                KanjiExample(word: "期待", reading: "きたい (kitai)", meaning: "Kỳ vọng, mong chờ")
            ]
        ),
        KanjiCharacter(
            kanji: "持",
            hanViet: "TRÌ",
            onyomi: "ジ",
            kunyomi: "も・つ",
            meaningVi: "Cầm, nắm, giữ",
            strokeCount: 9,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "持つ", reading: "もつ (motsu)", meaning: "Cầm, sở hữu"),
                KanjiExample(word: "持参", reading: "じさん (jisan)", meaning: "Mang theo"),
                KanjiExample(word: "気持ち", reading: "きもち (kimochi)", meaning: "Tâm trạng, cảm giác")
            ]
        ),
        KanjiCharacter(
            kanji: "送",
            hanViet: "TỐNG",
            onyomi: "ソウ",
            kunyomi: "おく・る",
            meaningVi: "Gửi đi, tiễn biệt",
            strokeCount: 9,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "送る", reading: "おくる (okuru)", meaning: "Gửi đồ / Tiễn người"),
                KanjiExample(word: "見送る", reading: "みおくる (miokuru)", meaning: "Tiễn đưa"),
                KanjiExample(word: "送料", reading: "そうりょう (souryou)", meaning: "Cước phí vận chuyển")
            ]
        ),
        // 4. Tự nhiên & Đời sống
        KanjiCharacter(
            kanji: "空",
            hanViet: "KHÔNG",
            onyomi: "クウ",
            kunyomi: "そら, あ・く, から",
            meaningVi: "Bầu trời, trống rỗng",
            strokeCount: 8,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "空", reading: "そら (sora)", meaning: "Bầu trời"),
                KanjiExample(word: "空港", reading: "くうこう (kuukou)", meaning: "Sân bay"),
                KanjiExample(word: "空気", reading: "くうき (kuuki)", meaning: "Không khí")
            ]
        ),
        KanjiCharacter(
            kanji: "雨",
            hanViet: "VŨ",
            onyomi: "ウ",
            kunyomi: "あめ, あま-",
            meaningVi: "Mưa",
            strokeCount: 8,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "雨", reading: "あめ (ame)", meaning: "Cơn mưa"),
                KanjiExample(word: "大雨", reading: "おおあめ (ooame)", meaning: "Mưa to"),
                KanjiExample(word: "雨天", reading: "うてん (uten)", meaning: "Trời mưa")
            ]
        ),
        KanjiCharacter(
            kanji: "電",
            hanViet: "ĐIỆN",
            onyomi: "デン",
            kunyomi: "-",
            meaningVi: "Điện khí, sấm chớp",
            strokeCount: 13,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "電気", reading: "でんき (denki)", meaning: "Điện, đèn điện"),
                KanjiExample(word: "電話", reading: "でんわ (denwa)", meaning: "Điện thoại"),
                KanjiExample(word: "電車", reading: "でんしゃ (densha)", meaning: "Tàu điện")
            ]
        ),
        KanjiCharacter(
            kanji: "道",
            hanViet: "ĐẠO",
            onyomi: "ドウ, トウ",
            kunyomi: "みち",
            meaningVi: "Con đường, đạo lý",
            strokeCount: 12,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "道", reading: "みち (michi)", meaning: "Con đường"),
                KanjiExample(word: "北海道", reading: "ほっかいどう (hokkaidou)", meaning: "Hokkaido"),
                KanjiExample(word: "歩道", reading: "ほどう (hodou)", meaning: "Đường đi bộ")
            ]
        ),
        KanjiCharacter(
            kanji: "町",
            hanViet: "ĐINH",
            onyomi: "チョウ",
            kunyomi: "まち",
            meaningVi: "Khu phố, thị trấn",
            strokeCount: 7,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "町", reading: "まち (machi)", meaning: "Thị trấn, phố xá"),
                KanjiExample(word: "町長", reading: "ちょうちょう (chouchou)", meaning: "Thị trưởng"),
                KanjiExample(word: "下町", reading: "したまち (shitamachi)", meaning: "Khu phố cổ")
            ]
        ),
        KanjiCharacter(
            kanji: "旅",
            hanViet: "LỮ",
            onyomi: "リョ",
            kunyomi: "たび",
            meaningVi: "Du lịch, lữ hành",
            strokeCount: 10,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "旅行", reading: "りょこう (ryokou)", meaning: "Đi du lịch"),
                KanjiExample(word: "旅", reading: "たび (tabi)", meaning: "Chuyến đi"),
                KanjiExample(word: "旅館", reading: "りょかん (ryokan)", meaning: "Khách sạn kiểu Nhật")
            ]
        ),
        // 5. Cơ thể & Cảm xúc
        KanjiCharacter(
            kanji: "手",
            hanViet: "THỦ",
            onyomi: "シュ",
            kunyomi: "て, た-",
            meaningVi: "Tay, bàn tay",
            strokeCount: 4,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "手", reading: "て (te)", meaning: "Bàn tay"),
                KanjiExample(word: "上手", reading: "じょうず (jouzu)", meaning: "Giỏi, khéo léo"),
                KanjiExample(word: "下手", reading: "へた (heta)", meaning: "Kém, vụng về")
            ]
        ),
        KanjiCharacter(
            kanji: "目",
            hanViet: "MỤC",
            onyomi: "モク, ボク",
            kunyomi: "め, -め, ま-",
            meaningVi: "Mắt, ánh mắt",
            strokeCount: 5,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "目", reading: "め (me)", meaning: "Đôi mắt"),
                KanjiExample(word: "目的", reading: "もくてき (mokuteki)", meaning: "Mục đích"),
                KanjiExample(word: "一目", reading: "ひとめ (hitome)", meaning: "Cái nhìn đầu tiên")
            ]
        ),
        KanjiCharacter(
            kanji: "口",
            hanViet: "KHẨU",
            onyomi: "コウ, ク",
            kunyomi: "くち",
            meaningVi: "Miệng, lối vào",
            strokeCount: 3,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "口", reading: "くち (kuchi)", meaning: "Miệng"),
                KanjiExample(word: "入口", reading: "いりぐち (iriguchi)", meaning: "Cửa vào"),
                KanjiExample(word: "出口", reading: "でぐち (deguchi)", meaning: "Cửa ra")
            ]
        ),
        KanjiCharacter(
            kanji: "耳",
            hanViet: "NHĨ",
            onyomi: "ジ",
            kunyomi: "みみ",
            meaningVi: "Tai, đôi tai",
            strokeCount: 6,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "耳", reading: "みみ (mimi)", meaning: "Lỗ tai"),
                KanjiExample(word: "初耳", reading: "はつみみ (hatsumimi)", meaning: "Lần đầu nghe thấy"),
                KanjiExample(word: "耳鼻科", reading: "じびか (jibika)", meaning: "Khoa tai mũi họng")
            ]
        ),
        KanjiCharacter(
            kanji: "足",
            hanViet: "TÚC",
            onyomi: "ソク",
            kunyomi: "あし, た・りる, た・す",
            meaningVi: "Chân, đầy đủ",
            strokeCount: 7,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "足", reading: "あし (ashi)", meaning: "Bàn chân, cẳng chân"),
                KanjiExample(word: "足りる", reading: "たりる (tariru)", meaning: "Đầy đủ"),
                KanjiExample(word: "遠足", reading: "えんそく (ensoku)", meaning: "Dã ngoại, đi bộ xa")
            ]
        ),
        KanjiCharacter(
            kanji: "心",
            hanViet: "TÂM",
            onyomi: "シン",
            kunyomi: "こころ",
            meaningVi: "Tim, tấm lòng, tâm trí",
            strokeCount: 4,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "心", reading: "こころ (kokoro)", meaning: "Trái tim, tấm lòng"),
                KanjiExample(word: "安心", reading: "あんしん (anshin)", meaning: "Yên tâm"),
                KanjiExample(word: "心配", reading: "しんぱい (shinpai)", meaning: "Lo lắng")
            ]
        ),
        // 6. Gia đình & Họ hàng
        KanjiCharacter(
            kanji: "家",
            hanViet: "GIA",
            onyomi: "カ, ケ",
            kunyomi: "いえ, や, うち",
            meaningVi: "Nhà, gia đình",
            strokeCount: 10,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "家", reading: "いえ (ie)", meaning: "Ngôi nhà"),
                KanjiExample(word: "家族", reading: "かぞく (kazoku)", meaning: "Gia đình"),
                KanjiExample(word: "家内", reading: "かない (kanai)", meaning: "Vợ tôi")
            ]
        ),
        KanjiCharacter(
            kanji: "族",
            hanViet: "TỘC",
            onyomi: "ゾク",
            kunyomi: "-",
            meaningVi: "Gia tộc, chủng tộc",
            strokeCount: 11,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "家族", reading: "かぞく (kazoku)", meaning: "Gia đình"),
                KanjiExample(word: "民族", reading: "みんぞく (minzoku)", meaning: "Dân tộc"),
                KanjiExample(word: "親族", reading: "しんぞく (shinzoku)", meaning: "Thân tộc, bà con")
            ]
        ),
        KanjiCharacter(
            kanji: "親",
            hanViet: "THÂN",
            onyomi: "シン",
            kunyomi: "おや, した・しい",
            meaningVi: "Cha mẹ, thân thiết",
            strokeCount: 16,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "両親", reading: "りょうしん (ryoushin)", meaning: "Cha mẹ"),
                KanjiExample(word: "親切", reading: "しんせつ (shinsetsu)", meaning: "Tốt bụng, nhiệt tình"),
                KanjiExample(word: "親しい", reading: "したしい (shitashii)", meaning: "Thân thiện")
            ]
        ),
        KanjiCharacter(
            kanji: "兄",
            hanViet: "HUYNH",
            onyomi: "ケイ, キョウ",
            kunyomi: "あに",
            meaningVi: "Anh trai",
            strokeCount: 5,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "兄", reading: "あに (ani)", meaning: "Anh trai tôi"),
                KanjiExample(word: "お兄さん", reading: "おにいさん (oniisan)", meaning: "Anh trai bạn"),
                KanjiExample(word: "兄弟", reading: "きょうだい (kyoudai)", meaning: "Anh em")
            ]
        ),
        KanjiCharacter(
            kanji: "姉",
            hanViet: "TỶ",
            onyomi: "シ",
            kunyomi: "あね",
            meaningVi: "Chị gái",
            strokeCount: 8,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "姉", reading: "あね (ane)", meaning: "Chị gái tôi"),
                KanjiExample(word: "お姉さん", reading: "おねえさん (oneesan)", meaning: "Chị gái bạn"),
                KanjiExample(word: "姉妹", reading: "しまい (shimai)", meaning: "Chị em gái")
            ]
        ),
        // 7. Học tập & Rèn luyện
        KanjiCharacter(
            kanji: "勉",
            hanViet: "MIỄN",
            onyomi: "ベン",
            kunyomi: "つと・める",
            meaningVi: "Cố gắng, chăm chỉ",
            strokeCount: 10,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "勉強", reading: "べんきょう (benkyou)", meaning: "Học tập"),
                KanjiExample(word: "勉強会", reading: "べんきょうかい (benkyoukai)", meaning: "Nhóm học tập"),
                KanjiExample(word: "勤勉", reading: "きんべん (kinben)", meaning: "Chăm chỉ, cần cù")
            ]
        ),
        KanjiCharacter(
            kanji: "強",
            hanViet: "CƯỜNG",
            onyomi: "キョウ, ゴウ",
            kunyomi: "つよ・い, つよ・まる",
            meaningVi: "Mạnh mẽ, cường tráng",
            strokeCount: 11,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "強い", reading: "つよい (tsuyoi)", meaning: "Mạnh mẽ"),
                KanjiExample(word: "勉強する", reading: "べんきょうする (benkyousuru)", meaning: "Học hành"),
                KanjiExample(word: "強風", reading: "きょうふう (kyoufuu)", meaning: "Gió mạnh")
            ]
        ),
        KanjiCharacter(
            kanji: "験",
            hanViet: "NGHIỆM",
            onyomi: "ケン, ゲン",
            kunyomi: "-",
            meaningVi: "Thử nghiệm, kiểm tra",
            strokeCount: 18,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "試験", reading: "しけん (shiken)", meaning: "Kỳ thi"),
                KanjiExample(word: "経験", reading: "けいけん (keiken)", meaning: "Kinh nghiệm"),
                KanjiExample(word: "実験", reading: "じっけん (jikken)", meaning: "Thực nghiệm")
            ]
        ),
        KanjiCharacter(
            kanji: "漢",
            hanViet: "HÁN",
            onyomi: "カン",
            kunyomi: "-",
            meaningVi: "Chữ Hán, nhà Hán",
            strokeCount: 13,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "漢字", reading: "かんじ (kanji)", meaning: "Chữ Hán"),
                KanjiExample(word: "漢方", reading: "かんぽう (kanpou)", meaning: "Thuốc Đông y"),
                KanjiExample(word: "漢文", reading: "かんぶん (kanbun)", meaning: "Văn thư cổ Hán tự")
            ]
        ),
        KanjiCharacter(
            kanji: "字",
            hanViet: "TỰ",
            onyomi: "ジ",
            kunyomi: "あざ",
            meaningVi: "Chữ viết, ký tự",
            strokeCount: 6,
            jlptLevel: "N4",
            examples: [
                KanjiExample(word: "漢字", reading: "かんじ (kanji)", meaning: "Chữ Hán"),
                KanjiExample(word: "文字", reading: "もじ (moji)", meaning: "Chữ cái, ký tự"),
                KanjiExample(word: "ローマ字", reading: "ローマじ (roomaji)", meaning: "Chữ La-tinh")
            ]
        )
    ]
    
    // MARK: - Tổng hợp toàn bộ Kanji (N5 + N4)
    public var allKanji: [KanjiCharacter] {
        return n5KanjiList + n4KanjiList
    }
    
    public func getKanji(for level: String? = nil) -> [KanjiCharacter] {
        guard let level = level?.uppercased(), !level.isEmpty else {
            return allKanji
        }
        if level == "N5" {
            return n5KanjiList
        } else if level == "N4" {
            return n4KanjiList
        }
        return allKanji
    }
}
