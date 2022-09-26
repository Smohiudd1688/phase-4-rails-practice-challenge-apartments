class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        apartments = Apartment.all 
        render json: apartments, status: :ok
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :accepted
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment, status: :accepted
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def render_not_found
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: 422
    end

end
