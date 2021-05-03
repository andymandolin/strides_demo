//
//  StridesVC.swift
//  DemoBuild
//
//  Created by Andy Geipel on 4/30/21.
//

import UIKit
import WebKit

class StridesVC: UIViewController, WKNavigationDelegate {
    
    //MARK:- Properties
    
    lazy var activityView = UIActivityIndicatorView()
    
    var webView = WKWebView()
    
    lazy var surroundView = UIView()
    lazy var headerView = UIView()
    
    lazy var backPageBtn = UIButton()
    lazy var nextPageBtn = UIButton()
    lazy var refreshBtn = UIButton()
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupBackPageBtn()
        setupRefreshBtn()
        setupNextPageBtn()
        setupWebView()
    }
    
    //MARK:- Button Actions
    
    @objc func backBtnTapped(_ sender: UIButton) {
        webView.goBack()
    }
    
    @objc func refreshBtnTapped(_ sender: UIButton) {
        webView.reload()
    }
    
    @objc func nextPageBtnTapped(_ sender: UIButton) {
        webView.goForward()
    }
    
    //MARK:- WebView
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityView.stopAnimating()
    }
    
    //MARK:- Private
    
    private func openURL() {
        let url = URL(string: Constants().stridesURL)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        setupActivityView()
        
        self.webView.addSubview(self.activityView)
        self.activityView.startAnimating()
        self.webView.navigationDelegate = self
        self.activityView.hidesWhenStopped = true
    }
    
    
    //MARK:- Constraints
    
    private func setupHeaderView() {
        self.view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        
        headerView.backgroundColor = UIColor(red: 0.50, green: 0.96, blue: 0.83, alpha: 1.00)
    }
    
    private func setupWebView() {
        self.view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        webView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        webView.navigationDelegate = self
        
        openURL()
    }
    
    private func setupBackPageBtn() {
        let imageIcon = UIImage(named: "ic_webBack")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        backPageBtn.setBackgroundImage(imageIcon, for: .normal)
        
        backPageBtn.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside)
        
        self.headerView.addSubview(backPageBtn)
        
        backPageBtn.translatesAutoresizingMaskIntoConstraints = false
        backPageBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15).isActive = true
        backPageBtn.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.2).isActive = true
        backPageBtn.widthAnchor.constraint(equalTo: backPageBtn.heightAnchor, multiplier: 0.7).isActive = true
        backPageBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    }
    
    private func setupRefreshBtn() {
        let imageIcon = UIImage(named: "ic_webRefresh")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        refreshBtn.setBackgroundImage(imageIcon, for: .normal)
        
        refreshBtn.addTarget(self, action: #selector(refreshBtnTapped(_:)), for: .touchUpInside)
        
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerView.addSubview(refreshBtn)
        
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        refreshBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15).isActive = true
        refreshBtn.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.2).isActive = true
        refreshBtn.widthAnchor.constraint(equalTo: refreshBtn.heightAnchor, multiplier: 1.1).isActive = true
        refreshBtn.leadingAnchor.constraint(equalTo: backPageBtn.trailingAnchor, constant: 40).isActive = true
    }
    
    private func setupNextPageBtn() {
        let imageIcon = UIImage(named: "ic_webForward")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        nextPageBtn.setBackgroundImage(imageIcon, for: .normal)
        
        nextPageBtn.addTarget(self, action: #selector(nextPageBtnTapped(_:)), for: .touchUpInside)
        
        self.headerView.addSubview(nextPageBtn)
        
        nextPageBtn.translatesAutoresizingMaskIntoConstraints = false
        
        nextPageBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15).isActive = true
        nextPageBtn.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.2).isActive = true
        nextPageBtn.widthAnchor.constraint(equalTo: nextPageBtn.heightAnchor, multiplier: 0.7).isActive = true
        nextPageBtn.leadingAnchor.constraint(equalTo: refreshBtn.trailingAnchor, constant: 40).isActive = true
    }

    private func setupActivityView() {
        self.view.addSubview(activityView)
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
