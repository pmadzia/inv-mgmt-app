module AdminHelper
  def sort_link(q, column)
    super(q, column, controller: "admin", action: "index",
          user_ids: nil, authenticity_token: nil)
  end
end
