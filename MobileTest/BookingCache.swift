//
//  BookingCache.swift
//  MobileTest
//
//  Created by dengjinlang on 2025/9/3.
//

import Foundation

class BookingCache {
    
    private let key = "BookingCacheKey"
    
    func save(_ booking: Booking){
        // 转换为 JSON 数据
        if let data = try? JSONEncoder().encode(booking){
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    //读取缓存
    func load() -> Booking? {
        guard let data  = UserDefaults.standard.data(forKey: key),  let booking = try? JSONDecoder().decode(Booking.self, from: data) else {
            
            print("无缓存数据")
            return nil
        }
        print("Booking 解码成功: \(booking)")
        return booking
    }
    
}
