//
//  ViewController.swift
//  XMLPasring
//
//  Created by kuldeep on 31/08/22.
//

import UIKit
import XMLCoder

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
        
        var urlRequest:URLRequest = URLRequest(url: URL(string:"https://api.field59.com/v2/video/search")!)
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
            let decoder = XMLDecoder()
                   decoder.shouldProcessNamespaces = true
                   do {
                       let note = try decoder.decode(VideoDataModel.self, from: data)
                       print(note)
                   } catch {
                       print(error)
                   }
        
        })
        .resume()
        
    }
    
   
}



struct Json4Swift_Base : Codable {
    let timeZone : String?
    let videos : Videos?

    enum CodingKeys: String, CodingKey {
        case timeZone = "timeZone"

        case videos = "videos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        timeZone = try values.decodeIfPresent(String.self, forKey: .timeZone)
        videos = try values.decodeIfPresent(Videos.self, forKey: .videos)
    }

}
struct Videos : Codable {
    let video : [Video]?

    enum CodingKeys: String, CodingKey {

        case video = "video"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        video = try values.decodeIfPresent([Video].self, forKey: .video)
    }

}

struct Video : Codable {
    let key : String?
    let title : String?
    let category : String?
    let url : String?
    let duration : String?
    let summary : String?
    let description : String?
    let thumb : String?
    let thumbSmall : String?
    let thumbMedium : String?
    let createDate : String?
    let lastModifiedDate : String?
    let liveDate : String?
    let owner : String?
    let user : String?
    let id : String?
    let legacyKey : String?

    enum CodingKeys: String, CodingKey {

        case key = "key"
        case title = "title"
        case category = "category"
        case url = "url"
        case duration = "duration"
        case summary = "summary"
        case description = "description"
        case thumb = "thumb"
        case thumbSmall = "thumbSmall"
        case thumbMedium = "thumbMedium"
        case createDate = "createDate"
        case lastModifiedDate = "lastModifiedDate"
        case liveDate = "liveDate"
        case owner = "owner"
        case user = "user"
        case id = "id"
        case legacyKey = "legacyKey"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
        thumbSmall = try values.decodeIfPresent(String.self, forKey: .thumbSmall)
        thumbMedium = try values.decodeIfPresent(String.self, forKey: .thumbMedium)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        lastModifiedDate = try values.decodeIfPresent(String.self, forKey: .lastModifiedDate)
        liveDate = try values.decodeIfPresent(String.self, forKey: .liveDate)
        owner = try values.decodeIfPresent(String.self, forKey: .owner)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        legacyKey = try values.decodeIfPresent(String.self, forKey: .legacyKey)
    }

}


struct VideoDataModel:Codable{
    let timezone:String?
    let videolist :videolistData
    enum CodingKeys: String, CodingKey {
 case timezone
        case videolist
    }
}

struct videolistData:Codable{
    let video:[videoData]
    
    enum CodingKeys: String, CodingKey {
        case video
    }
}
struct videoData:Codable {
    let key : String?
    let title : String?
    let category : String?
    let url : String?
    let duration : String?
    let summary : String?
    let description : String?
    let thumb : String?
    let thumbSmall :String?
    let thumbMedium : String?
    let createDate :String?
    let lastModifiedDate : String?
    let liveDate : String?
    let owner : String?
    let user : String?
    let id : String?
    let legacyKey : String?
    enum CodingKeys: String, CodingKey {
        case key, title , category,url,duration,summary
        case description,thumb,thumbSmall,thumbMedium,createDate,lastModifiedDate,liveDate,owner,user,id,legacyKey
    }
    
}


