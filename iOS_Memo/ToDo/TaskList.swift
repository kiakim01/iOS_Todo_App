//
//  TaskList.swift
//  iOS_Memo
//
//  Created by kiakim on 2023/08/12.
//
import Foundation

// 할일 1. TaskList를 어떻게 기존 테이블과 연결하는지 알기


struct TaskList {
    static var list: [Task] = [
        Task(id: 0, title: "Swift 공식 문서 읽기", isCompleted: false),
        Task(id: 1, title: "UIKit 공식 문서 읽기", isCompleted: true),
    ]
    static func completeList() -> [Task] {
        return list.filter{ $0.isCompleted == true }
    }

    static func completeTask(task: Task, isCompleted: Bool) {
        for index in 0 ..< list.count {
            if list[index].id == task.id {
                list[index].isCompleted = isCompleted
            }
        }
    }
    static func editTask(task: Task, title: String) {
        for index in 0 ..< list.count {
            if list[index].id == task.id {
                list[index].title = title
            }
        }
    }
    static func deleteTask(task: Task) {
        list.removeAll(where: {$0.id == task.id})
    }
}

