class Grid
	include Mongoid::Document
	include Mongoid::Attributes::Dynamic
	embedded_in :template
end