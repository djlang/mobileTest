//
//  BookingDataManager.swift
//  MobileTest
//
//  Created by dengjinlang on 2025/9/3.
//

import Foundation

class BookingDataManager {
    private var service = BookingService()
    private var cache = BookingCache()
    
    func loadBooking(forceRefresh: Bool = false, completion: @escaping (Booking?) -> Void) {
        
        //如何不刷新，先查看缓存
        if !forceRefresh, let cached = cache.load() {
            if let expiry = Double(cached.expiryTime), Date().timeIntervalSince1970 < expiry {
                print("使用缓存数据: \(cached)")
                completion(cached)
                return
            }
            
        }
        
        //失效则获取新数据
        service.fetchBooking { [weak self] result in
            switch result {
            case .success(let booking):
                print("Booking segments解码成功: \(booking.segments)")
                print("获取数据\(booking)")
                print("segments 数量: \(booking.segments.count)")
                //缓存新数据
                self?.cache.save(booking)
                completion(booking)
            case .failure(let error):
                print("获取数据失败: \(error)")
                completion(nil)
            }
        }
        
        
    }
}
