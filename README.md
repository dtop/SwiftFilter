# SwiftFilter

[![Build Status](https://travis-ci.org/dtop/SwiftFilter.svg)](https://travis-ci.org/dtop/SwiftFilter)
[![Compatibility](https://img.shields.io/badge/Swift-2.1-blue.svg)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/dtop/SwiftValidate/master/LICENSE)
[![codebeat badge](https://codebeat.co/badges/f380424d-a290-4d89-8b48-431da0bec33c)](https://codebeat.co/projects/github-com-dtop-swiftfilter)
[![codecov.io](https://codecov.io/github/dtop/SwiftFilter/coverage.svg?branch=master)](https://codecov.io/github/dtop/SwiftFilter?branch=master)
[![GitHub release](https://img.shields.io/github/release/dtop/SwiftFilter.svg)](https://github.com/dtop/SwiftFilter)

##### Chainable filters that can be applied to collections to filter (change / correct) form inputs

By [Danilo Topalovic](http://blog.danilo-topalovic.de).


* [Introduction]
* [Requirements]
* [Installation]
* [Usage]
* [Included Filters]
  + [Callback]
  + [CharCase]
  + [Replace]
  + [Trim]
  + [RegexReplace]
* [Extensibility]


## Introduction

When I wrote [SwiftValidate] I encountered some problems in form validation. A bunch of field values weren't really errorneous but needed to
be changed in some way.

Of course a validator should not change the value in any way so I decided to do another project with filtering.

Similar to [Zend\Filter] this also works with a filter chain which applies a bunch of filters to a single value.
I Use SwiftFilter along with [SwiftValidate] together with [Eureka].

## Requirements

* iOS 8.0+
* Xcode 7.0+

## Installation

[CocoaPods] not yet supported

[Carthage] should work with `github "dtop/SwiftFilter"`

## Usage

```swift

let inValue: String = "  \t \n  Some foo String   \t\t \n "

let chain = FilterChain()
	<~~ TrimFilter()
	<~~ ReplaceFilter {
		$0.replaceType = .ReplaceString(searchStr: "foo", replacementStr: "bar")
	}
	
do {

	let outValue: String? = chain.filter(inValue, nil)
	
} catch _ {

}

```


## Included Filters


#### CallbackFilter

Enables you to add a verry custom behavior to the filter chain by adding your callback which is executed on the value

**Configuration**

| value      |  type     | default | description                       |
|------------|:---------:|---------|-----------------------------------|
| `callback` |  closure  | !       | the callback you have to provide  |

**Parameters**

| input      | output    | explination |
|------------|-----------|-------------|
| `Any`      | `Any`     | -           |

----
#### CharCaseFilter

Allows to change the char case of the given string

**Configuration**

| value      |  type                   | default | description                                |
|------------|:-----------------------:|---------|--------------------------------------------|
| `charCase` |  `CharCaseFilter.Case`  | !       | .Lowercase, .Uppercase, .Ucfirst, .Ucwords |

**Parameters**

| input         | output       | explination              |
|---------------|--------------|--------------------------|
| `String`      | `String`     | only String is supported |          

----
#### ReplaceFilter

Allows to replace a String with another

**Configuration**

| value         |  type                   | default | description                                |
|---------------|:-----------------------:|---------|--------------------------------------------|
| `replaceType` |  `ReplaceFilter.Case`   | !       | @example see below |

```swift

	// searches and replaces all string occurences
	let filter = ReplaceFilter {
		$0.replaceType = .ReplaceString(searchStr: "foo", replacementStr: "bar")
	}

	// replaces a given range that is seered by advancements of stringIndex
	let filter = ReplaceFilter {
		$0.replaceType = .ReplaceRange(advStart: 0, advEnd: 3, replacementStr: "bar")
	}
	

```

**Parameters**

| input         | output       | explination              |
|---------------|--------------|--------------------------|
| `String`      | `String`     | only String is supported |

----
#### TrimFilter

Trims whitespace around the given String

**Configuration**

none

**Parameters**

| input         | output       | explination              |
|---------------|--------------|--------------------------|
| `String`      | `String`     | only String is supported |    

----
#### RegexReplaceFilter

Allows the replacement of a substring by regex pattern matching

**Configuration**

| value             |            type            | default | description                        |
|-------------------|:--------------------------:|---------|------------------------------------|
| `pattern`         |           String           | !       | the pattern to match against       |
| `options`         | NSRegularExpressionOptions | 0       | options for the regular expression |
| `matchingOptions` |      NSMatchingOptions     | 0       | options for the matching           |
| `replacement`     |           String           | !       | the replacement                    |

**Parameters**

| input         | output       | explination              |
|---------------|--------------|--------------------------|
| `String`      | `String`     | only String is supported |

## Extensibility 

Adding own filters that are working with the chain is quite easy

```swift

class MyFilter: FilterProtocol {
	
	var mySetting: String!
	
	required init(@noescape _ initialize: (RegexReplaceFilter) -> Void = { _ in }) {
        
       initialize(self)
   }
   
   func filter<I: Any, O: Any>(value: I?, _ context: [String: AnyObject]?) throws -> O? {
        
        // your filtering
   }
}

// can be used:

let chain = FilterChain()
	<~~ MyFilter {
		$0.mySetting = "foo"
	}

```

<!--- References -->

[Eureka]: https://github.com/xmartlabs/Eureka
[SwiftValidate]: https://github.com/dtop/SwiftValidate
[Zend\Filter]: https://github.com/zendframework/zend-filter
[CocoaPods]: https://cocoapods.org
[Carthage]: https://github.com/Carthage/Carthage

[Introduction]: #introduction
[Requirements]: #requirements
[Installation]: #installation
[Usage]: #usage
[Included Filters]: #included-filters
[Callback]: #callbackfilter
[CharCase]: #charcasefilter
[Replace]: #replacefilter
[Trim]: #trimfilter
[RegexReplace]: #regexreplacefilter
[Extensibility]: #extensibility
