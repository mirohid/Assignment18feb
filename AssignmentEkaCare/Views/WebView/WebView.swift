//
//  WebView.swift
//  AssignmentEkaCare
//
//  Created by Mir Ohid Ali on 18/03/25.

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
    }
}

struct WebViewContainer: View {
    let url: String
    @StateObject var viewModel: NewsViewModel
    let article: NewsItem
    
    var body: some View {
        VStack {
            WebView(url: url)
            
            Button("Save Article") {
                viewModel.saveArticle(article)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isShowingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}
