//
//  ContactViewRouter.swift
//  Clean-swift-article
//
//  Created by Anton Marunko on 30/05/2018.
//  Copyright (c) 2018 exyte. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ContactViewRoutingLogic {
    func routeToEditContact(segue: UIStoryboardSegue?)
}

protocol ContactViewDataPassing {
    var dataStore: ContactViewDataStore? { get }
}

final class ContactViewRouter: NSObject, ContactViewRoutingLogic, ContactViewDataPassing {
    weak var viewController: ContactViewViewController?
    var dataStore: ContactViewDataStore?

    // MARK: - Routing

    func routeToEditContact(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! AddContactViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToEditContact(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Contact", bundle: .none)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "addContactControl") as! AddContactViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToEditContact(source: dataStore!, destination: &destinationDS)
            navigateToEditContact(source: viewController!, destination: destinationVC)
        }
    }

    // MARK: - Navigation

    func navigateToEditContact(source: ContactViewViewController, destination: AddContactViewController) {
        source.show(destination, sender: .none)
    }

    // MARK: - Passing data

    func passDataToEditContact(source: ContactViewDataStore, destination: inout AddContactDataStore) {
        destination.contact = source.contact
    }
}
