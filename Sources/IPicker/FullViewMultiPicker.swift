//
//  FullViewMultiPicker.swift
//  IPicker
//
//  Created by Yousef on 1/17/21.
//  Copyright © 2021 Yousef. All rights reserved.
//

import UIKit

public extension IPicker {
class FullViewMultiSelectionPicker: IPicker.FullViewPicker {
    
    @available(*, unavailable, message: "Use `selectedIndexes` variable as this is a multi-selector")
    public override var selectedIndex: Int {
        get {
            return -1
        }
        set {}
    }
    
    public var selectedIndexes: [Int]
    private var didSelect: (([Int])-> Void)?
    
    
    public override init(style: IPicker.Style) {
        selectedIndexes = []
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView(parent: UIView) {
        super.setupView(parent: parent)
        doneButton.isHidden = false
    }
    
    @available(*, unavailable, message: "Use array parameter as this is a multi-selector")
    public override func didSelect(_ block: @escaping (Int) -> Void) {
        
    }
    
    public func didSelect(_ block: @escaping ([Int]) -> Void) {
        self.didSelect = block
    }
    
    override func doneButtonTapped() {
        guard !selectedIndexes.isEmpty else { doneButton.errorShakeAnimation(); return }
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.doneButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { _ in
                self.didSelect?(self.selectedIndexes)
                self.dismiss()
            })
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        setupCell(cell!, indexPath: indexPath)
        if self.selectedIndexes.contains(indexPath.row) {
            animateCellSelection(cell: cell!)
        } else {
            animateCellDeselection(cell: cell!)
        }
        return cell!
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath.row) {
            selectedIndexes.removeAll(where: { $0 == indexPath.row })
        } else {
            selectedIndexes.append(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
}
