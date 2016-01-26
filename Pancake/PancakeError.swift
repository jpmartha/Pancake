//
//  PancakeError.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/26.
//  Copyright © 2016 JPMartha. All rights reserved.
//

public enum ConvertError<T>: ErrorType {
    case ConvertToKindError(T)
    case ConvertToDeclarationError(T)
    case ConvertToNameError(T)
    case ConvertToAccessibilityError(T)
    case ConvertToSubstructureError(T)
    case ConvertToDictionary(T)
}

public enum MismatchError<T>: ErrorType {
    case MismatchKindError(T)
}
