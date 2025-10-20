#!/bin/bash

# Load policies into OPA
echo "Loading policies into OPA..."

# Load policy_0.rego
curl -X PUT http://localhost:8181/v1/policies/policy_0 \
  -H "Content-Type: text/plain" \
  --data-binary @data/policy_0.rego

echo "Policy policy_0 loaded"

# Load policy_1.rego  
curl -X PUT http://localhost:8181/v1/policies/policy_1 \
  -H "Content-Type: text/plain" \
  --data-binary @data/policy_1.rego

echo "Policy policy_1 loaded"

echo "Policies loaded successfully!"
echo "You can now test them by making requests to http://localhost:8181/v1/data"