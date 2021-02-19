# app/services/application_service.rb
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end

## use call in the controller
# class TweetController < ApplicationController
#   def create
#     TweetCreator.call(params[:message])
#   end
# end
