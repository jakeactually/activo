require "rqrcode"

class UsersController < ApplicationController
  before_action :admin_authenticate, only: %i[ index admin admin_post destroy ]
  before_action :authenticate, only: %i[ edit update dashboard ]
  before_action :set_user, only: %i[ show vcf admin admin_patch destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    url = "http://miembros.activo.plus" + (user_path params[:id])
    @svg = RQRCode::QRCode.new(url).as_svg standalone: true
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    @user.password = '123456'

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /login
  def login
    @user = User.new
  end

  # POST /login
  def login_post
    user = User.find_by(email: params[:email])&.authenticate(params[:password])
    if user
      session[:user_id] = user.id
      if user.role == 'admin'
        redirect_to action: 'index'
      else
        redirect_to action: 'dashboard', id: user.id
      end
    else
      redirect_to({ action: 'login' }, alert: "Credenciales no válidas")
    end
  end

  # GET /logout
  def logout
    session[:user_id] = nil
    redirect_to action: 'login'
  end

  # GET /users/1/vcf
  def vcf
    send_data UsersHelper::user_to_vcf(@user), :filename => 'user.vcf'
  end

  # GET /users/1/admin
  def admin
  end

  # GET /users/1/admin
  def admin_patch
    @user.update(user_params)
    @user.password = params[:password] if params[:password]
    @user.save
    redirect_to users_path
  end

  # GET /users/1/dashboard
  def dashboard
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def authenticate
      unless session[:user_id]
        raise ActionController::RoutingError.new('Unauthorized')
      end

      @user = User.find(session[:user_id])

      unless @user && @user.id.to_s == params[:id]
        raise ActionController::RoutingError.new('Unauthorized')
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def admin_authenticate
      unless session[:user_id]
        raise ActionController::RoutingError.new('Not Found')
      end

      user = User.find(session[:user_id])

      unless user && user.role == 'admin'
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(
        :code,
        :first_name,
        :last_name,
        :address,
        :company,
        :email,
        :phone,
        :position, :website,
        :role,
        :password,
        :avatar,
        :contract,
        :document,
        :identification,
        :alergie,
        :contact_name,
        :contact_phone,
        :card_from,
        :card_to,
        :blood_type
      )
    end
end
