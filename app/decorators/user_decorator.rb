module UserDecorator
  # def created_at
  #   helpers.content_tag :span, class: 'time' do
  #     object.created_at.strftime("%a %m/%d/%y")
  #   end
  # end

  def trial_created_at
    created_at.strftime("%a %m/%d/%y")
  end

def trial_name
    "trial!!!! #{name}"
  end
end
