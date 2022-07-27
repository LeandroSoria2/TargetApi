ActiveAdmin.register Topic do
  form do |f|
    f.inputs 'Topic' do
      f.input :name
      f.input :image, as: :file
    end
    f.actions
  end
  permit_params :name, :image

  show do
    attributes_table do
      row :name
      row :image do |topic|
        if topic.image.attached?
          image_tag topic.image
        else
          'no image'
        end
      end
    end
  end
end
