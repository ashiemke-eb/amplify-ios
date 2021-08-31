//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify

extension Array where Element: Model {
    mutating func sortModels(by sortBy: QuerySortBy, modelSchema: ModelSchema) {
        sort { modelSchema.comparator(model1: $0, model2: $1, sortBy: sortBy) }
    }
}

extension ModelSchema {

    // > is descending
    // < is ascending
    // swiftlint:disable:next cyclomatic_complexity
    func comparator(model1: Model,
                    model2: Model,
                    sortBy: QuerySortBy) -> Bool {
        let fieldName = sortBy.fieldName
        guard let value1 = model1[fieldName],
              let value2 = model2[fieldName] else {
            return false
        }
        let sortOrder = sortBy.fieldOrder

        guard let modelField = field(withName: fieldName) else {
            return false
        }

        switch modelField.type {
        case .string:
            if modelField.isRequired {
                guard let value1 = value1 as? String, let value2 = value2 as? String else {
                    return false
                }
                return sortOrder == .ascending ? value1 < value2 : value1 > value2
            } else {
                guard let value1Optional = value1 as? String?, let value2Optional = value2 as? String? else {
                    return false
                }
                if value1Optional == nil && value2Optional != nil {
                    return sortOrder == .ascending ? true : false
                } else if value1Optional != nil && value2Optional == nil {
                    return sortOrder == .descending
                } else if let value1 = value1Optional, let value2 = value2Optional {
                    return sortOrder == .ascending ? value1 < value2 : value1 > value2
                } else {
                    return false
                }
            }

        case .int:
            if modelField.isRequired {
                guard let value1 = value1 as? Int, let value2 = value2 as? Int else {
                    return false
                }
                return sortOrder == .ascending ? value1 < value2 : value1 > value2
            } else {
                guard let value1Optional = value1 as? Int?, let value2Optional = value2 as? Int? else {
                    return false
                }
                if value1Optional == nil && value2Optional != nil {
                    return sortOrder == .ascending ? true : false
                } else if value1Optional != nil && value2Optional == nil {
                    return sortOrder == .descending
                } else if let value1 = value1Optional, let value2 = value2Optional {
                    return sortOrder == .ascending ? value1 < value2 : value1 > value2
                } else {
                    return false
                }
            }
        case .double:
            guard let value1 = value1 as? Double, let value2 = value2 as? Double else {
                return false
            }
            if sortOrder == .ascending {
                return value1 < value2
            } else {
                return value1 > value2
            }
        case .date:
            guard let value1 = value1 as? Temporal.Date, let value2 = value2 as? Temporal.Date else {
                return false
            }
            if sortOrder == .ascending {
                return value1 < value2
            } else {
                return value1 > value2
            }
        case .dateTime:
            guard let value1 = value1 as? Temporal.DateTime, let value2 = value2 as? Temporal.DateTime else {
                return false
            }
            if sortOrder == .ascending {
                return value1 < value2
            } else {
                return value1 > value2
            }
        case .time:
            guard let value1 = value1 as? Temporal.Time, let value2 = value2 as? Temporal.Time else {
                return false
            }
            if sortOrder == .ascending {
                return value1 < value2
            } else {
                return value1 > value2
            }
        case .timestamp:
            guard let value1 = value1 as? String, let value2 = value2 as? String else {
                return false
            }
            if sortOrder == .ascending {
                return value1 < value2
            } else {
                return value1 > value2
            }
        case .bool:

            if modelField.isRequired {
                guard let value1 = value1 as? Bool, let value2 = value2 as? Bool else {
                    return false
                }
            } else {
                guard let value1 = value1 as? Bool, let value2 = value2 as? Bool else {
                    return false
                }
                return false
            }

        case .enum(let enumType):
            guard let value1 = (value1 as? EnumPersistable)?.rawValue,
                  let value2 = (value2 as? EnumPersistable)?.rawValue else {
                return false
            }
            return sortOrder == .ascending ? value1 < value2 : value1 > value2
        case .embedded(let type, let schema):
            // Behavior is undefined
            return false
        case .model(let name):
            // Behavior is undefined
            return false
        case .collection(let modelName):
            // Behavior is undefined
            return false
        case .embeddedCollection(let of, let schema):
            // Behavior is undefined
            return false
        }
        return false
    }

}
