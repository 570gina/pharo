Extension { #name : #SMTPClient }

{ #category : #'*Network-Mail' }
SMTPClient class >> deliver: aMailMessage usingServer: aString [
	"See comment for #deliverMailFrom:to:text:usingServer:"
	
	self deliverMailFrom: aMailMessage from to: aMailMessage recipientList text: aMailMessage text usingServer: aString.
]