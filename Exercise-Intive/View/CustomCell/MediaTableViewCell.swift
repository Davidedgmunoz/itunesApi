//
//  MediaTableViewCell.swift
//  Exercise-Intive
//
//  Created by David Munoz on 01/08/2018.
//  Copyright © 2018 David Munoz. All rights reserved.
//

import UIKit
class MediaTableViewCell: UITableViewCell {
    @IBOutlet weak var mediaName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var downArrowImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var previewUrl : String!
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }
    
    func configureViewFrom(media:Media){
        mediaName.text = media.trackName
        previewImage.loadImageFrom(url: media.disckImage!)
        previewUrl = media.previewUrl!
    
        if let music = media as? Music{
            artistName.text = music.artistName
            downArrowImageView.isHidden = true
            descriptionLabel.text = ""
        }else{
            if let video = media as? TvShow {
                artistName.text = video.artistName
                descriptionLabel.text = video.description
                downArrowImageView.isHidden = false

            }else{
                if let movie = media as? Movie{
                    artistName.text = ""
                    descriptionLabel.text = movie.description
                    downArrowImageView.isHidden = false
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func playPreview(_ sender: Any) {
        
    }
}
