//
//  BookMark.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import Foundation

struct BookMark: Identifiable {
    let id = UUID()
    let bookMarkName: String
    let bookMarkAddress: String
    let bookMarkImage: String
}

let bookMarkList: [BookMark] = [
    BookMark(bookMarkName: "집", bookMarkAddress: "",
             bookMarkImage: "Home"),
    BookMark(bookMarkName: "회사", bookMarkAddress: "", bookMarkImage: "WorkPlace"),
    BookMark(bookMarkName: "거래처1", bookMarkAddress: "", bookMarkImage: "partner1"),
    BookMark(bookMarkName: "거래처2", bookMarkAddress: "", bookMarkImage: "partner2"),
    BookMark(bookMarkName: "거래처3", bookMarkAddress: "", bookMarkImage: "partner3")
]

