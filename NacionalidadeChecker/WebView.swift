//
//  WebView.swift
//  NacionalidadeChecker
//
//  Created by Fernando Bunn on 27/08/2023.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    let webView: WKWebView
    let finishLoading: () -> Void

    func makeNSView(context: Context) -> WKWebView {
        webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self,
                    finishLoading: finishLoading)
    }
}

class Coordinator: NSObject, WKNavigationDelegate {
    let parent: WebView
    let finishLoading: () -> Void

    init(parent: WebView, finishLoading: @escaping () -> Void) {
        self.parent = parent
        self.finishLoading = finishLoading

        super.init()
        self.parent.webView.navigationDelegate = self
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        finishLoading()
    }
}
