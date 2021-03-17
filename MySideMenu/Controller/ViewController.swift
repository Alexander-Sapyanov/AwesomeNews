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
    
    // MARK: - Network
    var datas = [Articles]()
    private let networkService = Networking()
    
    // MARK: - NewsTableView
    @IBOutlet weak var newsTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTablView()
        setUpSideMenu()
    }
    
    // MARK: - Functions

    private func setUpTablView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifire)
        
        request()
    }
    
    private func setUpSideMenu(){
        
        let menu =  MenuController(with:[ "Top Headlines","Info"])
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController:menu)
        sideMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        sideMenu?.setNavigationBarHidden(true, animated: false)
        
        addChildControllers()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func request() {
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9fb06d2a97d54c68a7c3ab48bc158c32"
        
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
        
        view.addSubview(infoController.view)
 
        
        infoController.view.frame = view.bounds
       
        
        infoController.didMove(toParent: self)

        
        infoController.view.isHidden = true
    }
    
    internal func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            
            self?.title = named
            if named == "Top Headlines" {
                self?.infoController.view.isHidden = true
      
                
            } else if named == "Info" {
                self?.infoController.view.isHidden = false

            }
        })
    }
  
    @IBAction func didTapMenuButton(){
        present(sideMenu!, animated: true)
    }
}






