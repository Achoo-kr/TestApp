//
//  CarPlaySceneDelegate.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/24.
//

import CarPlay


class CarPlaySceneDelegate: UIResponder  {

    var interfaceController: CPInterfaceController?

}

extension CarPlaySceneDelegate: CPTemplateApplicationSceneDelegate {

    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {

        self.interfaceController = interfaceController

        self.interfaceController?.delegate = self

    }

    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {

        self.interfaceController = nil

    }

}

extension CarPlaySceneDelegate: CPTabBarTemplateDelegate {

    func tabBarTemplate(_ tabBarTemplate: CPTabBarTemplate, didSelect selectedTemplate: CPTemplate) {



    }

}

extension CarPlaySceneDelegate: CPInterfaceControllerDelegate {

    func templateWillAppear(_ aTemplate: CPTemplate, animated: Bool) {

        print("templateWillAppear", aTemplate)

    }



    func templateDidAppear(_ aTemplate: CPTemplate, animated: Bool) {

        print("templateDidAppear", aTemplate)

    }



    func templateWillDisappear(_ aTemplate: CPTemplate, animated: Bool) {

        print("templateWillDisappear", aTemplate)

    }



    func templateDidDisappear(_ aTemplate: CPTemplate, animated: Bool) {

        print("templateDidDisappear", aTemplate)

    }

}
