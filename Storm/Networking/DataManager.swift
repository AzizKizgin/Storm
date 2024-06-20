import Foundation
import Combine

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func sendRequest<T: Decodable>(
        for url: URL,
        data: Encodable? = nil,
        requestType: RequestType) -> AnyPublisher<T, Error> {

        guard let request = createRequest(for: url, data: data, requestType: requestType) else {
            return Fail(error: NSError(domain: "Storm", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create request"]))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { try self.handleResponse(output: $0) }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func createRequest(for url: URL, data: Encodable?, requestType: RequestType) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let data = data {
            do {
                request.httpBody = try JSONEncoder().encode(data)
            } catch {
                print("error")
                return nil
            }
        }
        
        return request
    }
    
    private func handleResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let httpResponse = output.response as? HTTPURLResponse else {
            throw NSError(domain: "Storm", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return output.data
        case 400..<500:
            let errorMessage = String(data: output.data, encoding: .utf8) ?? "Bad request"
            throw NSError(domain: "Storm", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        default:
            throw NSError(domain: "Storm", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])
        }
    }
}
