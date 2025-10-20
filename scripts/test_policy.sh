#!/bin/bash

# Simple script to test OPA policies with input data

POLICY_FILE="test_output/policy_3_generated.rego"
INPUT_FILE="test_contradicting_inputs/pass/policy_3_pass.json"

echo "Testing policy: $POLICY_FILE"
echo "With input: $INPUT_FILE"
echo "----------------------------------------"

# Test the policy with all required library files
opa eval --data "$POLICY_FILE" --input "$INPUT_FILE" 'data.policy.deny' --format pretty

echo "----------------------------------------"
echo "Test completed"