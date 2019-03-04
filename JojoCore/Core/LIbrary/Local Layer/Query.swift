import Foundation
public class Query{
    
    private var _query:String = ""
    
    public init(){}
    
    public convenience init(query: String = ""){
        self.init()
        self._query = query
    }
    
    open func toString() -> String{
        return _query
    }
    
    private func formatValue(_ value: Any) -> String {
        return "\((value is String) ?  "'\(value)'" : "\(value)")"
    }
    
    open func isNil(key:String) -> Query{
        _query = _query + "\(key) == ''"
        return self
    }
    
    open func isNotNil(key:String) -> Query{
        _query = _query + "\(key) != ''"
        return self
    }
    
    open func isNotBetween(key:String, leftValue:Any, rightValue:Any) -> Query {
        return not(isBetween(key: key, leftValue: leftValue, rightValue: rightValue))
    }
    
    open func isBetween(key:String, leftValue:Any, rightValue:Any) -> Query{
        _query = _query + " \(key) BETWEEN \(leftValue) AND \(rightValue)"
        return self
    }
    
    open func isNotIn(key:String, values:[Any]) -> Query{
        return not(isIn(key: key, values: values))
    }
    
    open func isIn(key:String, values:[Any]) -> Query{
        var temp = ""
        values.forEach { (val) in
            temp = temp +  (temp.isEmpty ? "" : ",")  + "'\(val)'"
        }
        _query = _query + " \(key) IN {\(temp)}"
        return self
    }
    
    open func notEqual(key:String, value:Any) -> Query{
        //  let query = Query(query: "\(key) == \((value is String) ?  "'\(value)'" : "\(value)")")
        
        return not(equal(key: key, value: value))
    }
    
    open func equal(key:String, value:Any) -> Query{
        _query = _query + "\(key) == \(formatValue(value))"
        return self
    }
    
    open func beginsWith(key:String, value:Any) -> Query{
        _query = _query + " \(key) BEGINSWITH \(formatValue(value))"
        return self
    }
    
    open func endsWith(key:String, value:Any) -> Query{
        _query = _query + " \(key) ENDSWITH \(formatValue(value))"
        return self
    }
    
    open func notBeginsWith(key:String, value:Any) -> Query{
        return not(beginsWith(key: key, value: value))
    }
    
    open func notEndsWith(key:String, value:Any) -> Query{
        return not(endsWith(key: key, value: value))
    }
    
    open func notContains(key:String, value:Any) -> Query{
        return not(contains(key: key, value: value))
    }
    
    open func contains(key:String, value:Any) -> Query{
        _query = _query + " \(key) CONTAINS \(formatValue(value))"
        return self
    }
    
    open func notLike(key:String, value:Any) -> Query{
        return not(like(key: key, value: value))
    }
    
    open func like(key:String, value:Any) -> Query{
        _query = _query + " \(key) LIKE \(formatValue(value))"
        return self
    }
    
    open func any(_ operand:Query) -> Query {
        _query = _query + " ANY (\(operand.toString()))"
        return self
    }
    
    open func greaterThan(key:String, value:Any) -> Query{
        _query = _query + " \(key) > \(formatValue(value))"
        return self
    }
    
    open func lessThan(key:String, value:Any) -> Query{
        _query = _query + " \(key) < \(formatValue(value))"
        return self
    }
    
    open func greaterThanOrEqual(key:String, value:Any) -> Query{
        _query = _query + " \(key) >= \(formatValue(value))"
        return self
    }
    
    open func lessThanOrEqual(key:String, value:Any) -> Query{
        _query = _query + " \(key) <= \(formatValue(value))"
        return self
    }
    
    open func notGreaterThan(key:String, value:Any) -> Query{
        return not(greaterThan(key: key, value: value))
    }
    
    open func notLessThan(key:String, value:Any) -> Query{
        return not(lessThan(key: key, value: value))
    }
    
    open func notGreaterThanOrEqual(key:String, value:Any) -> Query{
        return not(greaterThanOrEqual(key: key, value: value))
    }
    
    open func notLessThanOrEqual(key:String, value:Any) -> Query{
        return not(lessThanOrEqual(key: key, value: value))
    }
    
    open func not(_ operand: Query) -> Query {
        _query = _query + " NOT (\(operand.toString()))"
        return self
    }
    
    open func or() -> Query{
        _query = _query + " OR "
        return self
    }
    
    open func and() -> Query{
        _query = _query + " AND "
        return self
    }
    
    fileprivate func or(left:Query, right: Query) -> Query{
        _query = _query + " \(left.toString()) OR \(right.toString())"
        return self
    }
    
    fileprivate func and(left:Query, right:Query) -> Query{
        _query = _query + " \(left.toString()) AND \(right.toString())"
        return self
    }
}
