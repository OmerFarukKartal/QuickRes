import Foundation

class APIService {
    static let shared = APIService()

    func loginUser(Email: String, Password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let apiUrl = URL(string: "https://ipmapi.ipmsoft.com.tr/Auth/Login") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "Email": Email,
            "Password": Password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "InvalidData", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(LoginResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
