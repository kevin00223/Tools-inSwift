//
//  UIButton.swift
//  KNData
//
//  Created by 李凯 on 2019/7/17.
//

import Foundation

extension UIButton {
    
    /// GCD设置倒计时功能
    func start(with seconds: Int, countDownTitle: String, countDownTitleColor: UIColor, endedTitle: String, endedTitleColor: UIColor, completion: @escaping(_ countdownEnded: Bool) -> ()) {
        
        var total = seconds
        // 初始化timer
        let gcdTimer = DispatchSource.makeTimerSource()
        
        gcdTimer.schedule(wallDeadline: DispatchWallTime.now(), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.seconds(0))
        // 开启计时器后需要执行的操作
        gcdTimer.setEventHandler(handler: { [weak self] in
            if total <= 0 {
                gcdTimer.cancel()
                DispatchQueue.main.sync {
                    self!.setTitle(endedTitle, for: .normal)
                    self!.setTitleColor(endedTitleColor, for: .normal)
                    self!.isUserInteractionEnabled = true
                }
                
            } else {
                DispatchQueue.main.async {
                    self!.setTitle("\(total)\(countDownTitle)", for: .normal)
                    self!.setTitleColor(countDownTitleColor, for: .normal)
                    self!.isUserInteractionEnabled = false
                    // 将true回调给外界, 用来设置'倒计时结束'属性的值 (倒计时结束以后 才可以执行重置倒计时按钮+重新发送验证码等操作)
                    completion(true)
                    total -= 1
                }
            }
        })
        // 开启timer
        gcdTimer.resume()
    }
    
}
