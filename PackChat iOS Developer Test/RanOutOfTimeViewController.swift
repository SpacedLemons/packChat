import UIKit

class RanOutOfTimeViewController: UIViewController {

    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I ran out of time lol"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        titleImageView.image = UIImage(named: "titleImage")

        view.addSubview(titleImageView)
        view.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImageView.widthAnchor.constraint(equalToConstant: 200),
            titleImageView.heightAnchor.constraint(equalToConstant: 50),

            messageLabel.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 16),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
