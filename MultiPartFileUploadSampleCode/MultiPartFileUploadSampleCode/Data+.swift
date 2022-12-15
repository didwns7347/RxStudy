//
//  Data+.swift
//  MultiPartFileUploadSampleCode
//
//  Created by yangjs on 2022/11/16.
//

import Foundation
extension Data{
    func incodingHTML() -> String?{
        var html = String(data: self, encoding: .utf8)
        guard html == nil else { return html }
        let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))
        html = String(data: self, encoding: encoding)
        guard html == nil else { return html }
        html = String(decoding: self, as: UTF8.self)
        return html
    }
}
