//
//  ViewController.swift
//  demo_keychain
//
//  Created by TranHoangThanh on 12/3/21.
//

import UIKit
import Security

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    //test()
    //testPassword()
     //   getItems()
//        updateKeychain()
       deleteItem()
//        testCopyMatching()
      //  testCopyMatchingArray()
      
        // Do any additional setup after loading the view.
    }

    
    func test() {
        //To add items to the keychain, you use the SecItemAdd function
        //Hạng mục, được chỉ định bằng kSecClasskhóa.
        //Dữ liệu thực tế bạn muốn giữ, cho dù đó là mật khẩu hay bất kỳ thứ gì khác. Điều này nên được lưu trữ dưới dạng Data(hoặc nếu bạn thích, CFData). Điều quan trọng là kSecValueData.
        let keychainItem = [
          kSecValueData: "Pullip2020".data(using: .utf8)!,
          kSecAttrAccount: "andyibanez",
          kSecAttrServer: "pullipstyle.com",
          kSecClass: kSecClassInternetPassword,
          kSecReturnAttributes: true
        ] as CFDictionary

        var ref: AnyObject?

        let status = SecItemAdd(keychainItem, &ref)
        print("Operation finished with status: \(status)")
        
        let result = ref as! NSDictionary
        print("Operation finished with status: \(status)")
        print("Returned attributes:")
        result.forEach { key, value in
          print("\(key): \(value)")
        }
    }
    
    func testPassword() {
        let keychainItem = [
          kSecValueData: "Pullip20201".data(using: .utf8)!,
          kSecAttrAccount: "andyibanez1",
          kSecAttrServer: "pullipstyle.com1",
          kSecClass: kSecClassInternetPassword,
          kSecReturnData: true,
          kSecReturnAttributes: true
        ] as CFDictionary

        var ref: AnyObject?

        let status = SecItemAdd(keychainItem, &ref)
        let result = ref as! NSDictionary
        print("Operation finished with status: \(status)")
        print("Username: \(result[kSecAttrAccount] ?? "")")
        let passwordData = result[kSecValueData] as! Data
        let passwordString = String(data: passwordData, encoding: .utf8)
        print("Password: \(passwordString ?? "")")
    }
    
    func getItems() {
        let usernames = ["andyibanez", "alice", "eileen", "blackberry"]

        usernames.forEach { username in
          let keychainItem = [
            kSecValueData: "\(username)-Pullip2020".data(using: .utf8)!,
            kSecAttrAccount: username,
            kSecAttrServer: "pullipstyle.com12",
            kSecClass: kSecClassInternetPassword,
            kSecReturnData: true,
            kSecReturnAttributes: true
          ] as CFDictionary
          
          var ref: AnyObject?
          
          let status = SecItemAdd(keychainItem, &ref)
          let result = ref as! NSDictionary
          print("Operation finished with status: \(status)")
          print("Username: \(result[kSecAttrAccount] ?? "")")
          let passwordData = result[kSecValueData] as! Data
          let passwordString = String(data: passwordData, encoding: .utf8)
          print("Password: \(passwordString ?? "")")
        }
    }
    
    
    
    func testCopyMatching() {
        let query = [
          kSecClass: kSecClassInternetPassword,
          kSecAttrServer: "pullipstyle.com",
          kSecReturnAttributes: true,
          kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        print("Operation finished with status: \(status)")
        let dic = result as! NSDictionary

        let username = dic[kSecAttrAccount] ?? ""
        let passwordData = dic[kSecValueData] as! Data
        let password = String(data: passwordData, encoding: .utf8)!
        print("Username: \(username)")
        print("Password: \(password)")
    }

    
    func testCopyMatchingArray() {
        let query = [
          kSecClass: kSecClassInternetPassword,
          kSecAttrServer: "pullipstyle.com12",
          kSecReturnAttributes: true,
          kSecReturnData: true,
          kSecMatchLimit: 2
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        print("Operation finished with status: \(status)")
        let array = result as! [NSDictionary]

        array.forEach { dic in
          let username = dic[kSecAttrAccount] ?? ""
          let passwordData = dic[kSecValueData] as! Data
          let password = String(data: passwordData, encoding: .utf8)!
          print("Username: \(username)")
          print("Password: \(password)")
        }
    }
    
    func updateKeychain() {
        let query = [
          kSecClass: kSecClassInternetPassword,
          kSecAttrServer: "pullipstyle.com",
        ] as CFDictionary

        let updateFields = [
            kSecAttrAccount: "tranthanh",
          kSecValueData: "newPassword".data(using: .utf8)!
        ] as CFDictionary

        let status = SecItemUpdate(query, updateFields)
        print("Operation finished with status: \(status)")
    }
    
    
    func deleteItem() {
        let query = [
          kSecClass: kSecClassInternetPassword,
          kSecAttrServer: "pullipstyle.com",
         // kSecAttrAccount: "andyibanez.com"
        ] as CFDictionary

        let status = SecItemDelete(query)
        print("Operation finished with status: \(status)")
        
    }
}

