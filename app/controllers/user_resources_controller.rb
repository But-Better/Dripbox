# frozen_string_literal: true

class UserResourcesController < ApplicationController
  # GET /user_resources or /user_resources.json
  def index
    @user = session[:user_id]
    redirect_to registrations_index_path if @user.nil?

    @user_resources = @user.user_resources
  end

  # GET /user_resources/1 or /user_resources/1.json
  def show
    @user_resource = UserResource.find(params[:id])
  end

  # GET /user_resources/new
  def new
    @user = session[:user_id]
    redirect_to registrations_index_path if @user.nil?

    @user_resource = UserResource.new
    @categories = Tag.all
  end

  # GET /user_resources/1/edit
  def edit
    @user_resource = UserResource.find(params[:id])
  end

  # POST /user_resources or /user_resources.json
  def create
    @user = session[:user_id]
    redirect_to registrations_index_path if @user.nil?

    tag_string = if params[:tag].nil?
                   ''
                 else
                   params[:tag]
                 end


    string_split = tag_string.split(',')
    tags = []

    string_split.each do |tag|
      tags[tags.length] = if !Tag.find_by(name: tag.strip).nil?
                            Tag.find_by(name: tag.strip)
                          else
                            Tag.create(name: tag.strip)
                          end
    end

    @user_resource = @user.user_resources.new user_resource_params

    @user_resource.tags = tags

    respond_to do |format|
      if @user_resource.save
        format.html { redirect_to @user_resource, notice: 'User resource was successfully created.' }
        format.json { render :show, status: :created, location: @user_resource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_resources/1 or /user_resources/1.json
  def update
    @user_resource = UserResource.find(params[:id])
    respond_to do |format|
      if @user_resource.update(user_resource_params)
        format.html { redirect_to @user_resource, notice: 'User resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_resources/1 or /user_resources/1.json
  def destroy
    UserResource.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to user_resources_url, notice: 'User resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_resource
    @user_resource = UserResource.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_resource_params
    params.require(:user_resource).permit(:name, :desc, :file)
  end
end
