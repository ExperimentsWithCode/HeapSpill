json.extract! question, :id, :title, :body, :author_id, :created_at, :updated_at
json.author do
  json.extract! question.author, :id, :username
end
json.answers do
  json.array! question.answers, partial: 'api/answers/answer', as: :answer
end
