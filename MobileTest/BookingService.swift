//
//  BookingService.swift
//  MobileTest
//
//  Created by dengjinlang on 2025/9/3.
//

import Foundation

class BookingService {
    
    func fetchBooking(completion: @escaping (Result<Booking, Error>) -> Void){
        guard let url = Bundle.main.url(forResource: "booking", withExtension: "json") else {
            completion(.failure(NSError(domain: "FileNotFound", code: -1)))// 如果找不到文件，返回错误
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let booking = try JSONDecoder().decode(Booking.self, from: data) // 解析为 Booking 模型
            completion(.success(booking))
        } catch {
            completion(.failure(error))
        }
    }
}
