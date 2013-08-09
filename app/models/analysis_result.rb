class AnalysisResult < ActiveRecord::Base
  # attr_accessible :title, :body

  def serializer
    self.active_model_serializer.new(self, root: false)
  end

end
