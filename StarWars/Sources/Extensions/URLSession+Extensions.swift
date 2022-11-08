import Foundation

extension URLSession {
    
    func dataTask<T>(request: URLRequest,
                     completionHandler: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask where T: Codable {
        return dataTask(with: request) { (data, response, _) in
            guard let httpResponse = response as? HTTPURLResponse else {
                
                completionHandler(.failure(SessionError.badResponse))
                return
            }
            guard let data = data else {
                completionHandler(.failure(SessionError.badData))
                return
            }
            do {
                guard (200..<400).contains(httpResponse.statusCode) else {
                    let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(jsonObj)
                    completionHandler(.failure(NetworkError.networkError))
                    return
                }
                
                let parsedData = try Parser.parse(T.self, from: data)
                completionHandler(.success(parsedData))
            } catch let error {
                print("\(String(describing: String(data: data, encoding: .utf8))) \(error)")
                completionHandler(.failure(NetworkError.decodeError))
            }
        }
    }
}
