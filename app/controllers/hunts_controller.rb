class HuntsController < ApplicationController

  def index
    @hunt = Hunt.new
    @hunts = Hunt.available.not.where(leader: current_user).with_free_slot.where(platform: 'pc').sort_by_asc_datetime
    @hunts = @hunts.not.where(:hunter_ids.in => [current_user.id]).limit(20)
    @hunts_joined_available = current_user.hunts_joined.available.sort_by_asc_datetime
    @hunts_as_leader_available = current_user.hunts_as_leader.available.sort_by_asc_datetime
  end

  def show
    @hunt_show = Hunt.find(hunt_params[:hunt_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def find
    @hunts = Hunt.available

    @hunts = @hunts.where(platform: hunt_params[:platform]) if hunt_params[:platform].present?
    @hunts = @hunts.any_of({title: /.*#{hunt_params[:title]}.*/i}) if hunt_params[:title].present?
    @hunts = @hunts.where(:datetime.gt => (hunt_params[:datetime])) if hunt_params[:datetime].present?
    if hunt_params[:voice_chat] == "1"
      @hunts = @hunts.not.where(voice_chat: nil)
      @hunts = @hunts.where(:lang.in => [hunt_params[:lang]]) if hunt_params[:lang].present?
      @hunts = @hunts.where(mic: true) if hunt_params[:mic] == "1"
    end
    @hunts = @hunts.not.where(leader: current_user)
    @hunts = @hunts.not.where(:hunter_ids.in => [current_user.id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def join
    @user = current_user
    @hunt = Hunt.find(hunt_params[:hunt_id])
    authorize @hunt

    if (@hunt.hunters.size + 1) < @hunt.max_hunter
      @hunt.hunters.push(@user)
      @hunt.update!
      redirect_to hunt_path
    else
      @hunts = Hunt.available.not.where(leader: current_user).with_free_slot.where(platform: 'pc').sort_by_asc_datetime
      @hunts = @hunts.not.where(:hunter_ids.in => [current_user.id]).limit(20)
      @hunts_joined_available = current_user.hunts_joined.available.sort_by_asc_datetime
      @hunts_as_leader_available = current_user.hunts_as_leader.available.sort_by_asc_datetime
      render :index
    end
  end

  def create
    @hunt = Hunt.new(hunt_params.merge(leader: current_user))
    authorize @hunt

    if @hunt.valid?
      @hunt.save!
      redirect_to hunt_path
    else
      @hunt
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def sid_update
    @hunt = Hunt.find(hunt_params[:hunt_id])
    @hunt.sid = hunt_params[:sid]
    authorize @hunt

    if @hunt.valid?
      @hunt.update!
      redirect_to hunt_path
    else
      @hunt
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def leave
    @user = current_user
    @hunt = Hunt.find(hunt_params[:hunt_id])
    authorize @hunt

    if @hunt.hunters.include?(@user)
      @user.hunts_joined.delete(@hunt)
      @user.update!
      redirect_to hunt_path
    else
      @hunts = Hunt.available.not.where(leader: current_user).with_free_slot.where(platform: 'pc').sort_by_asc_datetime
      @hunts = @hunts.not.where(:hunter_ids.in => [current_user.id]).limit(20)
      @hunts_joined_available = current_user.hunts_joined.available.sort_by_asc_datetime
      @hunts_as_leader_available = current_user.hunts_as_leader.available.sort_by_asc_datetime
      render :index
    end
  end

  def destroy
    @hunt = Hunt.find(hunt_params[:hunt_id])
    authorize @hunt

    @hunt.destroy
    redirect_to hunt_path
  end

  def preset_query

    option = buttons_params.values.first.nil? ? 'noinput' : buttons_params.values.first.downcase
    case option
    when 'reset' then
      @hunts = Hunt.available.not.where(leader: current_user).with_free_slot.where(platform: hunt_params[:platform]).sort_by_asc_datetime
      @hunts = @hunts.not.where(:hunter_ids.in => [current_user.id]).limit(20)
    when 'in_progress' then
      @hunts = Hunt.available.not.where(leader: current_user).with_free_slot.in_progress.where(platform: hunt_params[:platform]).sort_by_asc_datetime
      @hunts = @hunts.not.where(:hunter_ids.in => [current_user.id]).limit(20)
    when 'oncoming' then
      @hunts = Hunt.available.not.where(leader: current_user).with_free_slot.oncoming.where(platform: hunt_params[:platform]).sort_by_asc_datetime
      @hunts = @hunts.not.where(:hunter_ids.in => [current_user.id]).limit(20)
    else
      @hunts = Hunt.available.not.where(leader: current_user).with_free_slot.where(platform: 'pc').sort_by_asc_datetime
      @hunts = @hunts.not.where(:hunter_ids.in => [current_user.id]).limit(20)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def hunt_params
    params.require(:hunt).permit(:title, :datetime, :duration, :max_hunter, :description, :platform, :voice_chat, :lang, :mic, :hunt_id, :sid)
  end

  def buttons_params
    params.permit(:oncoming, :in_progress, :reset)
  end
end
