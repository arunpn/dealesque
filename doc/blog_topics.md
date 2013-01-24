# TODO Secrets & Heroku
  Amazon credentials and secret token, describe how to load from environment or yaml
  http://biggestfool.tumblr.com/post/24049554541/reminder-secret-token-rb-is-named-so-for-a-reason

# TODO Hardcoding Class name
  * Ruby Rogues Parley topic
  * Hexagonal - I guess it's OK when injecting from outside in (SearchResponse parser)

# TODO Structure of app, new folders (services, values, ... even lib) and how to autoload them in Rails and specs

# TODO Vacuum vs ASIN gems for accessing Amazon Product Advertising API - cover search and add to Cart

# TODO Parsing XML and JSON with the same Roar representer

# TODO XML parsing Roar limitations

# TODO Value object defaults and how this helps out of sync session data (represent from old version of object)

# TODO Sany Metz rules, Sonar Uncle Bob Use Case Driven etc.

Sandi Metz’ rules for developers
	1.	Your class can be no longer than a hundred lines of code.
	2.	Your methods can be no longer than five lines of code
	3.	You can pass no more than four parameters and you can't just make it one big hash.
	4.	In your controller, you can only instantiate one object, to do whatever it is that needs to be done.
	5.	Your view can only know about one instance variable.
  6.  Your Rails view should only send messages to that object i.e., no Demeter violations.[  "thunder dome principal". Translated: one model in, one model out! ]
  7.  Rules are meant to be broken if by breaking them you produce better code. [ ...where "better code" is validated by explaining why you want to break the rule to someone else. ]

Sandi Metz' three (sic) rules of testing
	1.	Make assertions about state for incoming messages.
	2.	Make assertions that you send outgoing messages. [Only do #2 for outgoing /command/ messages.  Don't bother testing query methods at all, though you may need to stub those to make your tests work right.]
	3.	Ignore private methods.
  4.  Test roles.  Make tests prove they are playing the correct role (and not just testing the mock / double)

The idea is to follow the rules, see where it leads

# Published

In memory session store for Rails 3
Deploying Rails with Twitter Bootstrap on Heroku
Amazon API integration tests with VCR - how to circumvent the request signing (timestamp, etc.)
Nokogiri vs Crack & Hashie, code style and performance