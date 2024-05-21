//
//  ArrayExtension.swift
//  JsonConverterTest
//
//  Created by 劉柏賢 on 2024/5/21.
//  Copyright © 2024 劉柏賢. All rights reserved.
//

import Foundation

protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    var optional: Wrapped? {
        return self
    }
}

extension Sequence {
    var toArray: Array<Element> {
        return Array(self)
    }
    
    /// 依序等待，非同步執行(並發)ForEach [來源](https://www.swiftbysundell.com/articles/async-and-concurrent-forEach-and-map/)]
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values: [T] = []
        
        for element in self {
            try await values.append(transform(element))
        }
        
        return values
    }
    
    /// 依序等待，非同步執行(並發)ForEach
    func asyncCompactMap<T>(
        _ transform: (Element) async throws -> T?
    ) async -> [T] {
        var values: [T] = []
        
        for element in self {
            guard let x = try? await transform(element) else { continue }
            values.append(x)
        }
        
        return values
    }
    
    /// 有順序的平行執行(並發)ForEach [來源](https://www.swiftbysundell.com/articles/async-and-concurrent-forEach-and-map/)]
    func concurrentMap<T>(
        _ transform: @escaping (Element) async throws -> T
    ) async throws -> [T] {
        let tasks: [Task<T, any Error>] = map { element in
            return Task {
                try await transform(element)
            }
        }
        
        let result: [T] = try await tasks.asyncMap { task in
            try await task.value
        }
        
        return result
    }
    
    /// 有順序的平行執行 (一個中斷不影響其它)
    func concurrentCompactMap<T>(
        _ transform: @escaping (Element) async throws -> T?
    ) async -> [T] {
        let tasks: [Task<T?, any Error>] = map { element in
            return Task {
                try? await transform(element)
            }
        }
        
        let result: [T] = await tasks.asyncCompactMap { task in
            try? await task.value
        }
        
        return result
    }
}

extension Sequence where Iterator.Element: OptionalType {

    /// Array中去掉nil
    var dropNil: [Iterator.Element.Wrapped] {
        return self.compactMap { $0.optional }
    }
}

extension Sequence where Iterator.Element == String {
    /// Array中去掉empty
    var dropNilOrEmpty: [Iterator.Element] {
        return self.compactMap { (item: Self.Element) -> Self.Element? in
            guard !item.isEmpty else {
                return nil
            }
            
            return item
        }
    }
}

extension Sequence where Iterator.Element == Optional<String> {

    /// Array中去掉empty
    var dropNilOrEmpty: [String] {
        return self.compactMap { (item: Self.Element) -> String? in
            guard let value = item, !value.isEmpty else {
                return nil
            }
            
            return item
        }
    }
}

extension TaskGroup where ChildTaskResult: OptionalType {

    /// 去掉nil
    var dropNil: AsyncCompactMapSequence<TaskGroup<ChildTaskResult>, ChildTaskResult.Wrapped> {
        return self.compactMap { $0.optional }
    }
}

extension ThrowingTaskGroup where ChildTaskResult: OptionalType {

    /// 去掉nil
    var dropNil: AsyncCompactMapSequence<ThrowingTaskGroup<ChildTaskResult, Failure>, ChildTaskResult.Wrapped> {
        return self.compactMap { $0.optional }
    }
}
