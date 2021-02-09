//
//  MainTabController.swift
//  instagramClone
//
//  Created by dev.geeyong on 2021/01/27.
//


import UIKit
import Firebase

class MainTabController: UITabBarController{
    //MARK: - Propertie
    private var user: User? {
        didSet{
            guard let user = user else {
                return
            }
            configureViewController(withUser: user)
            
        }
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
  
        checkIfUserIsLoggedIn()
        fetchUser()
    }
    //MARK: - API
    func fetchUser(){
        UserService.fetchUser { user in
            self.user = user
        }
    }
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }

    //MARK: - Helpers
    func configureViewController(withUser user: User) {
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        let notification = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profileController)
        
        viewControllers = [feed,search,imageSelector,notification,profile]
        
        tabBar.tintColor = .black
    }
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
}

extension MainTabController: AuthenticationDelegate{
    func authenticationDidComplete(){
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}
