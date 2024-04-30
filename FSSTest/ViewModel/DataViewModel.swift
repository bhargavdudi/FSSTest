//
//  DataViewModel.swift
//  FSSTest
//
//  Created by Medshow on 30/04/24.
//

import Foundation
import WebCall

protocol DataDelegate {
    func didReceiveSuccess(response: detailsResponseModel?, error: String?)
    func didReceiveFailure(error: String?)
}

struct DataViewModel {
    var delegate : DataDelegate?
    
    // Creating network object of WebCall Framework
    let webservice = Webservice()
    
    func getAPICall(urlStr: String)
    {
        // Call the fetch function with the URL
        webservice.getApiData(urlString: urlStr, resultType: detailsResponseModel.self) { result in
            switch result {
            case .success(let data):
                // Data successfully fetched and parsed
                    // Use the fetched data
                    delegate?.didReceiveSuccess(response: data, error: "")
               
            case .failure(let error):
                // Error occurred during fetch or parsing
                delegate?.didReceiveFailure(error: error.localizedDescription)
            }
        }
    }
}
