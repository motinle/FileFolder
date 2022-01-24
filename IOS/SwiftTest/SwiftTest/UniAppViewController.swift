//
//  UniAppViewController.swift
//  SwiftTest
//
//  Created by Motinle on 2022/1/24.
//

import Foundation

class UniAppViewController: UIViewController,DCUniMPSDKEngineDelegate {
    let APPID1 = "__UNI__ECB5EB5"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        DCUniMPSDKEngine.setDelegate(self)
        checkUniMPResoutce(appid: APPID1)
    }
    
    func checkUniMPResoutce(appid: String) -> Void {
        let wgtPath = Bundle.main.path(forResource: appid, ofType: "wgt") ?? ""
        if DCUniMPSDKEngine.isExistsUniMP(appid) {
            let version = DCUniMPSDKEngine.getUniMPVersionInfo(withAppid: appid)!
            let name = version["code"]!
            let code = version["code"]!
            print("小程序：\(appid) 资源已存在，版本信息：name:\(name) code:\(code)")
            
            DCUniMPSDKEngine.openUniMP(APPID1, configuration: DCUniMPConfiguration.init()) { instance, error in
                if instance != nil {
                    print("小程序打开成功")
                } else {
                    print(error as Any)
                }
            }
        } else {
            do {
                try DCUniMPSDKEngine.installUniMPResource(withAppid: appid, resourceFilePath: wgtPath, password: nil)
                let version = DCUniMPSDKEngine.getUniMPVersionInfo(withAppid: appid)!
                let name = version["code"]!
                let code = version["code"]!
                print("✅ 小程序：\(appid) 资源释放成功，版本信息：name:\(name) code:\(code)")
            } catch let err as NSError {
                print("❌ 小程序：\(appid) 资源释放失败:\(err)")
            }
        }
    }

}
