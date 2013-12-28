class SearchController < ApplicationController

	#search for the Item by ID or NAME
	def search_result
		conditions = [] 
		conditions << "id = #{params[:item_id]}"  if params[:item_id].present?  &&  params[:item_id] != "Search By Item-Id:"
		conditions << "name = '%#{params[:item_name]}%'" if params[:item_name].present? && params[:item_name] != "Search By Item-name"
		
		@result = Item.where(conditions.join(" OR ")).limit(4)
	end
end
