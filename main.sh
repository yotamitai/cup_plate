function addFact1(){
rosservice call /kcl_rosplan/update_knowledge_base "update_type: 0
knowledge:
    knowledge_type: 1
    instance_type: ''
    instance_name: ''
    attribute_name: '$1'
    values:
    - {key: '$2', value: '$3'}
    function_value: 0.0";
}
function addFact2(){
rosservice call /kcl_rosplan/update_knowledge_base "update_type: 0
knowledge:
    knowledge_type: 1
    instance_type: ''
    instance_name: ''
    attribute_name: '$1'
    values:
    - {key: '$2', value: '$3'}
    - {key: '$4', value: '$5'}
    function_value: 0.0";
}

function addObject(){
rosservice call /kcl_rosplan/update_knowledge_base "update_type: 0
knowledge:
  knowledge_type: 0
  instance_type: '$2'
  instance_name: '$1'
  attribute_name: ''
  function_value: 0.0";
}

function addGoal(){
rosservice call /kcl_rosplan/update_knowledge_base "update_type: 1
knowledge:
  knowledge_type: 1
  instance_type: ''
  instance_name: ''
  attribute_name: '$1'
  values:
  - {key: 'r', value: 'robot1'}
  function_value: 0.0";
}

function removeGoal(){
rosservice call /kcl_rosplan/update_knowledge_base "update_type: 2
knowledge:
  knowledge_type: 1
  instance_type: ''
  instance_name: ''
  attribute_name: '$1'
  values:
  - {key: 'r', value: 'robot1'}
  function_value: 0.0";
}

echo OBJECTS
addObject "plate_pile" "place" 
addObject "cup_stack" "place" 
addObject "table_side1" "place" 
addObject "table_side2" "place" 
addObject "robot1" "robot" 
addObject "cup" "thing" 
addObject "plate" "thing"

echo FACTS
addFact1 "robot_at" "p" "table_side1" 
addFact1 "is_table_place" "p" "table_side1" 
addFact1 "is_table_place" "p" "table_side2" 
addFact1 "free" "p" "robot1" 
addFact1 "open" "p" "plate_pile" 
addFact1 "open" "p" "cup_stack" 
addFact1 "open" "p" "table_side1" 
addFact1 "open" "p" "table_side2" 
addFact2 "is_thing_place" "t" "plate" "p" "plate_pile" 
addFact2 "is_thing_place" "t" "cup" "p" "cup_stack"

echo GOALS
addGoal "made_pu_decision"

echo PLANNING
rosservice call /kcl_rosplan/planning_server "{}"

echo "plan1"
addFact1 "made_pu_decision" "r" "robot1"
addGoal 'made_pd_decision'

echo "updated"
rosservice call /kcl_rosplan/planning_server "{}"

echo "plan2"
addFact1 "made_pd_decision" "r" "robot1"
addGoal 'sated'

echo "updated"
rosservice call /kcl_rosplan/planning_server "{}"

echo "plan3"
