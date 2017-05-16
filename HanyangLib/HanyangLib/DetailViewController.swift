//
//  DetailViewController.swift
//  HanyangLib
//
//  Created by wijang's mac on 2017. 5. 3..
//  Copyright © 2017년 wooil. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webview: UIWebView!
    @IBOutlet var left: UILabel!
    @IBOutlet var total: UILabel!
    
    var cellData : Dictionary<String, String>?
    var positionSet = false
    var javascriptCall = ""
    var isSeoul = true
    var javascriptCalled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if cellData != nil {
            var fullURL = "http://libgate.hanyang.ac.kr/seats/"+cellData!["url"]!
            //에리카(자바스크립트)
            if cellData!["callback"] != nil {
                javascriptCall = cellData!["callback"]!
                fullURL = cellData!["url"]!
                isSeoul = false
            }
            
            if let url = URL.init(string: fullURL) {
                webview.loadRequest(URLRequest.init(url: url))
                webview.delegate = self
                webview.scrollView.bounces = false
            }
            left.text = cellData!["left"]
            total.text = cellData!["tot"]
            
            self.title = cellData!["name"]
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if(positionSet == false) {
            if isSeoul == true {
                webview.scrollView.contentOffset = CGPoint.init(x: 300, y: 290)
                positionSet = true
            } else {
                if javascriptCalled {
                    webview.scrollView.contentOffset = CGPoint.init(x: 0, y: 300)
                    positionSet = true
                }
            }
            
            if positionSet == false {
                if(javascriptCall != ""){
                    webView.stringByEvaluatingJavaScript(from: javascriptCall)
                    javascriptCalled = true
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
