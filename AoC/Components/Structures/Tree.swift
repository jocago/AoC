//
//  Tree.swift
//  AoC
//
//  Created by Joshua Gohlke on 11/18/20.
//  Based on Swift Algorithm Club
//

import Foundation


class Node<T> {
    var value: T
    var children: [Node<T>] = []
    weak var parent: Node<T>?
    
    init(value: T) {
        self.value = value
    }
    
    func add(child: Node<T>) {
        children.append(child)
        child.parent = self
    }
    
    func add(childData: T) {
        self.add(child: Node(value: childData))
    }
}
