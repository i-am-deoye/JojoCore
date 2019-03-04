import Foundation

public typealias Serializable = NSDictionary
public protocol ICache {
    
    func putBoolean(key: String, value: Bool) -> ICache;
    func putInteger(key: String, value: Int) -> ICache;
    func putFloat(key: String, value: Float) -> ICache;
    func putString(key: String, value: String) -> ICache;
    func getBoolean(key: String) -> Bool?;
    func getInteger(key: String) -> Int?;
    func getFloat(key: String) -> Float?;
    func getString(key: String) -> String?;
    func containsKey(key: String) -> Bool;
    func clear();
    func remove(key: String);
    func entries() -> Dictionary<String, AnyObject>;
    func keys() -> Set<String>;
    func values() -> Array<AnyObject>;
}
