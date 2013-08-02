class AssetSerializer < ActiveModel::Serializer
  attributes :id, :name, :quantity, :assetable_id #, :purchase_date, :effective_date

end
