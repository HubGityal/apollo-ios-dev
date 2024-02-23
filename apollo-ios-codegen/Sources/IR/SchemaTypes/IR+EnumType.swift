import Foundation
import GraphQLCompiler

@dynamicMemberLookup
public final class EnumType: NamedType {
  public let graphqlEnumType: GraphQLEnumType
  
  public private(set) var values: [EnumValue]
  
  public init(_ graphqlEnumType: GraphQLEnumType) {
    self.graphqlEnumType = graphqlEnumType
    
    self.values = []
    for val in graphqlEnumType.values {
      self.values.append(EnumValue(graphqlEnumValue: val))
    }
    
    super.init(
      graphqlEnumType,
      typenameSuffix: "_Enum"
    )
  }
  
  // MARK: - Dyanmic Member Lookup
  
  public subscript<T>(dynamicMember keyPath: KeyPath<GraphQLEnumType, T>) -> T {
    graphqlEnumType[keyPath: keyPath]
  }
  
}

// MARK: - Enum Case

@dynamicMemberLookup
public final class EnumValue: NamedItem {
  public let graphqlEnumValue: GraphQLEnumValue
  
  private var _name: Name
  public var name: Name {
    _name
  }
  
  public init(graphqlEnumValue: GraphQLEnumValue) {
    self.graphqlEnumValue = graphqlEnumValue
    self._name = Name(schemaName: graphqlEnumValue.name.value)
  }
  
  // MARK: - Dynamic Member Lookup
  
  public subscript<T>(dynamicMember keyPath: KeyPath<GraphQLEnumValue, T>) -> T {
    graphqlEnumValue[keyPath: keyPath]
  }
}