class Elevator < ApplicationRecord
  
  def model_enum
    [['Standard', 0],['Premium',1],['Excelium',2]]
  end
  def status_enum
    [['Active', 0],['Inactive',1],['Alarm',2]]
  end


  def building_type_enum
    [['Residential', 0],['Commercial',1],['Corporate',2],['Hybrid',3]]
  end
  
  
  belongs_to :column
end
