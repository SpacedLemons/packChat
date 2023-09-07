import UIKit

class ColoursDetailViewController: UIViewController {
    //MARK: UI Elements

    var backgroundColor: UIColor?
    var colourName: String?

    private let colourNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        return label
    }()

    private let pressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Press Me", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = Constants.buttonBorderWidth
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Methods

    private func setup() {
        view.backgroundColor = backgroundColor
        configureColourNameLabel()
        configurePressButton()
    }

    private func configureColourNameLabel() {
        colourNameLabel.text = colourName
        colourNameLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        view.addSubview(colourNameLabel)

        NSLayoutConstraint.activate([
            colourNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colourNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.colourNameTopAnchor)
        ])
    }

    private func configurePressButton() {
        pressButton.addTarget(self, action: #selector(pressButtonTapped), for: .touchUpInside)
        view.addSubview(pressButton)

        NSLayoutConstraint.activate([
            pressButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pressButton.centerYAnchor.constraint(equalTo: view.centerYAnchor), // Center the button vertically
            pressButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.pressButtonWidthAnchor),
            pressButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.pressButtonHeightAnchor)
        ])
    }

    @objc private func pressButtonTapped() {
        // Do the button thing that it's supposed to do here
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
        static let colourNameTopAnchor: CGFloat = 16
    }
}
