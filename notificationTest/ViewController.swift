//
//  ViewController.swift
//  notificationTest
//
//  Created by Tomoyuki Hayakawa on 2019/04/19.
//  Copyright © 2019 Tomoyuki Hayakawa. All rights reserved.
//

import UIKit
import UserNotifications

// アクションをenumで宣言
enum ActionIdentifier: String {
    case actionOne
    case actionTwo
}

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var one: Int = 0
    var two: Int = 0
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        // アクション設定
        let actionOne = UNNotificationAction(identifier: ActionIdentifier.actionOne.rawValue,
                                            title: "アクション1",
                                            options: [.foreground])
        let actionTwo = UNNotificationAction(identifier: ActionIdentifier.actionTwo.rawValue,
                                            title: "アクション2",
                                            options: [.foreground])
        
        let category = UNNotificationCategory(identifier: "category_select",
                                              actions: [actionOne, actionTwo],
                                              intentIdentifiers: [],
                                              options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().delegate = self
        
        
        let content = UNMutableNotificationContent()
        content.title = "こんにちわ！"
        content.body = "アクションを選択してください！"
        content.sound = UNNotificationSound.default
        
        // categoryIdentifierを設定
        content.categoryIdentifier = "category_select"
        
        // 60秒ごとに繰り返し通知
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "notification",
                                            content: content,
                                            trigger: trigger)
        
        // 通知登録
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: () -> Swift.Void) {
        
        switch response.actionIdentifier {
        
        case ActionIdentifier.actionOne.rawValue:
            
            one = one + 1
            label1.text = String(one)
            
        case ActionIdentifier.actionTwo.rawValue:
           
            two = two + 1
            label2.text = String(two)
            
        default:
            ()
        }
        
        completionHandler()
    }


}

