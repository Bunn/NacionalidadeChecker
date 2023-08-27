//
//  ContentView.swift
//  NacionalidadeChecker
//
//  Created by Fernando Bunn on 27/08/2023.
//

import SwiftUI
import WebKit

struct ContentView: View {
    private let passKey = "passkey"
    @State var webView = WKWebView()
    @State var password: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Password", text: $password)
                Button {
                    saveButtonClicked()
                } label: {
                    Text("Save and Check")
                }
            }
            .padding()

            WebView(webView: webView) {
                injectJavascript()

            }
        }
        .frame(minWidth: 800, minHeight: 600)
        .onAppear {
            restore()
        }
    }

    private func saveButtonClicked() {
        UserDefaults.standard.set(password, forKey: passKey)
        loadPage()
    }

    private func restore() {
        if let savedText = UserDefaults.standard.string(forKey: passKey) {
            password = savedText
            if !password.isEmpty {
                loadPage()
            }
        }
    }

    private func loadPage() {
        webView.load(URLRequest(url: URL(string: "https://nacionalidade.justica.gov.pt")!))
    }

    private func injectJavascript() {
        Task { @MainActor in
            let script = "document.getElementById(\"SenhaAcesso\").value = \"\(password)\""
            try await webView.evaluateJavaScript(script)

            let enableButton = "document.getElementById(\"btnPesquisa\").disabled = false;"
            try await webView.evaluateJavaScript(enableButton)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
