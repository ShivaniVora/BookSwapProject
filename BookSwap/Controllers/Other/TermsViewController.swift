//
//  TermsViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/18/22.
//

import UIKit

class TermsViewController: UIViewController {

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

        let terms: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.text = "Terms and Conditions"
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            return label
        }()
        
        let firstPara: UILabel = {
            let label = UILabel()
            label.text = "These terms and conditions outline the rules and regulations for the use of Berwick Book Swap.\n\nBy accessing this app, we assume you accept these terms and conditions. Do not continue to use Berwick Book Swap if you do not agree to all of the terms and conditions stated on this page."
            label.textColor = .label
            label.numberOfLines = 0 // line wrap
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let license: UILabel = {
            let label = UILabel()
            label.text = "License:"
            label.textColor = .label
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.numberOfLines = 1
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let secondPara: UILabel = {
            let label = UILabel()
            label.text = "Unless otherwise stated, Berwick Book Swap and/or its licensors own the intellectual property rights for all material on Berwick Book Swap. All intellectual property rights are reserved. You may access this from Berwick Book Swap for your own personal use subject to restrictions set in these terms and conditions.\n\nYou must not:"
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0 // line wrap
            return label
        }()
        
        let firstBullet: UILabel = {
            let label = UILabel()
            label.text = "\t- Copy or republish material from Berwick Book Swap"
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let secondBullet: UILabel = {
            let label = UILabel()
            label.text = "\t- Sell, rent, or sub-license material from Berwick Book Swap"
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let thirdBullet: UILabel = {
            let label = UILabel()
            label.text = "\t- Reproduce, duplicate or copy material from Berwick Book Swap"
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let fourthBullet: UILabel = {
            let label = UILabel()
            label.text = "\t- Redistribute content from Berwick Book Swap"
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let thirdPara: UILabel = {
            let label = UILabel()
            label.text = "This Agreement shall begin on the date hereof.\n\nParts of this app offer users an opportunity to post and exchange information in certain areas of the app. Berwick Book Swap does not filter, edit, publish or review content before their presence on the app. Content does not reflect the views and opinions of Berwick Book Swap, its agents, and/or affiliates. Content reflects the views and opinions of the person by whom it is posted. To the extent permitted by applicable laws, Berwick Book Swap shall not be liable for its content or any liability, damages, or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the content on this app.\n\nBerwick Book Swap reserves the right to monitor all content and remove any content that can be considered inappropriate, offensive, or causes breach of these Terms and Conditions.\n\nYou warrant and represent that:"
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0 // line wrap
            return label
        }()
        
        let fifthBullet: UILabel = {
            let label = UILabel()
            label.text = "\t- You are entitled to post content on our app and have all necessary consents to do so."
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let sixthBullet: UILabel = {
            let label = UILabel()
            label.text = "\t- The content does not invade any intellectual property right, including without limitation copyright, patent, or trademark of any third party."
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let seventhBullet: UILabel = {
            let label = UILabel()
            label.text = "\t- The content does not contain any defamatory, libelous, offensive, indecent, or otherwise unlawful material, which is an invasion of privacy."
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let eigthBullet: UILabel = {
            let label = UILabel()
            label.text = "\t- The content will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.\n\nYou hereby grant Berwick Book Swap a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your content in any and all forms, formats, or media."
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let liability: UILabel = {
            let label = UILabel()
            label.text = "Content Liability:"
            label.textColor = .label
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.numberOfLines = 1
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let fourthPara: UILabel = {
            let label = UILabel()
            label.text = "You should not assume that Berwick Book Swap is continually maintained. We shall not be held responsible for any content that appears on the app.\n\nWe do not ensure that the information on this app is correct. We do not warrant its completeness or accuracy, nor do we promise to ensure that the app remains available or that the material on the app is kept up to date."
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0 // line wrap
            return label
        }()
        
        let rights: UILabel = {
            let label = UILabel()
            label.text = "Reservation of Rights:"
            label.textColor = .label
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.numberOfLines = 1
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let fifthPara: UILabel = {
            let label = UILabel()
            label.text = "We reserve the right to amend these terms and conditions and its policies at any time. As a user of Berwick Book Swap, you agree to be bound to and follow these terms and conditions."
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0 // line wrap
            return label
        }()
        
        let removal: UILabel = {
            let label = UILabel()
            label.text = "Removal of content from our App:"
            label.textColor = .label
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.numberOfLines = 1
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let sixthPara: UILabel = {
            let label = UILabel()
            label.text = "If you find any content on our app that is offensive for any reason, you are free to contact and inform us at any moment. We will consider requests to remove content, but we are not obligated to do so or to respond to you directly."
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0 // line wrap
            return label
        }()
        
        let damages: UILabel = {
            let label = UILabel()
            label.text = "Liability of Damages:"
            label.textColor = .label
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.numberOfLines = 1
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let seventhPara: UILabel = {
            let label = UILabel()
            label.text = "As long as the app and the information and services on the app are provided free of charge, we will not be liable for any loss or damage of any nature.\n\n\n"
            label.textColor = .label
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0 // line wrap
            return label
        }()
        
        func setupViews(){
            contentView.addSubview(terms)
            terms.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            terms.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
            terms.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
                
            contentView.addSubview(firstPara)
            firstPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            firstPara.topAnchor.constraint(equalTo: terms.bottomAnchor, constant: 20).isActive = true
            firstPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(license)
            license.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            license.topAnchor.constraint(equalTo: firstPara.bottomAnchor, constant: 25).isActive = true
            license.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
            
            contentView.addSubview(secondPara)
            secondPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            secondPara.topAnchor.constraint(equalTo: license.bottomAnchor, constant: 20).isActive = true
            secondPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(firstBullet)
            firstBullet.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            firstBullet.topAnchor.constraint(equalTo: secondPara.bottomAnchor, constant: 10).isActive = true
            firstBullet.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(secondBullet)
            secondBullet.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            secondBullet.topAnchor.constraint(equalTo: firstBullet.bottomAnchor, constant: 10).isActive = true
            secondBullet.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(thirdBullet)
            thirdBullet.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            thirdBullet.topAnchor.constraint(equalTo: secondBullet.bottomAnchor, constant: 10).isActive = true
            thirdBullet.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(fourthBullet)
            fourthBullet.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            fourthBullet.topAnchor.constraint(equalTo: thirdBullet.bottomAnchor, constant: 10).isActive = true
            fourthBullet.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(thirdPara)
            thirdPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            thirdPara.topAnchor.constraint(equalTo: fourthBullet.bottomAnchor, constant: 20).isActive = true
            thirdPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(fifthBullet)
            fifthBullet.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            fifthBullet.topAnchor.constraint(equalTo: thirdPara.bottomAnchor, constant: 10).isActive = true
            fifthBullet.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(sixthBullet)
            sixthBullet.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            sixthBullet.topAnchor.constraint(equalTo: fifthBullet.bottomAnchor, constant: 10).isActive = true
            sixthBullet.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(seventhBullet)
            seventhBullet.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            seventhBullet.topAnchor.constraint(equalTo: sixthBullet.bottomAnchor, constant: 10).isActive = true
            seventhBullet.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(eigthBullet)
            eigthBullet.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            eigthBullet.topAnchor.constraint(equalTo: seventhBullet.bottomAnchor, constant: 10).isActive = true
            eigthBullet.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true

            contentView.addSubview(liability)
            liability.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            liability.topAnchor.constraint(equalTo: eigthBullet.bottomAnchor, constant: 25).isActive = true
            liability.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(fourthPara)
            fourthPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            fourthPara.topAnchor.constraint(equalTo: liability.bottomAnchor, constant: 20).isActive = true
            fourthPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(rights)
            rights.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            rights.topAnchor.constraint(equalTo: fourthPara.bottomAnchor, constant: 25).isActive = true
            rights.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(fifthPara)
            fifthPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            fifthPara.topAnchor.constraint(equalTo: rights.bottomAnchor, constant: 20).isActive = true
            fifthPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(removal)
            removal.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            removal.topAnchor.constraint(equalTo: fifthPara.bottomAnchor, constant: 25).isActive = true
            removal.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(sixthPara)
            sixthPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            sixthPara.topAnchor.constraint(equalTo: removal.bottomAnchor, constant: 20).isActive = true
            sixthPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(damages)
            damages.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            damages.topAnchor.constraint(equalTo: sixthPara.bottomAnchor, constant: 25).isActive = true
            damages.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            
            contentView.addSubview(seventhPara)
            seventhPara.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
            seventhPara.topAnchor.constraint(equalTo: damages.bottomAnchor, constant: 20).isActive = true
            seventhPara.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
            seventhPara.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            setupScrollView()
            setupViews()
        }

}
