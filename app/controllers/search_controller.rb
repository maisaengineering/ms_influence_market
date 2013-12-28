class SearchController < ApplicationController

	#search for the Item by ID or NAME
	def search_result
		#conditions = []
		#conditions << "id = #{params[:item_id]}"  if params[:item_id].present?  &&  params[:item_id] != "Search By Item-Id:"
		#conditions << "name = '%#{params[:item_name]}%'" if params[:item_name].present? && params[:item_name] != "Search By Item-name"
		#
		#@result = Item.where(conditions.join(" OR ")).limit(4)

    #-------Comment about writing sql statements inside Rails
    # Building your own conditions as pure strings can leave you vulnerable to SQL injection exploits
    # because of argument safety. Putting the variable directly into the conditions string will pass the variable to the database as-is.
    # This means that it will be an unescaped variable directly from a user who may have malicious intent.
    # If you do this, you put your entire database at risk because once a user finds out he or she can exploit your database they can do just about anything to it.
    # Never ever put your arguments directly inside the conditions string.

    @result = Item.search(params).limit(4)
	end
end
