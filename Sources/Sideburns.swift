
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

import Core
import HTTP
import Mustache

public typealias TemplateData = MustacheBoxable

enum SideburnsError: ErrorType {
	case UnsupportedTemplateEncoding	
}

extension Response {
    init(status: Status,
        headers: [String: String] = [:],
        templatePath: String,
        templateData: TemplateData) throws {
            let templateFile = try File(path: templatePath, mode: .Read)
            
            guard let templateString = try templateFile.read().string else {
            	throw SideburnsError.UnsupportedTemplateEncoding
            }

            let template = try Template(string: templateString)
            let rendering = try template.render(Box(boxable: templateData))

            var headers = headers
            headers["content-type"] = "text/html"

            self.init(
                status: status,
                headers: headers,
                body: Data(string: rendering).bytes
            )
    }
    
}