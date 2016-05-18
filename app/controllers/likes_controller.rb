class LikesController < ApplicationController
	def create

		like = Like.new(user_id: session[:user_id], secret_id: params[:secret_id])
		
		if like.save
			redirect_to :back
		else
			flash[:error] = "Your like didn't go through!"
			redirect_to "/users/#{session[:user_id]}"
		end
	end

	def destroy
		like = User.find(session[:user_id]).likes.where(secret_id:"#{params[:id]}").last
		like.destroy if like != nil

		redirect_to :back		
	end

end
