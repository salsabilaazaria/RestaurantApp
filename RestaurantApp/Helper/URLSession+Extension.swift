//
//  URLSession+Extension.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 21/12/22.
//

import Foundation

extension  URLSession {
	func requestData<T: Codable>(url: URL?,
							 expecting: T.Type,
							 completion: @escaping (Result<T, Error>) -> Void) {
		//T represent an object that is codable, could be anything AS LONG extend codable
		
		/*Parameter
		 URL: url yang dipake buat hit api
		 expecting: it should be T.Type, example we are trying to decode an object call User, so it will be User.self
		 completion: giving back the result or and error
		 */
		
		guard let url = url else {
			completion(.failure(NSError()))
			//error invalid url
			return
		}
		
		let task = self.dataTask(with: url) {data, _, error in
			guard let data = data else {
				//error data not found
				completion(.failure(NSError()))
				return
			}
			
			do {
				let result = try JSONDecoder().decode(expecting, from: data)
				//success get data
				completion(.success(result))
			} catch {
				//error data cant be decode
				completion(.failure(NSError()))
			}
			
		}
		task.resume()
	}
}


