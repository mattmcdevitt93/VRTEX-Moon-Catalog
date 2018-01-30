class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :admin_check, only: [:index, :show, :edit, :destroy, :update]


  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all.paginate(:page => params[:page], :per_page => 75).order(id: :desc)
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])
    # check = Entry.format_check(@entry[:content])
    @user = User.find(@entry.user)
    @report = Catalog.paginate(:page => params[:page], :per_page => 75).where('entry_id' => params[:id]).order(id: :asc)
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
      @entry = Entry.new(entry_params)
      respond_to do |format|
        if @entry.save
          format.html { redirect_to new_entry_path, notice: 'System Log was Created!' }
          format.json { render :show, status: :created, location: @entry }
          Entry.format_check(entry_params[:content], @entry.id, entry_params[:user])
        else
          format.html { render :new }
          format.json { render json: @entry.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:content, :user)
    end
end
