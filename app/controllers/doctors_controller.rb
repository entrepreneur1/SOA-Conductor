require 'will_paginate/array'

class DoctorsController < ApplicationController
  # GET /doctors
  # GET /doctors.json
  def index
    page = params[:page] ? params[:page].to_i : 1
    query = extract_search_params
    paginated_query = query.merge(:limit => 20, :offset => (page-1)*20)
    @doctors = DoctorExt.addClinics(DoctorExt.all(paginated_query))
    total_count = DoctorExt.count(query)
    @pagination = WillPaginate::Collection.create(page || 1, 20, total_count) {}
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @doctors }
    end
  end

  # GET /doctors/1
  # GET /doctors/1.json
  def show
    @doctor = DoctorExt.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @doctor }
    end
  end

  # GET /doctors/new
  # GET /doctors/new.json
  def new
    @doctor = Doctor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @doctor }
    end
  end

  # GET /doctors/1/edit
  def edit
    @doctor = Doctor.find(params[:id])
  end

  # POST /doctors
  # POST /doctors.json
  def create
    @doctor = Doctor.new(params[:doctor])

    respond_to do |format|
      if @doctor.save
        format.html { redirect_to @doctor, notice: 'Doctor was successfully created.' }
        format.json { render json: @doctor, status: :created, location: @doctor }
      else
        format.html { render action: "new" }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /doctors/1
  # PUT /doctors/1.json
  def update
    @doctor = Doctor.find(params[:id])

    respond_to do |format|
      if @doctor.update_attributes(params[:doctor])
        format.html { redirect_to @doctor, notice: 'Doctor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.json
  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy

    respond_to do |format|
      format.html { redirect_to doctors_url }
      format.json { head :no_content }
    end
  end

  def working_hours
    start_time = Time.at(params[:start].to_i)
    end_time = Time.at(params[:end].to_i)
    times = ((start_time.to_date)..(end_time.to_date))
      .to_a
      .map { |date| WorkingTimeExt.workingHours(params[:id].to_i, date.to_date  )}
      .reject {|date| date.nil?}
    render json: times
  end

  def reservations
    start_time = Time.at(params[:start].to_i)
    end_time = Time.at(params[:end].to_i)
    times = ((start_time.to_date)..(end_time.to_date))
      .to_a
      .map { |date| ReservationExt.reservations(params[:id].to_i, date.to_date  )}
      .reject {|date| date.nil?}
    render json: times.flatten
  end

  private
  def extract_search_params
    query = {}
    return query unless search = params[:search]
    ["surname", "clinic_name", "city", "visit_duration_to", "visit_duration_from", "specialization_id"].each do |param_name|
      query[param_name] = search[param_name] if search[param_name] && !search[param_name].blank?
    end

    query
  end
end
