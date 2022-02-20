//
//  ApiJsonDecoder.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 13.02.2022.
//

import Foundation

public class ApiJsonDecoder {
    
    public static let instance: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        
        return jsonDecoder
    }()
}
