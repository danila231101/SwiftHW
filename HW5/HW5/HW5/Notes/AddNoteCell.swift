import UIKit

protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: ShortNote)
}

final class AddNoteCell: UITableViewCell {
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()

    var delegate: AddNoteDelegate?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateUI() {
        if textView.text.isEmpty || textView.textColor == .secondaryLabel {
            addButton.isEnabled = false
            addButton.alpha = 0.5
        } else {
            addButton.isEnabled = true
            addButton.alpha = 1
        }
    }

    private func setupView() {
        textView.delegate = self
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .clear
        textView.setHeight(to: 140)

        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(to: 44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addButton.isEnabled = false
        addButton.alpha = 0.5

        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill

        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .secondarySystemBackground

        clearTextView()
    }

    private func clearTextView() {
        textView.text = "Add quick note"
        textView.textColor = .tertiaryLabel
    }

    @objc
    private func addButtonTapped(_ sender: UIButton) {
        updateUI()
        delegate?.newNoteAdded(note: ShortNote(text: textView.text))
        clearTextView()
    }
}

extension AddNoteCell: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .tertiaryLabel {
            textView.text = ""
            textView.textColor = .label
        }
        updateUI()
    }

    public func textViewDidChange(_ textView: UITextView) {
        updateUI()
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add quick note"
            textView.textColor = .tertiaryLabel
        }
        updateUI()
    }
}
