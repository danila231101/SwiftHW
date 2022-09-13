//
//  ViewController.swift
//  gmsosnovskiyPW2
//
//  Created by Danila Kokin on 14.07.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {

    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private let incrementButton = UIButton(type: .system)
    private let redColorSlider = UISlider()
    private let greenColorSlider = UISlider()
    private let blueColorSlider = UISlider()
    private lazy var commentView = setupCommentView()

    let buttonsSV = UIStackView()
    let colorPaletteView = ColorPaletteView()

    private var value: Int = 0
    private var red: CGFloat = UIColor.systemGray6.rgba.red
    private var green: CGFloat = UIColor.systemGray6.rgba.green
    private var blue: CGFloat = UIColor.systemGray6.rgba.blue

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupView()
    }

    func updateUI() {
        updateValueLabel()
        updateCommentLabel(value: value)
    }

    // MARK: - UI setup
    private func setupView() {
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        commentView.isHidden = true
        colorPaletteView.isHidden = true

        setupIncrementButton()
        setupValueLabel()
        setupMenuButtons()
        setupColorControllersSV()
    }

    private func setupCommentView() -> UIView {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12

        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center

        commentView.addSubview(commentLabel)

        commentView.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: commentView.topAnchor, constant: 16),
            commentLabel.bottomAnchor.constraint(equalTo: commentView.bottomAnchor, constant: -16),
            commentLabel.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor, constant: -16),
        ])

        view.addSubview(commentView)

        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            commentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            commentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24)
        ])

        return commentView
    }

    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow()

        view.addSubview(incrementButton)
        incrementButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            incrementButton.topAnchor.constraint(equalTo: view.centerYAnchor),
            incrementButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24 ),
            incrementButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 24),
            incrementButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }

    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"

        view.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            valueLabel.bottomAnchor.constraint(equalTo: incrementButton.topAnchor, constant: -16),
            valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "📝")
        let newsButton = makeMenuButton(title: "📰")

        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)

        buttonsSV.addArrangedSubview(colorsButton)
        buttonsSV.addArrangedSubview(notesButton)
        buttonsSV.addArrangedSubview(newsButton)

        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually

        view.addSubview(buttonsSV)
        buttonsSV.translatesAutoresizingMaskIntoConstraints = false

        buttonsSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        buttonsSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        buttonsSV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true

    }

    private func setupColorControllersSV() {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 24),
            colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            colorPaletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor, constant: -24)
        ])
        colorPaletteView.addTarget(self, action: #selector(test(_:)), for: .touchDragInside)

    }

    @objc
    private func test(_ slider: ColorPaletteView) {
        self.view.backgroundColor = slider.chosenColor
    }

    // MARK: - Buttons creation
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true

        return button
    }

    private func makeColorController(colorName: String, colorSlider: UISlider) -> UIStackView {
        let colorLabel = UILabel()

        colorLabel.font = .systemFont(ofSize: 16, weight: .medium)
        colorLabel.textColor = .systemGray


        let colorControllerSV = UIStackView(arrangedSubviews: [colorLabel, colorSlider])
        colorControllerSV.spacing = 12
        colorControllerSV.axis = .horizontal
        colorControllerSV.alignment = .fill
        colorControllerSV.distribution = .fill
        colorControllerSV.backgroundColor = .white
        colorControllerSV.layer.cornerRadius = 12
        colorControllerSV.translatesAutoresizingMaskIntoConstraints = false
        colorControllerSV.heightAnchor.constraint(equalToConstant: 44).isActive = true

        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorSlider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            colorLabel.widthAnchor.constraint(equalToConstant: 48),
            colorLabel.leadingAnchor.constraint(equalTo: colorControllerSV.leadingAnchor, constant: 12),
        ])

        NSLayoutConstraint.activate([
            colorSlider.trailingAnchor.constraint(equalTo: colorControllerSV.trailingAnchor, constant: -40),
        ])

        switch colorName {
        case "red":
            colorSlider.minimumTrackTintColor = .red
            colorLabel.text = "Red"
            colorSlider.value = Float(red)
        case "green":
            colorSlider.minimumTrackTintColor = .green
            colorLabel.text = "Green"
            colorSlider.value = Float(green)
        case "blue":
            colorSlider.minimumTrackTintColor = .blue
            colorLabel.text = "Blue"
            colorSlider.value = Float(blue)
        default:
            break
        }

        colorSlider.addTarget(self, action: #selector(colorSliderDragged), for: .touchDragInside)

        return colorControllerSV
    }

    // MARK: - States update
    func updateValueLabel() {
        valueLabel.text = String(value)
    }

    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "Oh, you finally discovered how it works. Nice! Hope you enjoy your entartainment. Press it once again, bud)"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "🎉🎉🎉🎉🎉🎉🎉🎉🎉"
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70  moreeeee"
        case 70...80:
            commentLabel.text = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
        commentView.isHidden = false
    }

    // MARK: - Interactions
    @objc
    private func incrementButtonPressed() {
        value += 1

        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        UIView.animate(withDuration: 1, animations: {
            self.updateUI()})
    }

    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    @objc
    private func colorSliderDragged() {
        red = CGFloat(redColorSlider.value)
        green = CGFloat(greenColorSlider.value)
        blue = CGFloat(blueColorSlider.value)

        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
