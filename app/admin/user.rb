ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  config.sort_order = 'id'
  config.per_page = USERS_PER_PAGE

  index do
    selectable_column
    id_column
    column :email
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs "Create Dispatcher" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :created_at
      row  :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row   :current_sign_in_ip
      row   :last_sign_in_ip
    end
    active_admin_comments
  end


end
