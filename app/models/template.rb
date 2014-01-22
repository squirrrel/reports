class Template < Sample
	include Mongoid::Document
	include Mongoid::Attributes::Dynamic #this is for extra fields dynamically set

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

		# template.rename(:old_name, :new_name) did not work for some reason :((
		def update_record params
			params[:collection].each do |_,v|
				template = find(params[:id])
				template.unset(v[0])
				template.update_attributes(v[1] => '')
			end
		end

		def find_by_ title
			template = find_by(title: title)
			JSON.parse(template.to_json).with_indifferent_access
		end
	end
end