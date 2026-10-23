//
//  KanjiRepository.swift
//  AppHocTiengNhat
//

import Foundation

public final class KanjiRepository {
    public static let shared = KanjiRepository()
    
    private init() {}
    
    public let n5KanjiList: [KanjiCharacter] = [
        // MARK: - Thiên nhiên & Thứ trong tuần
        KanjiCharacter(
            kanji: "日",
            hanViet: "NHẬT",
            onyomi: "ニチ, ジツ",
            kunyomi: "ひ, -び, -か",
            meaningVi: "Ngày, mặt trời",
            strokeCount: 4,
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
            meaningVi: "Lửa, hoả",
            strokeCount: 4,
            examples: [
                KanjiExample(word: "火曜日", reading: "かようび (kayoubi)", meaning: "Thứ ba"),
                KanjiExample(word: "火", reading: "ひ (hi)", meaning: "Ngọn lửa")
            ]
        ),
        KanjiCharacter(
            kanji: "水",
            hanViet: "THỦY",
            onyomi: "スイ",
            kunyomi: "みず",
            meaningVi: "Nước",
            strokeCount: 4,
            examples: [
                KanjiExample(word: "水", reading: "みず (mizu)", meaning: "Nước uống"),
                KanjiExample(word: "水曜日", reading: "すいようび (suiyoubi)", meaning: "Thứ tư")
            ]
        ),
        KanjiCharacter(
            kanji: "木",
            hanViet: "MỘC",
            onyomi: "ボク, モク",
            kunyomi: "き",
            meaningVi: "Cây cối, gỗ",
            strokeCount: 4,
            examples: [
                KanjiExample(word: "木", reading: "き (ki)", meaning: "Cây cối"),
                KanjiExample(word: "木曜日", reading: "もくようび (mokuyoubi)", meaning: "Thứ năm")
            ]
        ),
        KanjiCharacter(
            kanji: "金",
            hanViet: "KIM",
            onyomi: "キン",
            kunyomi: "かね",
            meaningVi: "Vàng, tiền",
            strokeCount: 8,
            examples: [
                KanjiExample(word: "お金", reading: "おかね (okane)", meaning: "Tiền bạc"),
                KanjiExample(word: "金曜日", reading: "きんようび (kinyoubi)", meaning: "Thứ sáu")
            ]
        ),
        KanjiCharacter(
            kanji: "土",
            hanViet: "THỔ",
            onyomi: "ド, ト",
            kunyomi: "つち",
            meaningVi: "Đất đai",
            strokeCount: 3,
            examples: [
                KanjiExample(word: "土曜日", reading: "どようび (doyoubi)", meaning: "Thứ bảy"),
                KanjiExample(word: "土地", reading: "とち (tochi)", meaning: "Đất đai")
            ]
        ),
        
        // MARK: - Con người & Gia đình & Trường học
        KanjiCharacter(
            kanji: "人",
            hanViet: "NHÂN",
            onyomi: "ジン, ニン",
            kunyomi: "ひと",
            meaningVi: "Người, nhân loại",
            strokeCount: 2,
            examples: [
                KanjiExample(word: "日本人", reading: "にほんじん (nihonjin)", meaning: "Người Nhật"),
                KanjiExample(word: "あの人", reading: "あのひと (anohito)", meaning: "Người kia"),
                KanjiExample(word: "三人", reading: "さんにん (sannin)", meaning: "3 người")
            ]
        ),
        KanjiCharacter(
            kanji: "本",
            hanViet: "BẢN / BỔN",
            onyomi: "ホン",
            kunyomi: "もと",
            meaningVi: "Sách, gốc rễ, nguồn gốc",
            strokeCount: 5,
            examples: [
                KanjiExample(word: "本", reading: "ほん (hon)", meaning: "Quyển sách"),
                KanjiExample(word: "日本", reading: "にほん (nihon)", meaning: "Nước Nhật")
            ]
        ),
        KanjiCharacter(
            kanji: "学",
            hanViet: "HỌC",
            onyomi: "ガク",
            kunyomi: "まな・ぶ",
            meaningVi: "Học tập, trường học",
            strokeCount: 8,
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
            kunyomi: "い・きる, う・まれる",
            meaningVi: "Sinh sống, sinh ra",
            strokeCount: 5,
            examples: [
                KanjiExample(word: "先生", reading: "せんせい (sensei)", meaning: "Giáo viên"),
                KanjiExample(word: "誕生日", reading: "たんじょうび (tanjoubi)", meaning: "Sinh nhật")
            ]
        ),
        KanjiCharacter(
            kanji: "先",
            hanViet: "TIÊN",
            onyomi: "セン",
            kunyomi: "さき",
            meaningVi: "Trước, đi trước",
            strokeCount: 6,
            examples: [
                KanjiExample(word: "先生", reading: "せんせい (sensei)", meaning: "Thầy/Cô giáo"),
                KanjiExample(word: "先週", reading: "せんしゅう (senshuu)", meaning: "Tuần trước")
            ]
        ),
        KanjiCharacter(
            kanji: "友",
            hanViet: "HỮU",
            onyomi: "ユウ",
            kunyomi: "とも",
            meaningVi: "Bạn bè",
            strokeCount: 4,
            examples: [
                KanjiExample(word: "友達", reading: "ともだち (tomodachi)", meaning: "Bạn bè"),
                KanjiExample(word: "親友", reading: "しんゆう (shinyuu)", meaning: "Bạn thân")
            ]
        ),
        
        // MARK: - Số đếm & Kích thước
        KanjiCharacter(
            kanji: "一",
            hanViet: "NHẤT",
            onyomi: "イチ",
            kunyomi: "ひと・つ",
            meaningVi: "Số 1",
            strokeCount: 1,
            examples: [
                KanjiExample(word: "一つ", reading: "ひとつ (hitotsu)", meaning: "1 cái"),
                KanjiExample(word: "一人", reading: "ひとり (hitori)", meaning: "1 người")
            ]
        ),
        KanjiCharacter(
            kanji: "二",
            hanViet: "NHỊ",
            onyomi: "ニ",
            kunyomi: "ふた・つ",
            meaningVi: "Số 2",
            strokeCount: 2,
            examples: [
                KanjiExample(word: "二つ", reading: "ふたつ (futatsu)", meaning: "2 cái"),
                KanjiExample(word: "二月", reading: "にがつ (nigatsu)", meaning: "Tháng 2")
            ]
        ),
        KanjiCharacter(
            kanji: "三",
            hanViet: "TAM",
            onyomi: "サン",
            kunyomi: "みッ・つ",
            meaningVi: "Số 3",
            strokeCount: 3,
            examples: [
                KanjiExample(word: "三つ", reading: "みっつ (mittsu)", meaning: "3 cái"),
                KanjiExample(word: "三月", reading: "さんがつ (sangatsu)", meaning: "Tháng 3")
            ]
        ),
        KanjiCharacter(
            kanji: "大",
            hanViet: "ĐẠI",
            onyomi: "ダイ, タイ",
            kunyomi: "おお・きい",
            meaningVi: "To lớn",
            strokeCount: 3,
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
            kunyomi: "ちい・さい",
            meaningVi: "Nhỏ bé",
            strokeCount: 3,
            examples: [
                KanjiExample(word: "小さい", reading: "ちいさい (chiisai)", meaning: "Nhỏ bé"),
                KanjiExample(word: "小学校", reading: "しょうがっこう (shougakkou)", meaning: "Trường tiểu học")
            ]
        ),
        KanjiCharacter(
            kanji: "中",
            hanViet: "TRUNG",
            onyomi: "チュウ",
            kunyomi: "なか",
            meaningVi: "Ở giữa, bên trong",
            strokeCount: 4,
            examples: [
                KanjiExample(word: "中", reading: "なか (naka)", meaning: "Bên trong"),
                KanjiExample(word: "中国", reading: "ちゅうごく (chuugoku)", meaning: "Trung Quốc"),
                KanjiExample(word: "一日中", reading: "いちにちじゅう (ichinichijuu)", meaning: "Suốt cả ngày")
            ]
        ),
        
        // MARK: - Động từ N5 cơ bản
        KanjiCharacter(
            kanji: "行",
            hanViet: "HÀNH",
            onyomi: "コウ, ギョウ",
            kunyomi: "い・く, おこな・う",
            meaningVi: "Đi, tiến hành",
            strokeCount: 6,
            examples: [
                KanjiExample(word: "行く", reading: "いく (iku)", meaning: "Đi"),
                KanjiExample(word: "旅行", reading: "りょこう (ryokou)", meaning: "Du lịch")
            ]
        ),
        KanjiCharacter(
            kanji: "来",
            hanViet: "LAI",
            onyomi: "ライ",
            kunyomi: "く・る, こ・ない",
            meaningVi: "Đến, tới",
            strokeCount: 7,
            examples: [
                KanjiExample(word: "来る", reading: "くる (kuru)", meaning: "Đến"),
                KanjiExample(word: "来週", reading: "らいしゅう (raishuu)", meaning: "Tuần tới"),
                KanjiExample(word: "来年", reading: "らいねん (rainen)", meaning: "Năm sau")
            ]
        ),
        KanjiCharacter(
            kanji: "食",
            hanViet: "THỰC",
            onyomi: "ショク",
            kunyomi: "た・べる",
            meaningVi: "Ăn, ẩm thực",
            strokeCount: 9,
            examples: [
                KanjiExample(word: "食べる", reading: "たべる (taberu)", meaning: "Ăn"),
                KanjiExample(word: "食べ物", reading: "たべもの (tabemono)", meaning: "Thức ăn"),
                KanjiExample(word: "食事", reading: "しょくじ (shokuji)", meaning: "Bữa ăn")
            ]
        ),
        KanjiCharacter(
            kanji: "飲",
            hanViet: "ẨM",
            onyomi: "イン",
            kunyomi: "の・む",
            meaningVi: "Uống",
            strokeCount: 12,
            examples: [
                KanjiExample(word: "飲む", reading: "のむ (nomu)", meaning: "Uống"),
                KanjiExample(word: "飲み物", reading: "のみもの (nomimono)", meaning: "Đồ uống")
            ]
        ),
        KanjiCharacter(
            kanji: "見",
            hanViet: "KIẾN",
            onyomi: "ケン",
            kunyomi: "み・る",
            meaningVi: "Nhìn, xem",
            strokeCount: 7,
            examples: [
                KanjiExample(word: "見る", reading: "みる (miru)", meaning: "Xem, nhìn"),
                KanjiExample(word: "意見", reading: "いけん (iken)", meaning: "Ý kiến")
            ]
        ),
        KanjiCharacter(
            kanji: "聞",
            hanViet: "VĂN",
            onyomi: "ブン, モン",
            kunyomi: "き・く",
            meaningVi: "Nghe, hỏi",
            strokeCount: 14,
            examples: [
                KanjiExample(word: "聞く", reading: "きく (kiku)", meaning: "Nghe"),
                KanjiExample(word: "新聞", reading: "しんぶん (shinbun)", meaning: "Báo chí")
            ]
        ),
        KanjiCharacter(
            kanji: "車",
            hanViet: "XA",
            onyomi: "シャ",
            kunyomi: "くるま",
            meaningVi: "Xe cộ",
            strokeCount: 7,
            examples: [
                KanjiExample(word: "車", reading: "くるま (kuruma)", meaning: "Xe hơi"),
                KanjiExample(word: "電車", reading: "でんしゃ (densha)", meaning: "Tàu điện")
            ]
        ),
        KanjiCharacter(
            kanji: "駅",
            hanViet: "DỊCH",
            onyomi: "エキ",
            kunyomi: "-",
            meaningVi: "Nhà ga",
            strokeCount: 14,
            examples: [
                KanjiExample(word: "駅", reading: "えき (eki)", meaning: "Nhà ga"),
                KanjiExample(word: "駅員", reading: "えきいん (ekiin)", meaning: "Nhân viên nhà ga")
            ]
        )
    ]
}
