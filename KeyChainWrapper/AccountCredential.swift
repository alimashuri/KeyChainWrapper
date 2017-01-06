//
//  AccountCredential.swift
//  KeyChainWrapper
//
//  Created by Ali Mashuri on 1/6/17.
//  Copyright © 2017 Ali Mashuri. All rights reserved.
//

import Foundation

open class AccountCredential  {
    
    /// Supply an optional Keychain access group to access shared Keychain items.
    open var accessGroup: String?;
    let itemKey = Bundle.main.bundleIdentifier
    
    /**
     
     Adds the text value in the keychain.
     
     - parameter itemKey: Key under which the text value is stored in the keychain.
     - parameter itemValue: Text string to be written to the keychain.
     - returns: True if the text was successfully written to the keychain.
     
     */
    
    @discardableResult
    public func storeAccount(_ account:AnyObject) -> Bool {
        /*
         guard let valueData = NSKeyedArchiver.archivedData(withRootObject: account) as? Data else {
         return false
         }
         */
        
        let valueData = NSKeyedArchiver.archivedData(withRootObject: account)
        
        // Delete the item before adding, otherwise there will be multiple items with the same name
        delete()
        
        let queryAdd: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecValueData as String: valueData as AnyObject,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        /*
        if let accessGroup = accessGroup {
            queryAdd[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        } */
        
        let resultCode = SecItemAdd(queryAdd as CFDictionary, nil)
        
        if resultCode != noErr {
            print("err \(resultCode.description)")
            return false
        }
        
        return true
        
    }
    
    /**
     
     Returns a text item from the Keychain.
     
     - parameter itemKey: The key that is used to read the keychain item.
     - returns: The text value from the keychain. Returns nil if unable to read the item.
     
     */
    
    open func retrieve() -> AnyObject? {
        let itemKey = Bundle.main.bundleIdentifier
        let queryLoad: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        /*
        if let accessGroup = accessGroup {
            queryLoad[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }*/
        
        var result: AnyObject?
        
        let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if resultCodeLoad == noErr {
            if let result = result as? Data,
                let keyValue = NSKeyedUnarchiver.unarchiveObject(with: result) {
                return keyValue as AnyObject?
            }
        }
        
        return nil
    }
    
    /**
     
     Deletes the single keychain item specified by the key.
     
     - parameter itemKey: The key that is used to delete the keychain item.
     - returns: True if the item was successfully deleted.
     
     */
    @discardableResult
    open func delete() -> Bool {
        let itemKey = Bundle.main.bundleIdentifier
        let queryDelete: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject
        ]
        
        /*
        if let accessGroup = accessGroup {
            queryDelete[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        */
        let resultCodeDelete = SecItemDelete(queryDelete as CFDictionary)
        
        if resultCodeDelete != noErr { return false }
        
        return true
    }
    
    
    @discardableResult
    open func isStored() -> Bool {
        if self.retrieve() != nil {
            return true
        }
        return false
    }
}
