//
//  ViewController.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 02.02.2021.
//
import SideMenu
import UIKit
import SDWebImage

class ViewController: UIViewController, MenuControllerDelegate {
    private var sideMenu: SideMenuNavigationController?
    private let settingsController = SettingsViewController()
    private let infoViewController = InfoViewController()
    private var tableView: UITableView!
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)

    
    
    // JSON
    
    private let url = "https://newsapi.org/v2/everything?q=tesla&from=2021-01-02&sortBy=publishedAt&apiKey=9fb06d2a97d54c68a7c3ab48bc158c32"
    private var datas = [Articles]()
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifire)
        
        let menu =  MenuController(with:[ "Home","Info","Settings"])
        
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController:menu)
        sideMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildControllers()
        
        
        request()
    }
    
   
    private func addChildControllers() {
        addChild(self.settingsController)
        addChild(self.infoViewController)
        
        view.addSubview(settingsController.view)
        view.addSubview(infoViewController.view)
        
        settingsController.view.frame = view.bounds
        infoViewController.view.frame = view.bounds
        
        settingsController.didMove(toParent: self)
        infoViewController.didMove(toParent: self)
        
        infoViewController.view.isHidden = true
        settingsController.view.isHidden = true
        
    }
    
    func request() {
        guard let newsUrl = URL(string: url) else { return }
        
        let request = URLRequest(url: newsUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
            print(error)
            return
        }
            if let data = data {
                self.datas = self.parseJsonData(data:data)
                
                OperationQueue.main.addOperation {
                    
                
                    
                    self.newsTableView.reloadData()
                }
            }
        })
        task.resume()
    }
    
    func parseJsonData(data:Data) -> [Articles] {
        var news = [Articles]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            // Parse JSON data
            let jsonNews = jsonResult?["articles"] as! [AnyObject]
            for jsonNew in jsonNews {
                var new = Articles()
                new.author = jsonNew["author"] as? String
                new.content = jsonNew["content"] as? String
                new.description = jsonNew["description"] as? String
                new.title = jsonNew["title"] as? String
                new.url = jsonNew["url"] as? String
                new.urlToImage = jsonNew["urlToImage"] as? String
                new.content = jsonNew["content"] as? String
                news.append(new)
               
        
                print(datas)
            }
        }
        catch {
            
        }
        return news
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func dowloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) {data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Dowload Fineshed")
            DispatchQueue.main.async {
                
            }
        }
    }

    
    

    @IBAction func didTapMenuButton(){
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            
            self?.title = named
            if named == "Home" {
                self?.infoViewController.view.isHidden = true
                self?.settingsController.view.isHidden = true
            } else if named == "Info" {
                self?.infoViewController.view.isHidden = false
                self?.settingsController.view.isHidden = true
            }else if named == "Settings"{
                self?.infoViewController.view.isHidden = true
                self?.settingsController.view.isHidden = false
            }
        })
    }
    
}
extension ViewController:UITableViewDelegate {}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifire, for: indexPath) as! NewsTableViewCell
        let currentUrl = datas[indexPath.row].urlToImage
        
        guard let url = URL(string: currentUrl ?? "https://picsum.photos/200") else {return cell}
  
    
        cell.imageView?.sd_setImage(with: url,placeholderImage: UIImage(named: "1"),options: [.continueInBackground,.progressiveLoad],completed: nil)
        cell.backgroundColor = .red
        cell.imageView?.contentMode = .scaleAspectFill
        
        cell.textLabel?.text = datas[indexPath.row].title
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

