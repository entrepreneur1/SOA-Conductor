module DoctorsHelper
  def search_param(param)
    params[:search].try(:[],param)
  end
  def sortable(name)
    link_to name.humanize, nil, :class => 'sort_link'
  end
end
