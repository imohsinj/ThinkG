//
//  CustomPaperCell.swift
//  PaperView
//
//  Created by Adam J Share on 3/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import PaperCollectionView


class CustomPaperCell: PaperCell {
    
    var contentVC: ContentViewController?
    
    
}

class ContentViewController: UIViewController, PaperCellChangeDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bigLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    
    @IBOutlet weak var baseContentView: UIView!
    @IBOutlet weak var roundedView: UIView!
    
    
    @IBOutlet weak var tableViewSession: UITableView!
    
    let imgsTitle = ["select_clubs_icon", "swing_set_up_icon", "tempo_set_up", "timing_icon", "voice_sounds_icon"]
    let imgsDetails = ["","swing", "tempo", "timing", "voice"]

    let titleS = ["Select Clubs","Swing Setup", "Tempo Setup", "Timing", "Voice/Sounds"]

    let level = ["","", "Level1", "Level2", "Level2"]
    var indexPathOfSelectedRow : NSIndexPath?
    
//    var dicSession1 = ["title": "Select Clubs", "titleImg": "select_clubs_icon"]
//    var dicSession2 = ["title": "Swing Setup", "titleImg": "swing_set_up_icon","detailImg":"swing"]
//    var dicSession3 = ["title": "Tempo Setup", "titleImg": "tempo_set_up","detailImg":"tempo","level":"Level1"]
//    var dicSession4 = ["title": "Timing", "titleImg": "timing_icon","detailImg":"timing","level":"Level2"]
//    var dicSession5 = ["title": "Voice/Sounds", "titleImg": "voice_sounds_icon","detailImg":"voice","level":"Level3"]
    
//    let arySessions = [["title": "Select Clubs", "titleImg": "select_clubs_icon"],
//                       ["title": "Swing Setup", "titleImg": "swing_set_up_icon","detailImg":"swing"],
//                       ["title": "Tempo Setup", "titleImg": "tempo_set_up","detailImg":"tempo","level":"Level1"],
//                       ["title": "Timing", "titleImg": "timing_icon","detailImg":"timing","level":"Level2"],
//                       ["title": "Voice/Sounds", "titleImg": "voice_sounds_icon","detailImg":"voice","level":"Level3"]]

    var expandedRows = Set<Int>()

    
    func presentationRatio(_ ratio: CGFloat) {
//        bigLabel.alpha = 1 - ratio
//        smallLabel.alpha = ratio
//        descriptionTitleLabel.alpha = ratio
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewSession.rowHeight = UITableViewAutomaticDimension

        
//baseContentView.layer.shadowColor = UIColor.black.cgColor
//baseContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
//baseContentView.layer.shadowOpacity = 0.2
//baseContentView.layer.shadowRadius = 2
//roundedView.layer.cornerRadius = 4
//roundedView.clipsToBounds = true
    }
    
    
    // TableView DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ExpandableCell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell") as! ExpandableCell
        
        
        if (imgsTitle[indexPath.row] != nil || !imgsTitle[indexPath.row].isEmpty ){
            cell.imgSessionTitle.image = UIImage(named: imgsTitle[indexPath.row])

        }
        if (imgsDetails[indexPath.row] != nil || !imgsDetails[indexPath.row].isEmpty ){
            cell.imgSessionDetails.image = UIImage(named: imgsDetails[indexPath.row])

        }
        if (titleS[indexPath.row] != nil || !titleS[indexPath.row].isEmpty ){
            cell.lblSessionTitle.text = titleS[indexPath.row]

        }
        if (level[indexPath.row] != nil || !level[indexPath.row].isEmpty ){
            cell.lblLevel.text = level[indexPath.row]

        }
        
        
        

        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 308.0
    }
    
    
    // MARK: Table view Delegates
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Expand and Collapse logic
        let previousIndexPath = indexPathOfSelectedRow
        if indexPath == indexPathOfSelectedRow {
            indexPathOfSelectedRow = nil
        } else {
            indexPathOfSelectedRow = indexPath
        }
        
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = indexPathOfSelectedRow {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths as [IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //Clear the background color of cell on de-selection or selecting other cell
        (cell as! ExpandableCell).watchFrameChanges()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! ExpandableCell).ignoreFrameChanges()
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //Calculate the height for Expand and Collapse
        if indexPath == indexPathOfSelectedRow {
            return ExpandableCell.expandedHeight
        } else {
            return ExpandableCell.defaultHeight
        }
    }

    
    


}
