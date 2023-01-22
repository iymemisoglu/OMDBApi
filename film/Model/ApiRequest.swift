

import Foundation
import Alamofire


struct ApiRequest : Decodable {

    let s : String
    let i : String?
    let t : String?

    
    var baseUrl : String {
        return "https://www.omdbapi.com/?t=\(t ?? "")&apikey=4b46434#"
    }
    
    func movieRequest(onComplete: @escaping (Result<MovieModel,AFError>) -> ())  {
          
        AF.request(baseUrl).responseDecodable(of: MovieModel.self) { response in
            switch response.result {
                
            case .success(let movie):
                onComplete(.success(movie))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}

