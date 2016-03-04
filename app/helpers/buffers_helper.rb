module BuffersHelper
  def modified_params(new_params)
    "?#{params.slice(:page, :since, :query).merge(new_params).to_query}"
  end
end
