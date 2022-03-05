//
//  GenericWebViewViewController.swift
//  GenericWebViewJourney
//
//  Created by Ravi Yaganti on 05/03/22.
//

//import BackbaseDesignSystem
import UIKit
import WebKit

public class GenericWebViewViewController: UIViewController {
    
    public var webAppURL: URL?
    
    public init(webAppURL: URL?) {
        super.init(nibName: nil, bundle: nil)
        self.webAppURL = webAppURL
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.webAppURL = nil
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .nonPersistent()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsLinkPreview = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        return webView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    public override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.addSubview(webView)
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            // loadingIndicator
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
//        DesignSystem.shared.styles.loadingIndicator(loadingIndicator)
        loadWebApp()
    }
    
    private func loadWebApp() {
        if let url = webAppURL {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func showActivityIndicator(_ show: Bool) {
        if show {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

extension GenericWebViewViewController: WKNavigationDelegate, WKUIDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(false)
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(true)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(false)
    }
}
