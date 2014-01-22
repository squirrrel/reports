# RESEARCH: what if is it better to put all arbitrary properties + predefined once into and array
#  which be referenced by a single property? 
class Sample
	include Mongoid::Document
	include Mongoid::Attributes::Dynamic #this is for extra fields dynamically set
	field :title,              type: String
	field :brief_description,  type: String, default: ->{ '' }
	field :reporter_name,      type: String, default: ->{ '' }
	field :reporter_phone,     type: String, default: ->{ '' }
	field :reporter_position,  type: String, default: ->{ '' }
	field :conclusions,        type: String, default: ->{ '' }
	field :submission_date,    type: String, default: ->{ '' }
	field :reviewer,           type: String, default: ->{ '' }
	field :created_at,         type: Time,   default: ->{ Time.now }
	embeds_many :grids

	validates :title, presence: true

	class << self
		def create_record
		end

		def update_record
		end

		def get_all(current_user: :admin)
			collection = [] 
			result_set = current_user == :admin ? (all) : (where(user_id: current_user))
			result_set.each do |item|
				item_hash = JSON.parse(item.to_json).with_indifferent_access
				item_hash[:_id] = item.id.to_s
				collection << item_hash
			end
			collection
		end

		def delete_record id
			find(id).remove
		end
	end
end