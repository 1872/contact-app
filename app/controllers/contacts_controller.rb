class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def new
  end

  def create
    address = params[:address]
    if address == ""
      address = "2413 S Western Ave, Chicago, IL, 60608"
    end
    coordinates = Geocoder.coordinates(address)

    Contact.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      latitude: coordinates[0],
      longitude: coordinates[1],
      user_id: current_user.id
    )
  end

  def show
    @contact = Contact.find_by(id: params[:id])
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number]
    )
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
  end
end
