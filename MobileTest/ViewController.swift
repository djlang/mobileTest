//
//  ViewController.swift
//  MobileTest
//
//  Created by dengjinlang on 2025/9/2.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    private let tableView = UITableView()
    private let manager = BookingDataManager()
    private var segments: [Segment] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Booking 列表"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "刷新", style: .plain, target: self, action: #selector(refreshData))
        setupTableView()
        loadData()
        
    }
   
    func setupTableView(){
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        // 注册 cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
    }
    
    // 加载数据，支持刷新
   private func loadData(forceRefresh: Bool = false) {
        manager.loadBooking(forceRefresh: forceRefresh) { [weak self] booking in
            // 主线程更新 UI
            DispatchQueue.main.async { // 回到主线程更新 UI
                if let booking = booking {
                    self?.segments = booking.segments // 保存航段数据
                    self?.tableView.reloadData()
                    
                }
            }
            
//            if let booking = booking {
//                self?.segments = booking.segments // 保存航段数据
//                self?.tableView.reloadData()
//                
//            }
        }
    }
    
    @objc func refreshData() {
        loadData(forceRefresh: true) // 刷新数据
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let segment = segments[indexPath.row] // 获取对应航段
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let origin = segment.originAndDestinationPair.origin.displayName // 出发地
        let destination = segment.originAndDestinationPair.destination.displayName // 目的地
        cell.textLabel?.text = "\(segment.id): \(origin) → \(destination)" // 设置显示文本
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


}

