require 'bson'
# RESEARCH: what if is it better to put all arbitrary properties + predefined once into and array
#  which be referenced by a single property? 
class Template
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
		def create_record params
			new_template = { title: params[:title] }
			params[:fields].split(",").each { |prop| new_template[prop] = '' }

			template = create!(new_template)

			unless params[:grid_title].empty? && params[:grid_columns].empty?
				new_grid = { 
					grid_title: params[:grid_title],
					grid_columns: params[:grid_columns].split(",") 
				}
				#params[:grid_columns].split(",").each { |prop| new_grid[prop] = '' }
				template.grids.create(new_grid)
			end
			template
		end

		def get_all
			collection = []
			all.each do |template|
				template_hash = JSON.parse(template.to_json).with_indifferent_access
				template_hash[:_id] = template.id.to_s
				collection << template_hash
			end
			collection
		end

		def delete_record id
			find(id).remove
		end

		# template.rename(:old_name, :new_name) did not work for some reason :((
		def update_record params
			params[:collection].each do |_,v|
				template = find(params[:id])
				template.unset(v[0])
				template.update_attributes(v[1] => '')
			end
		end
	end
end