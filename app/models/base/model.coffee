Chaplin = require 'chaplin'

module.exports = class Model extends Chaplin.Model
	unsets:[]

	beforeSave:(attr)->
		@unset(u) for u in @unsets
		true
	save:()->
		@beforeSave()
		super
