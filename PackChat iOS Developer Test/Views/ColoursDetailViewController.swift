import UIKit

class ColoursDetailViewController: UIViewController {
    //MARK: UI Elements

    var backgroundColor: UIColor?
    var colourName: String?

    private let colourNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Colour Detail"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let pressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Press Me", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 4.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Methods

    private func configureUI() {
        view.backgroundColor = backgroundColor
        configureColourNameLabel()
        configurePressButton()
    }

    private func configureColourNameLabel() {
        colourNameLabel.text = colourName
        view.addSubview(colourNameLabel)

        NSLayoutConstraint.activate([
            colourNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colourNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configurePressButton() {
        pressButton.addTarget(self, action: #selector(pressButtonTapped), for: .touchUpInside)
        view.addSubview(pressButton)

        NSLayoutConstraint.activate([
            pressButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pressButton.topAnchor.constraint(equalTo: colourNameLabel.bottomAnchor, constant: 14),
            pressButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            pressButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
    }

    @objc private func pressButtonTapped() {
        // Do the button thing that it's supposed to do here Lucas !!
    }
}

extension ColoursDetailViewController {
    enum Constants {
        static let titleFontSize: CGFloat = 24
        static let buttonBorderWidth: CGFloat = 4
        static let buttonCornerRadius: CGFloat = 10
        static let pressButtonTopAnchor: CGFloat = 14
        static let pressButtonWidthAnchor: CGFloat = 0.5
        static let pressButtonHeightAnchor: CGFloat = 0.25
    }
}
