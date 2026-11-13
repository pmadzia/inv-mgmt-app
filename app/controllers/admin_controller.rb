class AdminController < ApplicationController
  before_action :require_admin
  before_action :load_selected_users,
  only: %i[block_selected unblock_selected promote_selected demote_selected delete_selected]

  def index
    load_users
  end

  def block_selected
    apply_to_selected("blocked") { @selected.update_all(status: User.statuses[:blocked]) }
  end

  def unblock_selected
    apply_to_selected("unblocked") { @selected.update_all(status: User.statuses[:active]) }
  end

  def promote_selected
    apply_to_selected("promoted") { @selected.update_all(role: User.roles[:admin]) }
  end

  def demote_selected
    apply_to_selected("demoted") { @selected.update_all(role: User.roles[:user]) }
  end

  def delete_selected
    def delete_selected = apply_to_selected("deleted") { @selected.delete_all }
  end

  private

  def require_admin
    redirect_to root_path, alert: "Not authorized.", status: :see_other unless
    current_user&.admin? && current_user.active?
  end

  def load_users
    @q = User.ransack(params[:q])
    @q.sorts = "created_at desc" if @q.sorts.empty?
    @users = @q.result
  end

  def apply_to_selected(action)
    count = yield
    respond_with_list "#{helpers.pluralize(count, 'user')} #{action}."
  end

  def load_selected_users
    ids = Array(params[:user_ids])
    if ids.empty?
      redirect_to admin_path, status: :see_other
    else
      @selected = User.where(id: ids)
    end
  end

  def respond_with_list(message)
    load_users
    respond_to do |format|
      format.turbo_stream { render_list(message) }
      format.html { redirect_to admin_path, notice: message, status: :see_other }
    end
  end

  def render_list(message)
    flash.now[:notice] = message
    render turbo_stream: [
      turbo_stream.replace("flash", partial: "shared/flash"),
      turbo_stream.replace("users_list", partial: "admin/users_list",
                           locals: { q: @q, users: @users })
    ]
  end
end
