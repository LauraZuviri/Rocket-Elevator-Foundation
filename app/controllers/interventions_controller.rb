require 'zendesk_api'


class InterventionsController < ApplicationController
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]

  # GET /interventions
  # GET /interventions.json
  def index
    @user = current_user
    @interventions = Intervention.all
    @customer = []
    @building = []
    @battery = []
    @column = []
    @elevator = []
  end

  # GET /interventions/1
  # GET /interventions/1.json
  def show
  end

  # GET /interventions/new
  def new
    @intervention = Intervention.new()
  end 
  
  def buildings_by_customer
    @building = Customer.where(customer_id: params[:selected_customer]).first.buildings
  end
  
  def buildings_for_customer
      puts "***********************************"
      puts "buildings_for_customer"
      puts params
      buildings = Customer.find(params["selected_customer"]).buildings
      puts buildings
      render json: buildings
  end

  def batteries_for_building
      puts "***********************************"
      puts "batteries_for_building"
      puts params
      batteries = Building.find(params["selected_building"]).batteries
      puts batteries
      render json: batteries
  end

  def columns_for_battery
      puts "***********************************"
      puts "columns_for_battery"
      puts params
      columns = Battery.find(params["selected_battery"]).columns
      puts columns
      render json: columns
  end

  def elevators_for_column
      puts "***********************************"
      puts "elevators_for_column"
      puts params
      elevators = Column.find(params["selected_column"]).elevators
      puts elevators
      render json: elevators
  end

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions
  # POST /interventions.json
  def create

    @intervention = Intervention.new(intervention_params)
    @intervention.author_id = current_user.employee.id

    zendesk_ticket_intervention(@intervention)

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to @intervention, notice: 'Intervention was successfully created.' }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interventions/1
  # PATCH/PUT /interventions/1.json
  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to @intervention, notice: 'Intervention was successfully updated.' }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1
  # DELETE /interventions/1.json
  def destroy
    @intervention.destroy
    respond_to do |format|
      format.html { redirect_to interventions_url, notice: 'Intervention was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def intervention_params
      params.require(:intervention).permit!
    end

    def zendesk_ticket_intervention(intervention)

      customer = intervention.customer
      customer_name = customer.business_name

      building = intervention.building

      employee = intervention.employee
      employee_name = (employee.first_name + " " + employee.last_name)

      comment = { :value => "#{current_user.first_name} #{current_user.last_name} requested a new intervention for #{customer_name}. \n \n There is a problem with the Building # #{intervention.building_id} \n Battery # #{intervention.battery_id} \n Column # #{intervention.column_id} \n Elevator # #{intervention.elevator_id} \n \n The employee #{employee_name} will cover the intervention based on the Report: \n #{intervention.report} "}
  
      ZendeskAPI::Ticket.create!($client, :type => 'task', :priority => "urgent",
      :subject => 'New Intervention',
      :comment => comment,
      :submitter_id => $client.current_user.token
      )
   end
end

