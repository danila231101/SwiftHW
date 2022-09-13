//
//  ColorPaletteView.swift
//  gmsosnovskiyPW2
//
//  Created by Danila Kokin on 16.07.2022.
//

import UIKit

final class ColorPaletteView: UIControl {
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .white

    init() {
        super.init(frame: .zero)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let redControl = ColorSliderView(colorName: "red", value: 0)
        let greenControl = ColorSliderView(colorName: "green", value: 0)
        let blueControl = ColorSliderView(colorName: "blue", value: 0)

        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2

        stackView.axis = .vertical
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)

        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)), for: .touchDragInside)
        }

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag {
        case 0:
            self.chosenColor = .white
        case 1:
            self.chosenColor = .blue
        default:
            self.chosenColor = .darkGray
        }
        sendActions(for: .touchDragInside)
    }
}

extension ColorPaletteView {
    private final class ColorSliderView: UIControl {
        private let stackView = UIStackView()
        private let slider = UISlider()
        private let colorLabel = UILabel()

        private(set) var value: Float

        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)

            slider.value = value
            colorLabel.text = colorName
            setupView()
            slider.addTarget(self, action: #selector(sliderMoved(_:)), for: .touchDragInside)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupView() {
            stackView.addArrangedSubview(colorLabel)
            stackView.addArrangedSubview(slider)
            stackView.axis = .horizontal

            addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
            ])
        }

        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
}
