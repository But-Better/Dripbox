# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show; end

  def new
    @tags = Tag.all
  end

  def edit; end

  def create
    @tags.new(tag_params).save
  end

  private

  def set_tags
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit :name
  end
end
