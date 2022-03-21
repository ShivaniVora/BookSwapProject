//
//  PrivacyViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/18/22.
//

import UIKit

class PrivacyViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    func setupScrollView(){
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           contentView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(scrollView)
           scrollView.addSubview(contentView)
           
           scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
           scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
           scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           
           contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
           contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
           contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
           contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
       }

    let privacy: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Privacy Policy"
        label.textColor = .label
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let firstPara: UILabel = {
        let label = UILabel()
        label.text = "Berwick Book Swap is owned by its licensors, which, through a third party service, is a data controller of your personal data.\n\nWe have adopted this Privacy Policy, which determines how we are processing the information collected by Berwick Book Swap, which also provides the reasons why we must collect certain personal data about you. Therefore, you must read this Privacy Policy before using Berwick Book Swap."
        label.textColor = .label
        label.numberOfLines = 0 // line wrap
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let info: UILabel = {
        let label = UILabel()
        label.text = "Personal information we collect"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondPara: UILabel = {
        let label = UILabel()
        label.text = "We might collect the personal data you provide to us including but not limited to your first name, last name, email, or phone number."
        label.textColor = .label
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    let data: UILabel = {
        let label = UILabel()
        label.text = "Why do we process your data?"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let thirdPara: UILabel = {
        let label = UILabel()
        label.text = "Our top priority is customer data security, and, as such, we may process only minimal user data, only as much as it is absolutely necessary to maintain the app. Information collected automatically is used only to identify potential cases of abuse and establish statistical information regarding app usage. This statistical information is not otherwise aggregated in such a way that it would identify any particular user of the system.\n\nYou can visit the app without telling us who you are or revealing any information, by which someone could identify you as a specific, identifiable individual. If, however, you wish to use some of the app’s features, you may provide personal data to us, such as your first name, last name, email, or phone number. You can choose not to provide us with your personal data, but then you may not be able to take advantage of some of the app’s features."
        label.textColor = .label
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    let dataUsage: UILabel = {
        let label = UILabel()
        label.text = "Third party data usage:"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fourthPara: UILabel = {
        let label = UILabel()
        label.text = "Our app maintains your data through third party services. Please be aware that we are not responsible for the privacy practices of such third parties."
        label.textColor = .label
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    let security: UILabel = {
        let label = UILabel()
        label.text = "Information security:"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fifthPara: UILabel = {
        let label = UILabel()
        label.text = "The security of your personal data is important to us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. We secure information you provide through third party services and, while we use commercially acceptable means to protect your personal data, we cannot guarantee its absolute security."
        label.textColor = .label
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    let disclosure: UILabel = {
        let label = UILabel()
        label.text = "Legal disclosure:"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sixthPara: UILabel = {
        let label = UILabel()
        label.text = "We will disclose any information we collect, use or receive if required or permitted by law, such as to comply with a subpoena or similar legal process, and when we believe in good faith that disclosure is necessary to protect our rights, protect your safety or the safety of others, investigate fraud, or respond to a government request.\n\n\n"
        label.textColor = .label
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    func setupViews(){
        contentView.addSubview(privacy)
        privacy.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        privacy.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        privacy.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
            
        contentView.addSubview(firstPara)
        firstPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        firstPara.topAnchor.constraint(equalTo: privacy.bottomAnchor, constant: 20).isActive = true
        firstPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(info)
        info.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        info.topAnchor.constraint(equalTo: firstPara.bottomAnchor, constant: 25).isActive = true
        info.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        
        contentView.addSubview(secondPara)
        secondPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        secondPara.topAnchor.constraint(equalTo: info.bottomAnchor, constant: 20).isActive = true
        secondPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(data)
        data.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        data.topAnchor.constraint(equalTo: secondPara.bottomAnchor, constant: 25).isActive = true
        data.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(thirdPara)
        thirdPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        thirdPara.topAnchor.constraint(equalTo: data.bottomAnchor, constant: 20).isActive = true
        thirdPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(dataUsage)
        dataUsage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        dataUsage.topAnchor.constraint(equalTo: thirdPara.bottomAnchor, constant: 25).isActive = true
        dataUsage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(fourthPara)
        fourthPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        fourthPara.topAnchor.constraint(equalTo: dataUsage.bottomAnchor, constant: 20).isActive = true
        fourthPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(security)
        security.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        security.topAnchor.constraint(equalTo: fourthPara.bottomAnchor, constant: 25).isActive = true
        security.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(fifthPara)
        fifthPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        fifthPara.topAnchor.constraint(equalTo: security.bottomAnchor, constant: 20).isActive = true
        fifthPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(disclosure)
        disclosure.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        disclosure.topAnchor.constraint(equalTo: fifthPara.bottomAnchor, constant: 25).isActive = true
        disclosure.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        
        contentView.addSubview(sixthPara)
        sixthPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        sixthPara.topAnchor.constraint(equalTo: disclosure.bottomAnchor, constant: 20).isActive = true
        sixthPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        sixthPara.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupViews()
    }

}
