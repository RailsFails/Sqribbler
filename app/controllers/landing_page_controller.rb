class LandingPageController < ApplicationController
    def index
        #@user = User.find(params[:id])


         @search = User.where("username like ?", "%#{params[:search]}%")
        file_path = Rails.root.join('test_data.json')
        test_data = JSON.load file_path
        @results = test_data

        unless params[:search].blank?
            @results = []
            search_query = params[:search].downcase
            test_data.each_with_index do |item, i|
                if item['title'].downcase.include?(search_query)
                    @results.push(item)
                end
            end
        end
        # limit how many results to include
        @results = @results.first(13)

    end
end
