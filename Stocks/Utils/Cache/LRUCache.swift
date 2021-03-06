//
//  LRUCache.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 30.04.2022.
//

final class LRUCache<KeyType: Hashable> {
    private let maxSize: Int
    private var cache: [KeyType: Any] = [:]
    private var priority: LinkedList<KeyType> = LinkedList<KeyType>()
    private var key2node: [KeyType: LinkedList<KeyType>.LinkedListNode<KeyType>] = [:]
    
    init(_ maxSize: Int) {
        self.maxSize = maxSize
    }
    
    func get(_ key: KeyType) -> Any? {
        guard let val = cache[key] else {
            return nil
        }
        
        remove(key)
        insert(key, val: val)
        
        return val
    }
    
    func set(_ key: KeyType, val: Any) {
        if cache[key] != nil {
            remove(key)
        } else if priority.count >= maxSize, let keyToRemove = priority.last?.value {
            remove(keyToRemove)
        }
        
        insert(key, val: val)
    }
    
    private func remove(_ key: KeyType) {
        cache.removeValue(forKey: key)
        guard let node = key2node[key] else {
            return
        }
        
        priority.remove(node: node)
        key2node.removeValue(forKey: key)
    }
    
    private func insert(_ key: KeyType, val: Any) {
        cache[key] = val
        priority.insert(key, atIndex: 0)
        guard let first = priority.first else {
            return
        }
        
        key2node[key] = first
    }
}
