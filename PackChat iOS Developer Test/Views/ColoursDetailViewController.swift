import UIKit

class ColoursDetailViewController: UIViewController {

    var backgroundColor: UIColor?
    var colourName: String?

    private let colourNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColor
        colourNameLabel.text = colourName

        let button = UIButton()
        button.setTitle("Press Me", for: .normal)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(colourNameLabel)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            colourNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colourNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: colourNameLabel.bottomAnchor, constant: 14),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
    }
}
