import UIKit

class ColoursViewController: UIViewController {
    //MARK: UI Element

    private let scrollView = UIScrollView()
    private let selectColoursStackView = UIStackView()

    var selectedColours: [String] = []

    private let circleManager = ColouredCircleManager(colours: [
        ("Red", .systemRed),
        ("Yellow", .systemYellow),
        ("Green", .systemGreen),
        ("Indigo", .systemIndigo),
        ("Orange", .systemOrange),
        ("Purple", .systemPurple),
        ("Brown", .systemBrown),
        ("Cyan", .systemCyan)
    ])

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "PackChat iOS Test"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()

    private var recentlySelectedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Most Recently Selected"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        return label
    }()

    private var arrowLabel: UILabel = {
        let label = UILabel()
        label.text = "↓"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        return label
    }()

    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    //MARK: Methods

    private func initialSetup() {
        setupUIElements()
        setupConstraints()
        setupStackView()
        setupCircleManager()
    }

    private func setupUIElements() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(selectColoursStackView)
        view.addSubview(titleLabel)
        view.addSubview(recentlySelectedTitleLabel)
        view.addSubview(arrowLabel)
    }

    private func setupCircleManager() {
        circleManager.onCircleTapped = { [weak self] (colourName, colour) in
            self?.addColourToSelectedList(colourName)

            let coloursDetailViewController = ColoursDetailViewController()
            coloursDetailViewController.backgroundColor = colour
            coloursDetailViewController.colourName = colourName
            self?.navigationController?.pushViewController(coloursDetailViewController, animated: true)
        }

        circleManager.addColouredCircles(to: scrollView)
    }

    func addColourToSelectedList(_ colourName: String) {
        selectedColours.insert(colourName, at: 0)

        let selectedColourLabel = UILabel()
        selectedColourLabel.text = colourName
        selectedColourLabel.textAlignment = .center

        if let colour = circleManager.colour(forName: colourName) {
            selectedColourLabel.backgroundColor = colour
        }

        selectColoursStackView.insertArrangedSubview(selectedColourLabel, at: 0)
    }

    private func setupStackView() {
        selectColoursStackView.axis = .vertical
        selectColoursStackView.distribution = .fill
        selectColoursStackView.spacing = Constants.textSpacing
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        selectColoursStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        recentlySelectedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            recentlySelectedTitleLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 40),
            recentlySelectedTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recentlySelectedTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recentlySelectedTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            arrowLabel.topAnchor.constraint(equalTo: recentlySelectedTitleLabel.bottomAnchor, constant: 4),
            arrowLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrowLabel.heightAnchor.constraint(equalToConstant: 20),
            arrowLabel.widthAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.scrollViewLeadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.scrollViewTrailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: Constants.scrollViewHeightConstraint),

            selectColoursStackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Constants.stackViewTopAnchor),
            selectColoursStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            selectColoursStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

//MARK: - Constants

extension ColoursViewController {
    enum Constants {
        static let scrollViewHeightConstraint: CGFloat = 140
        static let scrollViewLeadingAnchor: CGFloat = 10
        static let scrollViewTrailingAnchor: CGFloat = -10
        static let stackViewTopAnchor: CGFloat = 100
        static let textSpacing: CGFloat = 10
        static let titleLabelFontSize: CGFloat = 24
    }
}
