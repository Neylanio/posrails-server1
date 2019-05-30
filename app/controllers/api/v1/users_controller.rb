module Api
	module V1
		class UsersController < ApplicationController
			# Listar todos os usuarios
			def index
				users = User.order('created_at DESC');
				
				#users = User.first
				#puts users.fullName

				render json: {status: 'SUCCESS', message:'Usuarios carregados', data:users},status: :ok
			end
			# Listar usuarios passando ID
			def show
				user = User.find(params[:id])
				render json: {status: 'SUCCESS', message:'Loaded user', data:user},status: :ok
			end
			# Criar um novo usuario
			def create
				
				user = User.new(user_params)
				
                if user.valid?

					begin

						result = user.fullName.split(" ")

						first = result[0]
						last = result[1]

						puts first + " " +last
						
						if !first.empty? && !last.empty?

							if user.save
								render json: {status: 'SUCCESS', message:'Saved user', data:user},status: :ok
							else
								render json: {status: 'ERROR', message:'User not saved', data:user.erros},status: :unprocessable_entity
							end
						end  

					rescue Exception => ex
						render json: {status: 'ERROR', message:'User not saved because fullname not complete'},status: :bad_request                            
					end	

				end    
				
			end
			# Excluir user
			def destroy
				user = User.find(params[:id])
				user.destroy
				render json: {status: 'SUCCESS', message:'Deleted user', data:user},status: :ok
			end
			# Atualizar um user
			def update
				user = User.find(params[:id])

				userAux = User.new(user_params)

                if userAux.valid?
					
					begin
						
						result = userAux.fullName.split(" ")

						first = result[0]
						last = result[1]

						puts first + " " +last
						
						if !first.empty? && !last.empty?

							if user.update_attributes(user_params)
								render json: {status: 'SUCCESS', message:'Updated user', data:user},status: :ok
							else
								render json: {status: 'ERROR', message:'User not update', data:user.erros},status: :unprocessable_entity
							end
						end  

					rescue Exception => ex
						render json: {status: 'ERROR', message:'User not updated because fullname not complete'},status: :bad_request                            
					end	

				end    

			end
			# Parametros aceitos
			private
			def user_params
				params.permit(:fullName, :birthData)
			end
		end
	end
end