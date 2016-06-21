Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'registrarse'}
  get 'user/cursos', to: 'users#myCourses', as: 'users_courses'
  get 'users', to: 'users#index', as: 'users_index'
  get 'users/:id/rol', to: 'users#rol', as: 'users_change_rol'
  get 'users/:id/asignar_curso', to: 'users#assign', as: 'users_assign_course'
  patch 'users/:id/asignacion_curso', to: 'users#do_assign', as: 'users_do_assign'
  get 'users/:id/desasignar_curso', to: 'users#unassign', as: 'users_unassign_course'
  patch 'users/:id/desasignacion_curso', to: 'users#do_unassign', as: 'users_do_unassign'

  get 'schedules/new' => 'schedules#new'
  get 'schedules/deleteAssignation' => 'schedules#deleteAssignation'
  get 'schedules/deleteAssignation/do'=> 'schedules#deleteAssignationDo'
  post 'schedules/create' => 'schedules#create'

  get 'asignaciones'          => 'assignations#select'
  get 'asignaciones/ver'      => 'assignations#show'
  get 'asignaciones/generar'  => 'assignations#generate'
  get 'asignaciones/manual'   => 'assignations#manual_select'
  get 'asignaciones/manual/do'=> 'assignations#manual_do'



  #devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#main'

  get 'json/downloadCourses' => 'json#downloadCourses'
  get 'json/downloadClassrooms' => 'json#downloadClassrooms'
  get 'json/downloadSchedules' => 'json#downloadSchedules'
  get 'json/databaseLoad' => 'json#databaseLoad'


  get 'consultas'             => 'consults#index'
  get 'consultas/sala/curso'  => 'consults#classroomByCourseOrSchedule'
  get 'consultas/curso/sala'  => 'consults#courseByClassroomAndSchedule'
  get 'salas/informacion'     => 'consults#show_information'


  get 'estadisticas/'  => 'statistics#show'


  #get 'json/asignacion' => 'json#asignacion'
  #get 'json/showAssignation' => 'json#showAssignation'
  #get 'json/assignationAlgorithm' => 'json#assignationAlgorithm'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
