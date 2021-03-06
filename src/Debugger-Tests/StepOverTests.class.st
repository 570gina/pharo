Class {
	#name : #StepOverTests,
	#superclass : #DebuggerTests,
	#category : #'Debugger-Tests'
}

{ #category : #helper }
StepOverTests >> step1 [
	self step2.
]

{ #category : #helper }
StepOverTests >> step2 [
	[ self step3 ] on: Notification do: [ ^2 ].
]

{ #category : #helper }
StepOverTests >> step3 [
	self step4.
	^4
]

{ #category : #helper }
StepOverTests >> step4 [
	self notify: 'hey'
]

{ #category : #helper }
StepOverTests >> stepA1 [
	self stepA2.
	^ 42.
]

{ #category : #helper }
StepOverTests >> stepA2 [
	^ True
]

{ #category : #helper }
StepOverTests >> stepB1 [
	self stepB2.
	^42.
]

{ #category : #helper }
StepOverTests >> stepB2 [
	self stepB3
]

{ #category : #helper }
StepOverTests >> stepB3 [
	^ 42
]

{ #category : #tests }
StepOverTests >> stepC1 [
	self stepC2.
]

{ #category : #tests }
StepOverTests >> stepC2 [
	1+1.
	^ 2
]

{ #category : #tests }
StepOverTests >> testErrorSignalledDuringStepOverShouldBeCaught [
	"An Error signaled while being steppedOver should not be unhandled"
	self settingUpSessionAndProcessAndContextForBlock: [ Error signal: 'hey'. ].
	self shouldnt: [[ session interruptedProcess isTerminated ] whileFalse: [ session stepOver. ]] raise: Error.
]

{ #category : #tests }
StepOverTests >> testStepOver [
	"Stepping over a message node brings the execution to the next node in the same method."
	| node |
	self settingUpSessionAndProcessAndContextForBlock: [ self stepA1 ].
	session stepInto.
	session stepInto.
	"Reached stepA1"
	"Checking that the execution is at the 'self stepA2' node of the stepA1 method"
	self assert: session interruptedContext method equals: self class >>#stepA1.
	node := self class >>#stepA1 sourceNodeForPC: session interruptedContext pc.
	self assert: node receiver isSelf.
	self assert: node selector equals: #stepA2.
	session stepOver.
	"Checking if the stepOver stepped over the call to stepA2 and brought the execution to the return node of stepA1"
	self assert: session interruptedContext method equals: self class >>#stepA1.
	self assert: (self class>>#stepA1 sourceNodeForPC: session interruptedContext pc) isReturn.
]

{ #category : #tests }
StepOverTests >> testStepOverComputedReturn [
	"When doing a stepOver on a return node whose return value is already computed, the current context returns and the session goes to the message node responsible for the context that just returned" 
	"<-> indicates the node being executed
	Initial situation:
		#stepC2
			1+1
			<^2> 
		#stepC1
			<self stepC2>
	After a StepOver:
		#stepC1
			<self stepC2>
	"
	| node |
	self settingUpSessionAndProcessAndContextForBlock: [ self stepC1 ].
	session stepInto.	session stepInto.
	"Reached stepC1"
	self assert: session interruptedContext method equals: self class >>#stepC1.
	session stepInto.
	"Reached stepC2"
	self assert: session interruptedContext method equals: self class >>#stepC2.
	session stepInto.
	"Reached ^2 node of stepC2"
	self assert: session interruptedContext method equals: self class >>#stepC2.
	self assert: (self class>>#stepC2 sourceNodeForPC: session interruptedContext pc) isReturn.
	session stepOver.
	"The initial step done by stepOver should return the stepC2 context, ending the stepOver in the stepC1 context, on the 'self stepC2' node"
	self assert: session interruptedContext method equals: self class >>#stepC1.
	node := self class >>#stepC1 sourceNodeForPC: session interruptedContext pc.
	self assert: node receiver isSelf.
	self assert: node selector equals: #stepC2.
]

{ #category : #tests }
StepOverTests >> testStepOverDoesNotUnderstand [
	"Stepping over a message not understood should not raise an unhandled exception"
	self settingUpSessionAndProcessAndContextForBlock: [ self messageNotUnderstood].
	self shouldnt: [[ session interruptedProcess isTerminated ] whileFalse: [ session stepOver. ]] raise: Exception.
]

{ #category : #tests }
StepOverTests >> testStepOverHalt [
	"Stepping over a self halt should not raise an unhandled exception"
	self settingUpSessionAndProcessAndContextForBlock: [ self halt. ].
	self shouldnt: [[ session interruptedProcess isTerminated ] whileFalse: [ session stepOver. ]] raise: Exception.
]

{ #category : #tests }
StepOverTests >> testStepOverLastNodeOfContext [
	"Stepping over the last node of a method brings the execution to the method node of that method."
	| node |
	self settingUpSessionAndProcessAndContextForBlock: [ self stepB1 ].
	session stepInto.
	session stepInto.
	"Reached stepB1"
	session stepInto.
	"Reached stepB2"
	"Checking that the execution is at the 'self stepB3' node of the stepB2 method"
	self assert: session interruptedContext method equals: self class >>#stepB2.
	node := self class >>#stepB2 sourceNodeForPC: session interruptedContext pc.
	self assert: node receiver isSelf.
	self assert: node selector equals: #stepB3.
	session stepOver.
	"Checking that after the stepOver, the execution is at the method node of the stepB2 method"
	self assert: session interruptedContext method equals: self class >>#stepB2.
	node := self class >>#stepB2 sourceNodeForPC: session interruptedContext pc.
	self assert: node isMethod.
]

{ #category : #tests }
StepOverTests >> testStepOverNonErrorExceptionSignalWithHandlerDeeperInTheContextStack [
	"Context stack (from top to bottom) of the execution:
	self step4 | signal a Notification exception
	self step3 | just calls step 4. Point at which this test performs the stepOver
	self step2 | has a handler for Notification exceptions
	self step1 | just calls step2
	
	When doing a stepOver at step3, the session jumps to step1.
	The Notification exception was used because it is an exception that is not a subclass of Error, and iis therefore not caught by the handler context stepOver inserts between step2 and 3 (which handles Error)
	"
	self settingUpSessionAndProcessAndContextForBlock: [ self step1 ].
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	session stepInto.
	"Reached the beginning of the step3 method call. Now doing a stepOver"
	session stepOver.
	"The DebugSession jumped to the step1 method call"
	self assert: session interruptedContext method equals: self class >>#step1
]
