//
//  Circle.swift
//  SwiftTest
//
//  Created by Motinle on 2021/7/11.
//
import UIKit

class CircleView: UIView {

    let circleLayer: CAShapeLayer = {
        // 形状图层，初始化与属性配置
        let circle = CAShapeLayer()
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.red.cgColor
        circle.lineWidth = 5.0
        circle.strokeEnd = 0.0
        return circle
    }()
    // 视图创建，通过指定 frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
   // 视图创建，通过指定 storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup(){
        backgroundColor = UIColor.clear

        // 添加上，要动画的图层
        layer.addSublayer(circleLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 考虑到视图的布局，如通过 auto layout,
        // 需动画图层的布局，放在这里
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)

        circleLayer.path = circlePath.cgPath
    }

    // 动画的方法
    func animateCircle(duration t: TimeInterval) {
        // 画圆形，就是靠 `strokeEnd`
        let animation = CABasicAnimation(keyPath: "strokeEnd")

        // 指定动画时长
        animation.duration = t

        // 动画是，从没圆，到满圆
        animation.fromValue = 0
        animation.toValue = 1

        // 指定动画的时间函数，保持匀速
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        // 视图具体的位置，与动画结束的效果一致
        circleLayer.strokeEnd = 1.0

        // 开始动画
        circleLayer.add(animation, forKey: "animateCircle")
    }
}

