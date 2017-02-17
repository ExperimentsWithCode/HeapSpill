class Api::QuestionsController < ApplicationController

	def create
		@question = Question.new(question_params)
		if @question.save
			render api_question_url
		else
			render json: @question.errors.full_messages, status: 422
		end
	end

	def update
		@question = Question.find(params[:id])
		if @question.update_attributes(question_params)
			render api_question_url
		else
			render json: @question.errors.full_messages, status: 422
		end
	end

	def index
		@questions = Question.all()
		render api_questions_url
		end
	end

	def show
		@question = Question.find(params[:id])
		unless @question.nil?
			render api_question_url
		else
			render json: @question.errors.full_messages, status: 422
		end
	end

	def destroy
		@question = Question.find(params[:id])
		if @question.destroy
			render api_question_url
		else
			render json: @question.errors.full_messages, status: 422
		end
	end

	private

	def question_params
		params.require(:question).permit(:id, :title, :body, :author_id, :created_at, :updated_at)
	end
end
