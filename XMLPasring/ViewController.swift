//
//  ViewController.swift
//  XMLPasring
//
//  Created by kuldeep on 31/08/22.
//

import UIKit

class ViewController: UIViewController,XMLParserDelegate {
    
    var videos = NSArray()
    private var currentElement = ""
    private var parseTitle = ""
    private var parseDescription = ""
    private var parseLink = ""
    private var parsePubDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    
    
    func getData(){
        
        var urlRequest:URLRequest = URLRequest(url: URL(string:"https://api.field59.com/v2/video/search?user=fusioniuser")!)
        urlRequest.httpMethod = "GET"
        let username = "fusioniuser"
        let password = "fusioni1234"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                return
            }
            let parser:XMLParser  = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        
        })
        .resume()
        
    }
    
    //MARK: - XMLParser Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "videos" {
           
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "video": parseTitle += string
        
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "videos"{
         
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
      //  parseCompletionHandler?(iTunesItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}



struct Video {
    
    var key : String?
    var title : String?
    var videoID : String?
    var createDate : String?
    var urlString : String?
    var category : String?
    var summary : String?
    var duration : String?
    var thumbURL : String?
    var owner : String?
    var user : String?
    var keywords : NSArray?
    var itemImage : UIImage?

}
