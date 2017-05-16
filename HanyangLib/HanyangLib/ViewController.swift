//
//  ViewController.swift
//  HanyangLib
//
//  Created by wijang's mac on 2017. 4. 28..
//  Copyright © 2017년 wooil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainScroll: UIScrollView!
    @IBOutlet var areaNm: UILabel!
    @IBOutlet var emptyCnt: UILabel!
    
    private var i1 = 0
    private var j1 = 0
    private var elementWidth = 30 //박스 가로 길이
    private var elementHeight = 30 //박스 가로 길이
    private var elementCnt : [Int] = [] //행별 칸 수
    private var currentRowNum = 0 //현재 계산되고 있는 행 번호
    private var currentJ = 0 //현재 보여지고 있는 열 번호
    private var addNumber = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyCnt.text = "0/0(남은자리/전체자리)"
        
//        draw2leftRoom()
        draw3Room()
    }
    
    //제2열람실좌 그리기
    func draw2leftRoom(){
        areaNm.text = "제2열람실좌 (지하1층)"
        
        i1 = 16
        j1 = 20
        elementCnt = [11, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14, 15, 15] //열별 칸 수
        
        mainScroll.contentSize = CGSize.init(width: elementWidth * j1, height: elementHeight * i1)
        
        var number = 1
        currentJ = 0
        
        for j in 0..<j1 {
            if [2, 5, 8, 11, 14, 17].index(of: j) != nil {
                continue
            }
            currentRowNum = 0
            
            for i in 0..<i1 {
                if [10].index(of: i) != nil {
                    continue
                }
                
                if i == 0 {
                    if j < 14 {
                        continue
                    }
                } else if i == 1 || i == 2 {
                    if j < 6 {
                        continue
                    }
                } else if i == 3 {
                    if j < 3 {
                        continue
                    }
                } else if i == 4 {
                    if j == 6 || j == 7 || j == 15 || j == 16 {
                        continue
                    }
                }
                
                let elementFrame = CGRect.init(x: elementWidth*j, y: i*elementHeight, width: elementWidth, height: elementHeight)
                
                if currentRowNum == 0 {
                    if(currentJ % 2 == 0){ //위 -> 아래
                        addNumber = 1
                        //현재 번호 찾기
                        if currentRowNum != 0 {
                            var sum = 0
                            for sub_i in 0..<currentJ {
                                sum += elementCnt[sub_i]
                            }
                            sum += 1
                            number = sum
                        }
                    } else { //아래 <- 위
                        addNumber = -1
                        number = number + elementCnt[currentJ]
                        number -= 1
                    }
                }
                
                let boxView = BoxView(frame: elementFrame)
                boxView.label.text = "\(number)"
                mainScroll.addSubview(boxView)
                
                number += addNumber
                currentRowNum += 1
            }
            currentJ += 1
        }
    }
    
    //제3열람실 그리기
    func draw3Room(){
        areaNm.text = "제3열람실 (3층)"
        
        i1 = 25
        j1 = 29
        elementCnt = [8, 24, 24, 24, 25, 22, 22, 24, 25, 25, 25, 19, 20, 22, 22, 11, 12] //행별 칸 수
        
        mainScroll.contentSize = CGSize.init(width: elementWidth * j1, height: elementHeight * i1)
        
        var number = 1
        for i in 0..<i1 {
            if [1, 4, 7, 10, 13, 16, 19, 22].index(of: i) != nil {
                continue
            }
            for j in 0..<j1 {
                if i == 0 {
                    if [5, 7, 9, 11, 17, 19, 21, 23].index(of: j) == nil {
                        continue
                    }
                } else if(i == 8 || i == 9){
                    if j == 0 || j == 10 || j == 18 {
                        continue
                    }
                } else if(i == 17 || i == 18){
                    if j < 3 || j == 10 || j == 18  {
                        continue
                    }
                } else if(i == 20 || i == 21){
                    if j < 3 {
                        continue
                    }
                } else if(i == 23 || i == 24){
                    if j < 15 {
                        continue
                    }
                }
                
                if(j==28){
                    if(i<6 || i == 11 || i == 17 || i == 23){
                        continue
                    }
                }
                
                if j == 6 || j == 14 || j == 22 || j == 27 {
                    continue
                }
                
                number = addBoxView(i: i, j: j, number: number)
                
                number += addNumber
                currentJ += 1
            }
            currentJ = 0
            
            currentRowNum += 1
        }
    }
    
    //제4열람실 그리기
    func draw4Room(){
        areaNm.text = "제4열람실 (3층)"
        
        i1 = 25
        j1 = 29
        elementCnt = [8, 24, 24, 24, 25, 22, 22, 24, 25, 25, 25, 19, 20, 22, 22, 11, 12] //행별 칸 수
        
        mainScroll.contentSize = CGSize.init(width: elementWidth * j1, height: elementHeight * i1)
        
        var number = 1
        for i in 0..<i1 {
            if [1, 4, 7, 10, 13, 16, 19, 22].index(of: i) != nil {
                continue
            }
            for j in 0..<j1 {
                if i == 0 {
                    if [5, 7, 9, 11, 17, 19, 21, 23].index(of: j) == nil {
                        continue
                    }
                } else if(i == 8 || i == 9){
                    if j == 7 || j == 18 || j == 28 {
                        continue
                    }
                } else if(i == 17 || i == 18){
                    if j == 10 || j == 18 || j == 26 || j == 27 || j == 28 {
                        continue
                    }
                } else if(i == 20 || i == 21){
                    if j == 26 || j == 27 || j == 28 {
                        continue
                    }
                } else if(i == 23 || i == 24){
                    if j > 13 {
                        continue
                    }
                }
                
                if j == 1 || j == 6 || j == 14 || j == 22 {
                    continue
                } else if j == 0 {
                    //첫줄 안나오는 것들
                    if [6, 8, 9, 12, 14, 15, 18, 20, 21, 24].index(of: i) == nil{
                        continue
                    }
                }
                
                number = addBoxView(i: i, j: j, number: number)
                
                number += addNumber
                currentJ += 1
            }
            currentJ = 0
            
            currentRowNum += 1
        }
    }
    
    func addBoxView(i: Int, j: Int, number numberIn : Int) -> Int{
        let elementFrame = CGRect.init(x: elementWidth*j, y: i*elementHeight, width: elementWidth, height: elementHeight)
        
        var number = numberIn
        
        if currentJ == 0 {
            if(currentRowNum % 2 == 0){ //왼쪽 -> 오른쪽
                addNumber = 1
                //현재 번호 찾기
                if currentRowNum != 0 {
                    var sum = 0
                    for i in 0..<currentRowNum {
                        sum += elementCnt[i]
                    }
                    sum += 1
                    number = sum
                }
            } else { //왼쪽 <- 오른쪽
                addNumber = -1
                number = number + elementCnt[currentRowNum]
                number -= 1
            }
        }
        
        let boxView = BoxView(frame: elementFrame)
        boxView.label.text = "\(number)"
        mainScroll.addSubview(boxView)
        
        return number
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class BoxLabelView:  UIView{
    @IBOutlet var label: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

class SelectedLabelView:  UIView{
    @IBOutlet var label: UILabel!
}
