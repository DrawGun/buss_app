ActiveAdmin.register City, :namespace => :admin do

  actions :all, except: [:show, :destroy]

  index do
    id_column

    column :name

    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Основное' do
      f.input :name
    end

    f.actions
  end

  filter :id
  filter :name, as: :select, collection: -> { City.available_collection }, input_html: { class: 'select2' }


  permit_params :name
end
