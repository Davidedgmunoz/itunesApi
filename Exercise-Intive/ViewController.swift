//
//  ViewController.swift
//  Exercise-Intive
//
//  Created by David Munoz on 01/08/2018.
//  Copyright © 2018 David Munoz. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    let reuseIdentifier = "mediaCell"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var tvShowSwitch: UISwitch!
    @IBOutlet weak var movieSwitch: UISwitch!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var activtyIndicator: UIActivityIndicatorView!
    
    var currentFilterSelected : UISwitch?
    var mediaData = [Media]()
    var selectedIndexPath : IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentFilterSelected = musicSwitch
        musicSwitch.addTarget(self, action: #selector(switchChanged(mySwitch:)), for: UIControlEvents.valueChanged)
        movieSwitch.addTarget(self, action: #selector(switchChanged(mySwitch:)), for: UIControlEvents.valueChanged)
        tvShowSwitch.addTarget(self, action: #selector(switchChanged(mySwitch:)), for: UIControlEvents.valueChanged)
        
        contentTableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            if let previousSwitch = currentFilterSelected {
                previousSwitch.setOn(false, animated: true)
            }
            currentFilterSelected = mySwitch
        }else{
            currentFilterSelected = nil
        }
        
    }
}


//MARK:- Extension SearchBarDelegate
extension ViewController: UISearchBarDelegate,UISearchResultsUpdating{
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    func updateSearchResults(for searchController: UISearchController) {
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let textToSearch = searchBar.text {
            if textToSearch.count > 0 {
                self.activtyIndicator.isHidden = false
                self.activtyIndicator.startAnimating()
                searchBar.resignFirstResponder()
                ItunesApiService.sharedInstance.getMediaFor(search: searchBar.text!,forFilter: FilterTypes.allValues[(self.currentFilterSelected?.tag ?? 1)-1]) { (response) in
                    if let mediaArray = response{
                        self.mediaData = mediaArray
                        self.contentTableView.reloadData()
                        self.activtyIndicator.stopAnimating()
                    }
                }
                
            }else{
                let alert = UIAlertController.init(title: "Empty Text", message: "Please, give us something to search", preferredStyle: UIAlertControllerStyle.alert)
                let actionOk = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                    self.searchBar.becomeFirstResponder()
                })
                alert.addAction(actionOk)
                present(alert, animated: true)
            }
        }
    }
    
}

//MARK:- Extension TableViewDelegate

extension ViewController :UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let indexToExpand = selectedIndexPath {
            if indexToExpand == indexPath {
                if let cell = tableView.cellForRow(at: indexPath) as? MediaTableViewCell{
                    return 120 + cell.descriptionLabel.frame.height + 20
                }
            }
        }
        return 120
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndexPath = nil
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selected  = selectedIndexPath{
            if selected == indexPath {
                self.selectedIndexPath = nil
            }else{
                selectedIndexPath = indexPath
            }
        }else{
            selectedIndexPath = indexPath

        }
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
}

//MARK: - Extension TableViewDataSource
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MediaTableViewCell
        cell.configureViewFrom(media:mediaData[indexPath.row])
        cell.playButton.tag = indexPath.row
        cell.playButton.addTarget(self, action: #selector(playButtonPressed(_:)), for: .touchUpInside)
        cell.clipsToBounds = true
        return cell
    }
    
    @objc fileprivate func playButtonPressed(_ sender: UIButton){
        let media = mediaData[sender.tag]
        
        //This is making the view constraints to throw exceptions.. but they work
        let videoURL = NSURL(string: media.previewUrl!)
        let player = AVPlayer(url: videoURL! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

