//
//  FirstViewController.swift
//  HanyangLib
//
//  Created by wijang's mac on 2017. 5. 3..
//  Copyright © 2017년 wooil. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var campusLabel: UILabel!
    @IBOutlet var libTitle: UILabel!
    var roomList : [Dictionary<String, String>] = []
    var libType = "0" //0 : 백남, 1 : 법학
    var isSeoul = true //서울캠, 에리카
    @IBOutlet var roomCollView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lib_type = UserDefaults.standard.object(forKey: "lib_type") as? String {
            if lib_type != "" {
                self.libType = lib_type
                
                //백남
                if(libType == "0"){
                    self.libTitle.text = "백남도서관 빈자리"
                } else if(libType == "1"){
                    //법학
                    self.libTitle.text = "법학도서관 빈자리"
                }
            }
        }
        
        if let is_seoul = UserDefaults.standard.object(forKey: "is_seoul") as? Bool {
            isSeoul = is_seoul
            if is_seoul == false {
                self.libTitle.text = "열람실 빈자리"
            }
        }
        
        getLibData()
    }
    
    func getLibData(){
        if(isSeoul){
            campusLabel.text = "서울"
            getSeoulData()
        } else {
            campusLabel.text = "에리카"
            
            getEricaData()
        }
    }
    
    func getSeoulData(){
        roomList = []
        
        let urlStr : String
        if libType == "0" {
            urlStr = "http://libgate.hanyang.ac.kr/seats/domian5.asp"
        } else {
            urlStr = "http://libgate.hanyang.ac.kr/seatl/domian5.asp"
        }
        
        if let url = URL(string: urlStr) {
            
            do {
                let rsltData = try Data.init(contentsOf: url)
                
                let encoding = CFStringConvertEncodingToNSStringEncoding(0x0422);
                
                if let html = String.init(data: rsltData, encoding: String.Encoding(rawValue: encoding)) {
                    if let doc = HTML(html: html, encoding: .utf8) {
                        let tableList = doc.css("table")
                        
                        var idx = 0
                        for tr in tableList[1].css("tr") {
                            if(idx > 2){
                                let tdList = tr.css("td")
                                let roomNm = tdList[1].css("font")[0].text?.trimmingCharacters(in: .whitespacesAndNewlines)
                                let linkURL = tdList[1].css("font")[0].css("a")[0]["href"]
                                let tot = tdList[2].css("font")[0].text?.trimmingCharacters(in: .whitespacesAndNewlines)
                                let left = tdList[4].css("font")[0].text?.trimmingCharacters(in: .whitespacesAndNewlines)
                                if tot != nil && left != nil && roomNm != nil && linkURL != nil {
                                    roomList.append(["name":roomNm!, "url":linkURL!, "left":left!, "tot":tot!])
                                }
                            }
                            idx += 1
                        }
                        roomCollView.reloadData()
                    }
                }
                
            } catch(let error){
                
            }
        }
    }
    
    //에리카 남은자리
    func getEricaData(){
        roomList = []
        
        let urlStr = "http://166.104.209.78/EZ5500/SEAT/RoomStatus.aspx"
        
        if let url = URL(string: urlStr) {
            
            do {
                let rsltData = try Data.init(contentsOf: url)
                
                let encoding = CFStringConvertEncodingToNSStringEncoding(0x0422);
                
                if let html = String.init(data: rsltData, encoding: String.Encoding(rawValue: encoding)) {
                    if let doc = HTML(html: html, encoding: .utf8) {
                        let tableList = doc.css("table")
                        
                        var idx = 0
                        for tr in tableList[1].css("tr") {
                            if(idx > 0){
                                let tdList = tr.css("td")
                                let roomNm = tdList[0].text?.trimmingCharacters(in: .whitespacesAndNewlines)
                                let linkURL = tr["onclick"]
                                let tot = tdList[1].text?.trimmingCharacters(in: .whitespacesAndNewlines)
                                let left = tdList[3].text?.trimmingCharacters(in: .whitespacesAndNewlines)
                                if tot != nil && left != nil && roomNm != nil && linkURL != nil {
                                    roomList.append(["name":roomNm!, "url":urlStr, "left":left!, "tot":tot!, "callback":linkURL!])
                                }
                            }
                            idx += 1
                        }
                        roomCollView.reloadData()
                    }
                }
                
            } catch(let error){
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RoomCollCell
        
        if(roomList.count > indexPath.row){
            let cellData = roomList[indexPath.row]
            
            if let leftStr = cellData["name"] {
                if(leftStr.components(separatedBy: " ").count > 1){
                    let comps = leftStr.components(separatedBy: " ")
                    cell.roomName.text = comps[0]
                    if(comps.count > 2 && comps[1] == ""){
                        cell.roomName2.text = comps[2]
                    } else {
                        cell.roomName2.text = comps[1]
                    }
                } else {
                    cell.roomName.text     = cellData["name"]
                }
            }
            
            cell.emptySeatCnt.text = cellData["left"]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: roomList[indexPath.row])
    }
    
    //새로고침
    @IBAction func refreshClicked(_ sender: Any) {
        getLibData()
    }
    
    //도서관 이름 클릭
    @IBAction func changeLibClicked(_ sender: Any) {
        if isSeoul {
            let appDel = UIApplication.shared.delegate as! AppDelegate
            _ = SelectionView(parentView: appDel.window!, text1: "백남학술정보관", text2: "법학학술정보관", btn1Clicked: {
                _ in
                //백남
                self.libTitle.text = "백남도서관 빈자리"
                self.libType = "0"
                self.getLibData()
                
                UserDefaults.standard.set(self.libType, forKey: "lib_type")
                UserDefaults.standard.synchronize()
            }, btn2Clicked: {
                _ in
                //법학
                self.libTitle.text = "법학도서관 빈자리"
                self.libType = "1"
                self.getLibData()
                
                UserDefaults.standard.set(self.libType, forKey: "lib_type")
                UserDefaults.standard.synchronize()
            })
        }
    }
    
    //캠퍼스 변경
    @IBAction func changeCampClicked(_ sender: Any) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        _ = SelectionView(parentView: appDel.window!, text1: "서울", text2: "ERICA", btn1Clicked: {
            _ in
            //서울
            if(self.isSeoul == false){
                self.isSeoul = true
                self.libTitle.text = "백남도서관 빈자리"
                self.libType = "0"
                self.getLibData()
                
                UserDefaults.standard.set(true, forKey: "is_seoul")
                UserDefaults.standard.synchronize()
            }
        }, btn2Clicked: {
            _ in
            //ERICA
            if(self.isSeoul == true){
                self.isSeoul = false
                self.libTitle.text = "열람실 빈자리"
                self.libType = "0"
                self.getLibData()
                
                UserDefaults.standard.set(false, forKey: "is_seoul")
                UserDefaults.standard.synchronize()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == "detail" {
            let vc = segue.destination as! DetailViewController
            vc.cellData = sender as! Dictionary<String, String>
        }
    }
}

class RoomTableviewCell: UITableViewCell {
    @IBOutlet var roomNm: UILabel!
    @IBOutlet var left: UILabel!
    @IBOutlet var total: UILabel!
    
}

class RoomCollCell: UICollectionViewCell {
    @IBOutlet var emptySeatCnt: UILabel!
    @IBOutlet var roomName: UILabel!
    @IBOutlet var roomName2: UILabel!
    
}
