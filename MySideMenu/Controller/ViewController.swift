//
//  ViewController.swift
//  MySideMenu
//
//  Created by Alexander  Sapianov on 02.02.2021.
//
import SideMenu
import UIKit
import SDWebImage
import SafariServices

class ViewController: UIViewController, MenuControllerDelegate {
    
    // MARK: - Side Menu
    
    private var sideMenu: SideMenuNavigationController?
    private let infoController = InfoViewController()
    private let settingsViewController = SettingsViewController()
    
    // MARK: - JSON
    
    private let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9fb06d2a97d54c68a7c3ab48bc158c32"
    private let techUrl = "https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=9fb06d2a97d54c68a7c3ab48bc158c32"
    private let business = "https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9fb06d2a97d54c68a7c3ab48bc158c32"
    private var datas = [Articles]()
    private let networkService = Networking()
    
    
    @IBOutlet weak var newsTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifire)
        
        let menu =  MenuController(with:[ "Top Headlines","Info","Settings"])
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController:menu)
        sideMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        sideMenu?.setNavigationBarHidden(true, animated: false)
        
        addChildControllers()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        request()
    }
    
    // MARK: - Functions
    
    private func request() {
        networkService.request(urlString: url) { [weak self] (result) in
            switch result {
            case .success(let newsFeed):
                for i in newsFeed.articles! {
                    var new = Articles()
                    new.author = i.author
                    new.content = i.content
                    new.title = i.title
                    new.url = i.url
                    new.urlToImage = i.urlToImage
                    
                    self?.datas.append(new)
                    self?.newsTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addChildControllers() {
        addChild(self.infoController)
        addChild(self.settingsViewController)
        
        view.addSubview(infoController.view)
        view.addSubview(settingsViewController.view)
        
        infoController.view.frame = view.bounds
        settingsViewController.view.frame = view.bounds
        
        infoController.didMove(toParent: self)
        settingsViewController.didMove(toParent: self)
        
        settingsViewController.view.isHidden = true
        infoController.view.isHidden = true
    }
    
    internal func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            
            self?.title = named
            if named == "Top Headlines" {
                self?.infoController.view.isHidden = true
                self?.settingsViewController.view.isHidden = true
                
            } else if named == "Info" {
                self?.infoController.view.isHidden = false
                self?.settingsViewController.view.isHidden = true
            }else if named == "Settings"{
                self?.infoController.view.isHidden = true
                self?.settingsViewController.view.isHidden = false
            }
        })
    }
  
    @IBAction func didTapMenuButton(){
        present(sideMenu!, animated: true)
    }
}

// MARK: - Extensions

// TableView Delegate
extension ViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTrail = datas[indexPath.row]
        let url = selectedTrail.url
        
        let safariVC = SFSafariViewController(url: URL(string: url!)!)
        safariVC.delegate = self
        present(safariVC, animated: true, completion: nil)
    }
}
// TableView Data source
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifire, for: indexPath) as! NewsTableViewCell
        
        let currentUrl = datas[indexPath.row].urlToImage
        
        guard let url = URL(string: currentUrl ?? "https://picsum.photos/200") else {return cell}
        cell.imageView?.sd_setImage(with: url,placeholderImage: UIImage(named: "1"),options: [.continueInBackground,.progressiveLoad],completed: nil)
        cell.textLabel?.text = datas[indexPath.row].title
        cell.detailTextLabel?.text = datas[indexPath.row].publishedAt
        cell.imageView?.clipsToBounds = true
        cell.contentMode = .scaleAspectFit
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// SafariDelegate
extension ViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

