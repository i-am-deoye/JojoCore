
import Foundation


public class SharedPreferenceCache: ICache {
    
    var preferences: UserDefaults = UserDefaults.standard
    
    public init() {
    }
    
    @discardableResult
    public func putValue(key: String, value: Any) -> ICache {
        preferences.set(value, forKey: key)
        preferences.synchronize()
        return self
    }
    
    @discardableResult
    public func putBoolean(key: String, value: Bool) -> ICache {
        preferences.set(value, forKey: key)
        preferences.synchronize()
        return self
    }
    
    @discardableResult
    public func putFloat(key: String, value: Float) -> ICache {
        preferences.set(value, forKey: key)
        preferences.synchronize()
        return self
    }
    
    @discardableResult
    public func putInteger(key: String, value: Int) -> ICache {
        preferences.set(value, forKey: key)
        preferences.synchronize()
        return self
    }
    
    @discardableResult
    public func putString(key: String, value: String) -> ICache {
        preferences.setValue(value, forKey: key)
        preferences.synchronize()
        return self
    }
    
    @discardableResult
    public func putSerialize(key: String, value: Any) -> ICache {
        preferences.setValue(value, forKey: key)
        preferences.synchronize()
        return self
    }
    

    
    public func getValue(key: String) -> Any? {
        return preferences.value(forKey: key)
    }
    
    public func getBoolean(key: String) -> Bool? {
        return preferences.bool(forKey: key)
    }
    
    public func getFloat(key: String) -> Float? {
        return preferences.float(forKey: key)
    }
    
    public func getInteger(key: String) -> Int? {
        return preferences.integer(forKey: key)
    }
    
    public func getString(key: String) -> String? {
        return preferences.string(forKey: key)
    }
    
    public func getSerialize(key: String) -> Any? {
        return preferences.object(forKey: key)
    }
    
    public func containsKey(key: String) -> Bool {
        let entries = self.entries()
        var contained : Bool = false
        entries.forEach { (result) in
            if result.key == key {
                contained = true
            }
        }
        return contained
    }
    
    public func remove(key: String) {
        preferences.removeObject(forKey: key)
        preferences.set(nil, forKey: key)
        preferences.setValue(nil, forKey: key)
        preferences.synchronize()
    }
    
    public func clear() {
        let entries = self.entries()
        entries.forEach { (result) in
            self.remove(key:result.key)
        }
    }
    
    public func clear(wizard: String) {
        let entries = self.entries()
        entries.forEach { (result) in
            self.remove(key: wizard + result.key)
        }
    }
    
    public func clear(wizards: [String]) {
        wizards.forEach { (wizard) in
            self.clear(wizard: wizard)
        }
    }
    
    public func clearAnyWizard() {
        let entries = self.entries()
        entries.forEach { (result) in
            if result.key.contains("wizard_") || result.key.contains("Wizard_") {
                self.remove(key: result.key)
            }
        }
    }
    
    public func entries() -> Dictionary<String, AnyObject> {
        return preferences.dictionaryRepresentation() as Dictionary<String, AnyObject>
    }
    
    public func keys() -> Set<String> {
        var keys: Set<String> = []
        let dict = entries()
        
        for key in dict.keys {
            keys.insert(key)
        }
        return keys
    }
    
    public func values() -> Array<AnyObject> {
        let dict = entries()
        var values: Array<AnyObject> = [dict.values.count as AnyObject]
        var i = 0
        for value in dict.values {
            values.insert(value, at: i)
            i += 1
        }
        return values
    }
    
}
