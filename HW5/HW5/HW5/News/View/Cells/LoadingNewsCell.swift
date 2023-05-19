import UIKit

final class LoadingNewsCell: UITableViewCell {
    static let reuseIdentifier = "LoadingNewsCell"
    private let loadingImageView = UIView()
    private let loadingTitleView = UIView()
    private let loadingDescriptionView = UIView()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        setupView()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Private methods
    private func setupView() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }

    private func setupImageView() {
        loadingImageView.layer.cornerRadius = 8
        loadingImageView.layer.cornerCurve = .continuous
        loadingImageView.clipsToBounds = true
        loadingImageView.contentMode = .scaleAspectFill
        loadingImageView.backgroundColor = .secondarySystemBackground

        contentView.addSubview(loadingImageView)
        loadingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        loadingImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        loadingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        loadingImageView.pinWidth(to: loadingImageView.heightAnchor)
    }

    private func setupTitleLabel() {
        loadingTitleView.backgroundColor = .secondarySystemBackground
        loadingTitleView.layer.cornerRadius = 8
        loadingTitleView.layer.cornerCurve = .continuous
        contentView.addSubview(loadingTitleView)
        loadingTitleView.translatesAutoresizingMaskIntoConstraints = false
        loadingTitleView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        loadingTitleView.leadingAnchor.constraint(equalTo: loadingImageView.trailingAnchor, constant: 12).isActive = true
        loadingTitleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        loadingTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }

    private func setupDescriptionLabel() {
        loadingDescriptionView.backgroundColor = .secondarySystemBackground
        loadingDescriptionView.layer.cornerRadius = 8
        loadingDescriptionView.layer.cornerCurve = .continuous
        contentView.addSubview(loadingDescriptionView)
        loadingDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        loadingDescriptionView.leadingAnchor.constraint(equalTo: loadingImageView.trailingAnchor, constant: 12).isActive = true
        loadingDescriptionView.topAnchor.constraint(equalTo: loadingTitleView.bottomAnchor, constant: 12).isActive = true
        loadingDescriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        loadingDescriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
    }
}
