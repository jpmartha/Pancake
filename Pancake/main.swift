//
//  main.swift
//  Pancake
//
//  Created by JPMartha on 2016/02/01.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import Commandant

let commands = CommandRegistry<PancakeError>()
commands.register(PancakeCommand())
