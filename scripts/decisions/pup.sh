#!/bin/bash
# block cup stack
rosservice call /kcl_rosplan/update_knowledge_base "update_type: 2
knowledge:
  knowledge_type: 1
  instance_type: ''
  instance_name: ''
  attribute_name: 'open'
  values:
  - {key: 'p', value: 'plate_pile'}
  function_value: 0.0";

rosservice call /kcl_rosplan/update_knowledge_base "update_type: 0
knowledge:
  knowledge_type: 1
  instance_type: ''
  instance_name: ''
  attribute_name: 'has'
  values:
  - {key: 't', value: 'plate'}
  - {key: 'r', value: 'robot1'}
  function_value: 0.0";