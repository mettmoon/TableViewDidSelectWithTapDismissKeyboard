//
//  TextFieldCell.swift
//  TableViewWithTapGesture
//
//  Created by peter on 2023/01/04.
//

import UIKit
private let checkedImage = UIImage(systemName: "checkmark.circle.fill")!
private let uncheckedImage = UIImage(systemName: "checkmark.circle")!
final class TextFieldCell: UITableViewCell {
    private var iconImageView: UIImageView!
    var textField: UITextField!
    var isChecked: Bool = false {
        didSet {
            self.updateUI()
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.iconImageView = .init(frame: .zero)
        self.textField = .init(frame: .zero)
        self.textField.borderStyle = .line
        self.contentView.addSubview(self.textField)
        self.contentView.addSubview(self.iconImageView)
        self.updateUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconImageView.frame.size = CGSize(width: 24, height: 24)
        self.iconImageView.frame.origin = .init(x: 16, y: (self.contentView.frame.height - self.iconImageView.frame.size.height) / 2)
        self.textField.frame.size.height = self.frame.size.height
        self.textField.frame.size.width = self.contentView.frame.width - 16 - self.iconImageView.frame.maxX - 120
        self.textField.frame.origin.x = self.iconImageView.frame.maxX + 16
        self.textField.frame.origin.y = (self.contentView.frame.height - self.textField.frame.height) / 2
    }
    private func updateUI() {
        let iconImage = self.isChecked ? checkedImage : uncheckedImage
        self.iconImageView.image = iconImage.withRenderingMode(.alwaysTemplate)
        self.iconImageView.tintColor = self.isChecked ? .blue : .gray
    }

    required init?(coder: NSCoder) {
        abort()
    }
}

