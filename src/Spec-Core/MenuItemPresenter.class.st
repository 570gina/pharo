"
I represent a menu item.

You can also have a look at ApplicationWithToolbar for a full example of how to use them.

I collaborate with MenuGroupPresenter to manage me.

I provide the following variables and their accessors
- name is the text I display.
- icon is the text I display.
- description is the text I display in my tooltip.
- action is the action to perform when I am clicked.
- subMenu is the submenu to display when I am clicked.

Usually I do NOT have an action AND a submenu.

todo
- autoRefresh
- enabled
- fromSpec:
- performMenuActionWith:
- shortcut is ..., the shortcut is displayed near my name.
- state
"
Class {
	#name : #MenuItemPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'action',
		'name',
		'shortcut',
		'subMenu',
		'icon',
		'description',
		'state',
		'autoRefresh'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
MenuItemPresenter class >> adapterName [

	^ #MenuItemAdapter
]

{ #category : #accessing }
MenuItemPresenter >> action [

	^ action value
]

{ #category : #accessing }
MenuItemPresenter >> action: aBlock [

	action value: aBlock
]

{ #category : #accessing }
MenuItemPresenter >> autoRefresh [

	^ autoRefresh value
]

{ #category : #accessing }
MenuItemPresenter >> autoRefresh: aBlock [

	autoRefresh value: aBlock
]

{ #category : #api }
MenuItemPresenter >> description [

	^ description value
]

{ #category : #api }
MenuItemPresenter >> description: aString [

	description value: aString
]

{ #category : #'api-building' }
MenuItemPresenter >> fromSpec: aSpec [

	aSpec addToMenuItemModel: self
]

{ #category : #api }
MenuItemPresenter >> icon [

	^ icon value
]

{ #category : #api }
MenuItemPresenter >> icon: anIcon [

	icon value: anIcon
]

{ #category : #api }
MenuItemPresenter >> iconName: aSymbol [

	icon value: (self iconNamed: aSymbol)
]

{ #category : #initialization }
MenuItemPresenter >> initialize [

	super initialize.

	action := [ ] asValueHolder.
	state := nil asValueHolder.
	description := nil asValueHolder.
	name := '' asValueHolder.
	shortcut := nil asValueHolder.
	subMenu := nil asValueHolder.
	autoRefresh := false asValueHolder.
	icon := nil asValueHolder
]

{ #category : #testing }
MenuItemPresenter >> isMenuPresenter [

	^ true
]

{ #category : #api }
MenuItemPresenter >> name [

	^ name value
]

{ #category : #api }
MenuItemPresenter >> name: aString [

	name value: aString
]

{ #category : #api }
MenuItemPresenter >> performMenuActionWith: aMenuItem [
	| en |

	en := self isEnabled.
	en isBlock ifTrue: [ en := en value ].
	en ifFalse: [ ^ self ].

	action value cull: aMenuItem
]

{ #category : #accessing }
MenuItemPresenter >> rootMenu [ 
	
	^ self owner rootMenu
]

{ #category : #api }
MenuItemPresenter >> shortcut [

	^ shortcut value
]

{ #category : #api }
MenuItemPresenter >> shortcut: aShortcut [

	shortcut value: aShortcut
]

{ #category : #accessing }
MenuItemPresenter >> state [

	^ state value
]

{ #category : #accessing }
MenuItemPresenter >> state: aBoolean [

	state value: aBoolean
]

{ #category : #api }
MenuItemPresenter >> subMenu [

	^ subMenu value
]

{ #category : #api }
MenuItemPresenter >> subMenu: aMenuPresenter [

	aMenuPresenter ifNotNil: [  
		aMenuPresenter owner: self ].
	subMenu value: aMenuPresenter
]
