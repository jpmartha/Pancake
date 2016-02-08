//
//  main.swift
//  pancake
//
//  Created by JPMartha on 2016/02/02.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import Commandant
import PancakeKit

let commands = CommandRegistry<PancakeError>()
commands.register(PancakeCommand())
//commands.register(PublicCommand())

let helpCommand = HelpCommand(registry: commands)
commands.register(helpCommand)

commands.main(defaultVerb: "help") { error in
    fputs("\(error)\n", stderr)
}