"
This test checks dependencies in the image and proves that there are no new unknown dependencies between packages.

It is not a standard unit test because to compute dependencies takes a lot of time. It uses cached version of the dependenices report.

"
Class {
	#name : #SystemDependenciesTest,
	#superclass : #TestCase,
	#classInstVars : [
		'dependenciesReport'
	],
	#category : #'System-DependenciesTests'
}

{ #category : #accessing }
SystemDependenciesTest class >> dependenciesReport [

	^ dependenciesReport ifNil: [ self rebuildDependenciesReport ]

]

{ #category : #accessing }
SystemDependenciesTest class >> rebuildDependenciesReport [

	dependenciesReport := DADependencyChecker new computeImageDependencies.
	^ dependenciesReport
]

{ #category : #accessing }
SystemDependenciesTest class >> resetDependenciesReport [
	<script>
	"self resetDependenciesReport"

	dependenciesReport := nil
]

{ #category : #accessing }
SystemDependenciesTest >> dependenciesReport [

	^ self class dependenciesReport

]

{ #category : #accessing }
SystemDependenciesTest >> externalDependendiesOf: packagesCollection [

	| dependencies | 
	
	dependencies := packagesCollection flatCollect: [ :aPackage | self dependenciesReport dependenciesOf: aPackage ] as: Set.
	
	dependencies := dependencies copyWithoutAll: packagesCollection.
	
	^ dependencies sorted
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownBasicToolsDependencies [

	"ideally this list should be empty"	

	^ #('AST-Core-Tests' 'Athens-Cairo' 'Athens-Core' "Those are added for the development of Spec2 and should probably be removed"
	#'Athens-Morphic' 'Glamour-Morphic-Widgets' #NautilusRefactoring #'Refactoring-Critics' #'Reflectivity-Tools' #Shout #'Tool-Catalog' 'ParametrizedTests') sorted
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownCompilerDependencies [

	"ideally this list should be empty"	

	^ #(#DeprecatedFileStream #'FileSystem-Core' #Monticello #'Ring-Deprecated-Core-Kernel' #'System-Changes' #'System-Localization' #'Transcript-Core')
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownDisplayDependencies [

	"ideally this list should be empty"	

	^ #(#'Fonts-Abstract' #'Graphics-Canvas' #'Graphics-Files' #'Network-Mail' #'Polymorph-Widgets' #'SUnit-Core' #'System-Localization' #'Transcript-Core')
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownFileSystemDependencies [

	"ideally this list should be empty"	

	^ #(#Monticello #'Ring-Deprecated-Core-Kernel' #'System-Changes' #'System-Localization' #'Transcript-Core' #'Zinc-Resource-Meta-Core')
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownIDEDependencies [

	"ideally this list should be empty"	

	^ #()
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownKernelDependencies [

	"ideally this list should be empty"	

	^ #(#CodeExport #CodeImport #CodeImportCommandLineHandlers #DeprecatedFileStream #'FileSystem-Core' #Monticello #'OpalCompiler-Core' #'Ring-Deprecated-Core-Kernel' #'System-Changes' #'System-Localization' #'AST-Core' #'Collections-Arithmetic' #Jobs #'Transcript-Core') sorted
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownLocalMonticelloDependencies [

	"ideally this list should be empty"	

	^ #(#'System-Localization' #'Transcript-Core')
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownMetacelloDependencies [

	"ideally this list should be empty"	

	^ #(#'Fonts-Abstract' #'Graphics-Files' #'Network-Mail' #'SUnit-Core' #'System-Localization' #'Transcript-Core')
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownMonticelloDependencies [

	"ideally this list should be empty"	

	^ #(#'Graphics-Files' #'Network-Mail' #'System-Localization' #'Transcript-Core')
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownMorphicCoreDependencies [

	"ideally this list should be empty"	

	^ #(#'Fonts-Abstract' #'Graphics-Files' #'Keymapping-KeyCombinations' #'Morphic-Base' #'Morphic-Widgets-Windows' #'Network-Mail' #'Polymorph-Widgets' #'Refactoring-Critics' #'Refactoring-Environment' #'System-Clipboard' #'System-Localization' #'Transcript-Core')
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownMorphicDependencies [
	"ideally this list should be empty"

	^ #(#'Fonts-Chooser' #'Network-Mail' #RecentSubmissions #'Refactoring-Critics' #'Refactoring-Environment' #Shout #'Spec-Core' #'Tool-Diff' #'Tool-FileList' #'Tool-Profilers'
	#'Athens-Morphic' 	"Rubric has a dependency on It" )
		sorted
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownSUnitDependencies [

	"ideally this list should be empty"	

	^ #(#'Fonts-Abstract' #'Graphics-Files' #'Network-Mail' #'Refactoring-Critics' #'Refactoring-Environment' #'System-Localization' #'Transcript-Core') sorted
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownSUnitKernelDependencies [

	"ideally this list should be empty"	

	^ #(#CodeExport #CodeImportCommandLineHandlers #DeprecatedFileStream #'FileSystem-Core' #Monticello #'OpalCompiler-Core' #'Ring-Deprecated-Core-Kernel' #'System-Changes' #'System-Localization' #Jobs #'AST-Core' #'Collections-Arithmetic' #'Transcript-Core' #CodeImport) sorted
]

{ #category : #'known-dependencies' }
SystemDependenciesTest >> knownSpecDependencies [
	
	^ #(
		'WebBrowser-Core' "Spec's Link adapter"
		'Keymapping-Settings' "Spec's KeymapBrowser example tool"
		) sorted
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownUFFIDependencies [

	"ideally this list should be empty"	

	^ #(#'Fonts-Abstract' #'Graphics-Files' #'Network-Mail' #'Refactoring-Critics' #'Refactoring-Environment' #'System-Localization' #'Transcript-Core')
]

{ #category : #'known dependencies' }
SystemDependenciesTest >> knownUIDependencies [

	"ideally this list should be empty"	

	^ #('AST-Core-Tests' 'Athens-Cairo' 'Athens-Core' "Those are added for the development of Spec2 and should probably be removed"
	#'Athens-Morphic' #'Glamour-Morphic-Widgets' #'Network-Mail' #RecentSubmissions #'Refactoring-Critics' #'Refactoring-Environment' #'Reflectivity-Tools' #Shout #'Tool-Diff' #'Tool-FileList' #'Tool-ProcessBrowser' #'Tool-Profilers') sorted
]

{ #category : #utilities }
SystemDependenciesTest >> longTestCase [

	self timeLimit: 60 seconds.

]

{ #category : #accessing }
SystemDependenciesTest >> metacelloPackageNames [

	^ BaselineOfPharoBootstrap kernelPackageNames,
	  BaselineOfPharoBootstrap compilerPackageNames,
	  BaselineOfPharoBootstrap fileSystemPackageNames,
	  BaselineOfPharoBootstrap multilingualPackageNames,
	  BaselineOfPharoBootstrap kernelAdditionalPackagesNames,
	  BaselineOfMonticello corePackageNames,
	  BaselineOfMonticello remoteRepositoriesPackageNames,
	  BaselineOfMetacello allPackageNames
]

{ #category : #tests }
SystemDependenciesTest >> testExternalBasicToolsDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		self metacelloPackageNames,
		self tonelCorePackageNames,
		BaselineOfTraits corePackages,
		{ BaselineOfSUnit name }, BaselineOfSUnit allPackageNames, "ALL"
		{ BaselineOfDisplay name }, BaselineOfDisplay allPackageNames,
		{ BaselineOfUnifiedFFI name }, BaselineOfUnifiedFFI allPackageNames,
		{ BaselineOfMorphicCore name }, BaselineOfMorphicCore allPackageNames,
		{ BaselineOfMorphic name }, BaselineOfMorphic allPackageNames,
		{ BaselineOfMenuRegistration name }, BaselineOfMenuRegistration allPackageNames,
		{ BaselineOfUI name }, BaselineOfUI allPackageNames,
		{ BaselineOfSpec name }, BaselineOfSpec allPackageNames,
		{ BaselineOfBasicTools name }, BaselineOfBasicTools allPackageNames ).
	
	self assertCollection: dependencies equals: self knownBasicToolsDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalCompilerDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		BaselineOfPharoBootstrap kernelPackageNames,
		BaselineOfPharoBootstrap multilingualPackageNames,
		BaselineOfPharoBootstrap kernelAdditionalPackagesNames,				
		BaselineOfPharoBootstrap compilerPackageNames).
	
	self assertCollection: dependencies equals: self knownCompilerDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalDisplayDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		self metacelloPackageNames,
		self tonelCorePackageNames,
		BaselineOfTraits corePackages,		
		BaselineOfDisplay allPackageNames).
	
	self assertCollection: dependencies equals: self knownDisplayDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalFileSystemDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		BaselineOfPharoBootstrap kernelPackageNames,
		BaselineOfPharoBootstrap multilingualPackageNames,
		BaselineOfPharoBootstrap kernelAdditionalPackagesNames,		
		BaselineOfPharoBootstrap compilerPackageNames,
		BaselineOfPharoBootstrap fileSystemPackageNames).
	
	self assertCollection: dependencies equals: self knownFileSystemDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalIDEDependencies [
	| dependencies packages |
	self longTestCase.
	packages := self metacelloPackageNames , self tonelCorePackageNames , { BaselineOfPharoBootstrap name. BaselineOfMonticello name. BaselineOfMetacello name}.

	{BaselineOfAthens.
	BaselineOfBasicTools.
	BaselineOfDisplay.
	BaselineOfFlashback.
	BaselineOfIDE.
	BaselineOfMenuRegistration.
	BaselineOfMorphic.
	BaselineOfMorphicCore.
	BaselineOfSlot.
	BaselineOfSpec.
	BaselineOfParametrizedTests.
	BaselineOfSUnit.
	BaselineOfTraits.
	BaselineOfUI.
	BaselineOfUnifiedFFI} do: [ :baseline | packages := packages , {baseline name} , baseline allPackageNames ].

	dependencies := self externalDependendiesOf: packages.
	self assertCollection: dependencies equals: self knownIDEDependencies
]

{ #category : #tests }
SystemDependenciesTest >> testExternalKernelDependencies [
	| dependencies |
	self longTestCase.

	dependencies := self
		externalDependendiesOf: BaselineOfPharoBootstrap kernelPackageNames , BaselineOfPharoBootstrap multilingualPackageNames, BaselineOfPharoBootstrap kernelAdditionalPackagesNames.

	self assertCollection: dependencies equals: self knownKernelDependencies
]

{ #category : #tests }
SystemDependenciesTest >> testExternalLocalMonticelloDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		BaselineOfTraits corePackages,	
		BaselineOfPharoBootstrap kernelPackageNames,
		BaselineOfPharoBootstrap compilerPackageNames,
		BaselineOfPharoBootstrap multilingualPackageNames,
		BaselineOfPharoBootstrap fileSystemPackageNames,
		BaselineOfPharoBootstrap kernelAdditionalPackagesNames,
		BaselineOfMonticello corePackageNames).
	
	self assertCollection: dependencies equals: self knownLocalMonticelloDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalMetacelloDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: self metacelloPackageNames, BaselineOfTraits corePackages.
	
	self assertCollection: dependencies equals: self knownMetacelloDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalMonticelloDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		BaselineOfTraits corePackages,		
		BaselineOfPharoBootstrap kernelPackageNames,
		BaselineOfPharoBootstrap multilingualPackageNames,
		BaselineOfPharoBootstrap compilerPackageNames,
		BaselineOfPharoBootstrap fileSystemPackageNames,
		BaselineOfPharoBootstrap kernelAdditionalPackagesNames,
		BaselineOfMonticello corePackageNames,
		BaselineOfMonticello remoteRepositoriesPackageNames).
	
	self assertCollection: dependencies equals: self knownMonticelloDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalMorphicCoreDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		self metacelloPackageNames,
		self tonelCorePackageNames,
		BaselineOfTraits corePackages,			
		BaselineOfSUnit defaultPackageNames,
		BaselineOfDisplay allPackageNames,
		BaselineOfUnifiedFFI allPackageNames,
		BaselineOfMorphicCore allPackageNames ).
	
	self assertCollection: dependencies equals: self knownMorphicCoreDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalMorphicDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		self metacelloPackageNames,
		self tonelCorePackageNames,
		BaselineOfTraits corePackages,
		BaselineOfSUnit defaultPackageNames,
		BaselineOfDisplay allPackageNames,
		BaselineOfUnifiedFFI allPackageNames,
		BaselineOfMorphicCore allPackageNames,
		BaselineOfMorphic allPackageNames,
		BaselineOfMenuRegistration allPackageNames ).
	
	self assertCollection: dependencies equals: self knownMorphicDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalSUnitDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		BaselineOfTraits corePackages,			
		self metacelloPackageNames,
		self tonelCorePackageNames,
		BaselineOfSUnit defaultPackageNames).
	
	self assertCollection: dependencies equals: self knownSUnitDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalSUnitKernelDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		BaselineOfTraits corePackages,
		BaselineOfPharoBootstrap kernelPackageNames,
		BaselineOfPharoBootstrap multilingualPackageNames,
		BaselineOfPharoBootstrap kernelAdditionalPackagesNames,
		BaselineOfPharoBootstrap sUnitPackageNames).
	
	self assertCollection: dependencies equals: self knownSUnitKernelDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalSpecDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := (self externalDependendiesOf: (
		"Language"
		self metacelloPackageNames,
		self tonelCorePackageNames,
		BaselineOfTraits corePackages,
		BaselineOfUnifiedFFI allPackageNames,

		"Morphic - for Morphic backend"
		BaselineOfDisplay allPackageNames,
		BaselineOfMorphicCore allPackageNames,
		BaselineOfMorphic allPackageNames,
		BaselineOfMenuRegistration allPackageNames,

		BaselineOfSpec allPackageNames,
	

		"Tests"
		BaselineOfSUnit defaultPackageNames,
		BaselineOfParametrizedTests allPackageNames))
			copyWithoutAll: self knownMorphicDependencies, self knownBasicToolsDependencies, self knownUIDependencies.

	self assertCollection: dependencies equals: self knownSpecDependencies
]

{ #category : #tests }
SystemDependenciesTest >> testExternalUFFIDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := self externalDependendiesOf: (
		self metacelloPackageNames,
		self tonelCorePackageNames,
		BaselineOfTraits corePackages,				
		BaselineOfSUnit defaultPackageNames,
		BaselineOfUnifiedFFI allPackageNames).
	
	self assertCollection: dependencies equals: self knownUFFIDependencies.
]

{ #category : #tests }
SystemDependenciesTest >> testExternalUIDependencies [

	| dependencies | 
	
	self longTestCase.
	
	dependencies := (self externalDependendiesOf: (
		self metacelloPackageNames,
		self tonelCorePackageNames,
		BaselineOfTraits corePackages,
		BaselineOfParametrizedTests allPackageNames,
		BaselineOfSUnit defaultPackageNames,
		BaselineOfDisplay allPackageNames,
		BaselineOfUnifiedFFI allPackageNames,
		BaselineOfMorphicCore allPackageNames,
		BaselineOfMorphic allPackageNames,
		BaselineOfSpec allPackageNames,
		BaselineOfUI allPackageNames,
		BaselineOfMenuRegistration allPackageNames )).
	
	self assertCollection: dependencies equals: self knownUIDependencies.
]

{ #category : #accessing }
SystemDependenciesTest >> tonelCorePackageNames [

	^ { BaselineOfTonel name }, (BaselineOfTonel packagesOfGroupNamed: #core)
]
