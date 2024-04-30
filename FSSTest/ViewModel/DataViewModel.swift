//
//  DataViewModel.swift
//  FSSTest
//
//  Created by Medshow on 30/04/24.
//

import Foundation
import WebCall

protocol DataDelegate {
    func didReceiveSuccess(response: [detailsResponseModel]?, error: String?)
    func didReceiveFailure(error: String?)
}

struct DataViewModel {
    var delegate : DataDelegate?
    
    // Creating network object of WebCall Framework
    let webservice = Webservice()
    
    func getAPICall(urlStr: String)
    {
        // Check urlStr is valid url or not
        guard let url = URL(string: urlStr) else {
            delegate?.didReceiveFailure(error: "Invalid URL")
            return
        }
        // Call the fetch function with the URL
        webservice.fetch(url: url, resultType: [detailsResponseModel].self) { result in
            switch result {
            case .success(let data):
                // Data successfully fetched and parsed
                if let data = data {
                    // Use the fetched data
                    delegate?.didReceiveSuccess(response: data, error: "")
                } else {
                    // Data is nil
                    delegate?.didReceiveFailure(error: "No data is received")
                }
            case .failure(let error):
                // Error occurred during fetch or parsing
                delegate?.didReceiveFailure(error: error.localizedDescription)
            }
        }
    }
}
