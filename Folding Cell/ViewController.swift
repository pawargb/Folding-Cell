//
//  ViewController.swift
//  Folding Cell
//
//  Created by Ganesh Balaji Pawar on 11/05/18.
//  Copyright © 2018 Ganesh Balaji Pawar. All rights reserved.
//

import UIKit

fileprivate struct C {
    struct CellHeight {
        static let close: CGFloat = CGFloat(75) // equal or greater foregroundView height
        static let open: CGFloat = CGFloat(576.5) // equal or greater containerView height
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let array = ["A","B","C","D","E"]

    var cellHeights = (0..<5).map { _ in C.CellHeight.close }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    //MARK: - Table View methods

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoldingCell
        
        cell.label.text = array[indexPath.row]
        
        cell.commonInit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        var duration = 0.0
        
        if cellHeights[indexPath.row] == C.CellHeight.close { // open cell
            cellHeights[indexPath.row] = C.CellHeight.open
            cell.setSelected(true, animated: true)
//            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = C.CellHeight.close
            cell.setSelected(false, animated: true)
//            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case let cell as FoldingCell = cell {
            if cellHeights[indexPath.row] == C.CellHeight.close {
                cell.setSelected(false, animated: false)
//                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                cell.setSelected(true, animated: true)
//                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
}

