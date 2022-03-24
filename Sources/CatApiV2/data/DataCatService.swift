import Foundation
import FoundationNetworking

class DataCatService{
    
    static let instance:DataCatService = CatDataService()

    func getBreeds(onCompletion:@escaping CallbackBlock<Cat> /* onError:ErrorBlock? */){

        let url = URL(string: "https://api.thecatapi.com/v1/breeds")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request){data, response, error in 
            guard let data = data else{return}

            do {
                let decodeData : [Cat] = try JsonDecoder().decode([Cat].self, from:data)

                onCompletion(decodeData)
                
            } catch error {
                print("Fail \(error)")
                onError?(error)
            }

        }
        task.resume()
    }
        
}