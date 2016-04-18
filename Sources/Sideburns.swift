
// Sideburns.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

@_exported import File
@_exported import HTTP
@_exported import Mustache

public typealias TemplateData = MustacheBoxable

public enum SideburnsError: ErrorProtocol {
	case unsupportedTemplateEncoding
}

extension Response {
    public init(status: Status = .ok, headers: Headers = [:], templatePath: String, templateData: TemplateData) throws {
        let templateFile = try File(path: templatePath, mode: .read)

        guard let templateString = try? String(data: templateFile.readAllBytes()) else {
            throw SideburnsError.unsupportedTemplateEncoding
        }

        let template = try Template(string: templateString)
        let rendering = try template.render(box: Box(boxable: templateData))

        self.init(status: status, headers: headers, body: rendering)

        if let fileExtension = templateFile.fileExtension, mediaType = mediaType(forFileExtension: fileExtension) {
            self.contentType = mediaType
        }
    }
}