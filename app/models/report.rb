class Report < Sample
	include Mongoid::Document
	include Mongoid::Attributes::Dynamic #this is for extra fields dynamically set

	field :user_id, type: String

	validates :user_id, presence: true

	class << self
		def create_record params
			create!(params)
		end
	end
end