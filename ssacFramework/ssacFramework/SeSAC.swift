//
//  SeSAC.swift
//  ssacFramework
//
//  Created by 강호성 on 2021/12/23.
//

import Foundation
import UIKit

// MARK: - Open

open class SeSACOpen: UIViewController {
    
    open var name = "오픈 프레임워크"

    open func openfunction() {

    }
    
    public enum TransitionStyle {
        case present, push
    }
    
    public func presentWebViewController(url: String, transitionStyle: TransitionStyle, vc: UIViewController) {
        let webViewController = WebViewController()
        webViewController.url = url
        
        switch transitionStyle {
        case .present: vc.present(webViewController, animated: true, completion: nil)
        case .push: vc.navigationController?.pushViewController(webViewController, animated: true)
        }
    }
}


import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    
    var url = ""
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

// MARK: - Public

public class SeSACPublic: UIViewController {
    
    var name = "퍼블릭 프레임워크"

    func publicfunction() {

    }
}

// MARK: - Internal

internal class SeSACInternal: UIViewController {
    
}

// MARK: - Fileprivate

fileprivate class SeSACFilePrivate: UIViewController {
    
}

// MARK: - Private

private class SeSACPrivate: UIViewController {
    
}
