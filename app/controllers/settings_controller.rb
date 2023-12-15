class SettingsController < ApplicationController
  before_action :require_login
  before_action :set_setting, only: %i[ show edit update ]

  def show
  end

  # GET /settings/1/edit
  def edit
  end

  # PATCH/PUT /settings/1 or /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to setting_url(@setting)}
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path, alert: 'Your account has been deleted. To access Workypad, you can sign up again.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = current_user.setting || current_user.create_setting
    end

    # Only allow a list of trusted parameters through.
    def setting_params
      params.require(:setting).permit(:days_to_auto_archive)
    end
end
