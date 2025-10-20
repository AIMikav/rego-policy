#!/bin/bash

# Script to test all existing policies using OPA evaluation

echo "Testing existing OPA policies..."
echo "================================"

# Find all policy files in after_prompt_reduction directory (relative to project root)
policy_files=$(find ../outputs/sample_output -name "policy_*_generated.rego" 2>/dev/null | sort)

if [ -z "$policy_files" ]; then
    echo "No policy files found in sample_output directory"
    exit 1
fi

# Test each existing policy file
for policy_file in $policy_files; do
    # Extract policy number from filename
    policy_num=$(basename "$policy_file" | sed 's/policy_\([0-9]*\)_generated\.rego/\1/')
    
    echo ""
    echo "Policy $policy_num:"
    echo "-------------------"
    
    # Test with pass case if it exists
    pass_file="../test_files/test_contradicting_inputs/pass/policy_${policy_num}_pass.json"
    if [ -f "$pass_file" ]; then
        echo "PASS test:"
        opa eval --data "$policy_file" --input "$pass_file" 'data.policy.deny' --format pretty
    else
        echo "PASS test: No pass file found"
    fi
    
    # Test with fail case if it exists
    fail_file="../test_files/test_contradicting_inputs/fail/policy_${policy_num}_fail.json"
    if [ -f "$fail_file" ]; then
        echo "FAIL test:"
        opa eval --data "$policy_file" --input "$fail_file" 'data.policy.deny' --format pretty
    else
        echo "FAIL test: No fail file found"
    fi
done

echo ""
echo "================================"
echo "Testing completed"
