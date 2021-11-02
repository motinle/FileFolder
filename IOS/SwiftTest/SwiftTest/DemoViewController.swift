//
//  DemoViewController.swift
//  SwiftTest
//
//  Created by Motinle on 2021/7/7.
//

import UIKit
import AVFoundation;
class DongZuo :NSObject {
    var type:Int? = 0
    var score:Int? = 0
    var name:String? = nil
    
    public init(type: Int?, score:Int?,name:String?) {
        self.type = type;
        self.score = score;
        self.name = name;
    }
}


class DemoViewController: UIViewController {
    var someDict:[Float:DongZuo]? = nil// [1:"One", 2:"Two", 3:"Three"]
    var player:AVAudioPlayer? = nil
    var rectView:UIView = UIView.init()
    let screenW:CGFloat = UIScreen.main.bounds.width;
    let screenH:CGFloat = UIScreen.main.bounds.height;
    var imageView:UIImageView = UIImageView.init();
    var timer:Timer = Timer.init();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let d1 = DongZuo.init(type: 1, score: 10, name: "One")
        let d2 = DongZuo.init(type: 2, score: 10, name: "Two")
        let d3 = DongZuo.init(type: 3, score: 10, name: "Three")
        let d4 = DongZuo.init(type: 3, score: 10, name: "Four")
        
        someDict = [
//            0.5:d1,
                    1.0:d2,
                    2.0:d4,
                    3.0:d3,
//                    3.5:d3,
//                    3.7:d1,
                    4.0:d4,
//                    4.5:d3,
                    5.0:d1,
//                    5.2:d3,
                    6.0:d2,
//                    5.8:d3,
//                    6.8:d4,
                    7.0:d3,
//                    7.7:d4,
                    8.0:d4,
//                    8.9:d4,
//                    9.1:d1,
                    9.0:d4,
//                    10.0:d1,
//                    10.6:d3,
//                    10.8:d1,
                    10.0:d3,
//                    11.2:d1,
                    11.0:d1,
        ]
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
        let name = "CoderHG"+" heelo"
        print(name)
        
        
        var name2 = "2"; name2 = "3"
        print(name2)
        
        var hg = HGStruct(name: "kwg")
        hg.name = "333"
        hg.desFunc()
        self.direction(d: HGEnum.go)
        
        rectView.frame = self.view.bounds
        rectView.layer.borderWidth = 10
        rectView.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(rectView)
        rectView.alpha = 1
        
        let btn = UIButton.init(frame: CGRect.init(x: (screenW-100)/2-70,
                                                   y: screenH-50-40,
                                                   width: 100,
                                                   height: 50))
        btn.setTitle("Start", for: UIControl.State.normal)
        self.view .addSubview(btn)
        btn.addTarget(self, action: #selector(startAction), for: UIControl.Event.touchUpInside)
        btn.backgroundColor = UIColor.gray
        
        let stopBtn = UIButton.init(frame: CGRect.init(x: (screenW-100)/2+70,
                                                   y: screenH-50-40,
                                                   width: 100,
                                                   height: 50))
        stopBtn.setTitle("Stop", for: UIControl.State.normal)
        self.view.addSubview(stopBtn)
        stopBtn.addTarget(self, action: #selector(stopAction), for: UIControl.Event.touchUpInside)
        stopBtn.backgroundColor = UIColor.gray
        
        
        self.imageView.frame = CGRect.init(x: (screenW-200)/2,
                                           y: 100,
                                       width: 200,
                                       height: 300)
        self.imageView.backgroundColor = UIColor.red
        self.view.addSubview(self.imageView)
        
        
    }
    func drawlind() {
        
        let oldView = self.view.viewWithTag(100)
        if (oldView != nil) {
            oldView?.removeFromSuperview()
        }
        
        let circleEdge = CGFloat(30)
        // 直接指定 frame 布局
        let circleView = CircleView(frame: CGRect(x: 50, y: 50, width: circleEdge, height: circleEdge))
        circleView.tag = 100;
        view.addSubview(circleView)
        // 开始动画
        circleView.animateCircle(duration: 1.0)
                
    }
    
    @objc func startAction() -> Void {
//        self.showState(state: true)
        self.playAlarmVoiceAction()
    }
    @objc func stopAction() -> Void {
        player?.stop();
        timer.invalidate();
    }
    
    func direction(d:HGEnum) -> Void {
        switch d {
        case .go:
            print("go")
        case .back:
            print("back")
            
        }
    }
    func playAlarmVoiceAction() {
        
        do{
            let path = Bundle.main.path(forResource: "2", ofType: "mp3")
            let soudUrl = URL(fileURLWithPath: path!)
            player =  try AVAudioPlayer.init(contentsOf: soudUrl)
//            player?.delegate = self
            player?.prepareToPlay()
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player?.play()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(playing), userInfo: nil, repeats: true);
            timer.fire()
        } catch{
            print(error)
        }
       
    }
    @objc func playing() -> Void {
        let currentTime = player?.currentTime;

        let s = String(format:"%.1lf",currentTime!)
        let val3 = Float(s)!;
        let exist = someDict?.keys.contains(val3);
        if (exist!) {
            let dz:DongZuo = someDict?[val3] ?? DongZuo.init(type: 0, score: 0, name: "")
            let name:String = dz.name!+".jpg"
            self.imageView.image = UIImage.init(named: name)
            print(s,dz.name!)
            self.drawlind()
        }
        
        
    }
    
    func showState(state:Bool) -> Void {
        rectView.alpha = 0
        rectView.layer.borderColor = UIColor.red.cgColor
        if state {
            rectView.layer.borderColor = UIColor.green.cgColor
            rectView.alpha = 1
        }
        UIView.animate(withDuration: 0.2) {
            self.rectView.alpha = abs(self.rectView.alpha-1)
        } completion: { (finish) in
            UIView.animate(withDuration: 0.2) {
                self.rectView.alpha = abs(self.rectView.alpha-1)
            } completion: { (finish) in
                UIView.animate(withDuration: 0.2) {
                    self.rectView.alpha = abs(self.rectView.alpha-1)
                } completion: { (finish) in
                    UIView.animate(withDuration: 0.2) {
                        self.rectView.alpha = abs(self.rectView.alpha-1)
                    } completion: { (finish) in
                        UIView.animate(withDuration: 0.2) {
                            self.rectView.alpha = abs(self.rectView.alpha-1)
                        } completion: { (finish) in
                            UIView.animate(withDuration: 0.2) {
                                self.rectView.alpha = abs(self.rectView.alpha-1)
                            } completion: { (finish) in
                                UIView.animate(withDuration: 0.2) {
                                    self.rectView.alpha = 1;
                                    self.rectView.layer.borderColor = UIColor.gray.cgColor
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



// 枚举定义
enum HGEnum {
    case go
    case back
    
}

// 定义一个结构体
struct HGStruct {
    var name:String?
    var des:String?
    init(name:String?,des1:String?="xxx") {
        self.name = name;
        self.des = des1
    }
    func desFunc() -> Void {
        print(name! + "_" + des!)
    }
}
