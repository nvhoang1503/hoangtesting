HoangTesting::Application.routes.draw do
  root 'home#index'
  get   "home/index"
  get   "user/register"
  post  "user/create"
  get   "user/login"
  post  "user/session_new"
  get   "user/session_destroy"
  post  "booking/create"
  get   "booking/show"
  get   "booking/yourbooking"
end
