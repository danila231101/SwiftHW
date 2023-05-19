import Foundation

final class ApiService {
    static let shared = ApiService()

    private enum Consts {
        static let topHeadlineURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=369ae55029c04749b59b79a7badb0d03")
    }

    private init() {}

    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Consts.topHeadlineURL else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
