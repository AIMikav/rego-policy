#!/usr/bin/env python3
"""
Simple Policy Generator Streamlit App

A minimal web interface for generating Rego policies.
"""

import streamlit as st
import json
import sys
from pathlib import Path
from datetime import datetime

from policy_generator import SimplePolicyGenerator

# Page configuration
st.set_page_config(
    page_title="Simple Policy Generator",
    layout="wide"
)

def main():
    """Main Streamlit app."""
    st.title("Simple Policy Generator")
    st.markdown("Generate Rego policies from natural language")
    
    # Sidebar for configuration
    st.sidebar.header("Configuration")
    
    provider = st.sidebar.selectbox(
        "LLM Provider",
        ["google", "openai", "anthropic"],
        help="Choose your LLM provider"
    )
    
    # Check if API key is configured
    api_key_env = {
        "google": "GOOGLE_API_KEY",
        "openai": "OPENAI_API_KEY", 
        "anthropic": "ANTHROPIC_API_KEY"
    }
    
    api_key = api_key_env[provider]
    if not st.sidebar.checkbox(f"{api_key} configured", value=True):
        st.sidebar.warning(f"Please set {api_key} in your .env file")
    
    # Main content
    col1, col2 = st.columns([1, 1])
    
    with col1:
        st.header("Input")
        
        # Requirements input
        requirements = st.text_area(
            "Policy Requirements",
            height=200,
            placeholder="Describe what you want your policy to do...\n\nExample: Create an access control policy where users can only access their own resources and admins can access everything.",
            help="Describe your policy requirements in natural language"
        )
        
        # Test cases input
        st.subheader("Test Cases (Optional)")
        
        # Pass test case
        st.write("**Pass Test Case** (should comply with policy):")
        pass_test_case_text = st.text_area(
            "Pass Test Case JSON",
            height=150,
            placeholder='{"input": {"items": [{"kind": "Namespace", "metadata": {"name": "secure-namespace"}}, {"kind": "NetworkPolicy", "metadata": {"name": "default-deny"}}]}}',
            help="Provide a test case that should PASS (comply with the policy)",
            key="pass_test_case"
        )
        
        # Fail test case
        st.write("**Fail Test Case** (should violate policy):")
        fail_test_case_text = st.text_area(
            "Fail Test Case JSON",
            height=150,
            placeholder='{"input": [{"kind": "Namespace", "metadata": {"name": "insecure-namespace"}}, {"kind": "Service", "metadata": {"name": "some-service"}}]}',
            help="Provide a test case that should FAIL (violate the policy)",
            key="fail_test_case"
        )
        
        # Parse test cases
        pass_test_case = None
        fail_test_case = None
        
        if pass_test_case_text.strip():
            try:
                pass_test_case = json.loads(pass_test_case_text)
            except json.JSONDecodeError as e:
                st.error(f"Invalid JSON in Pass Test Case: {e}")
        
        if fail_test_case_text.strip():
            try:
                fail_test_case = json.loads(fail_test_case_text)
            except json.JSONDecodeError as e:
                st.error(f"Invalid JSON in Fail Test Case: {e}")
        
        # Package name
        package_name = st.text_input(
            "Package Name",
            value="policy",
            help="Name for the Rego package"
        )
        
        # Generate button
        if st.button("Generate Policy", type="primary", use_container_width=True):
            if not requirements.strip():
                st.error("Please enter policy requirements!")
            else:
                try:
                    with st.spinner("Generating policy..."):
                        generator = SimplePolicyGenerator(provider=provider)
                        policy = generator.generate_policy(
                            requirements=requirements,
                            pass_test_case=pass_test_case,
                            fail_test_case=fail_test_case,
                            package_name=package_name
                        )
                    
                    st.session_state.generated_policy = policy
                    st.session_state.input_requirements = requirements
                    st.session_state.pass_test_case = pass_test_case
                    st.session_state.fail_test_case = fail_test_case
                    st.success("Policy generated successfully!")
                    
                except Exception as e:
                    st.error(f"Error: {str(e)}")
    
    with col2:
        st.header("Generated Policy")
        
        if 'generated_policy' in st.session_state and st.session_state.generated_policy:
            # Display policy
            st.code(st.session_state.generated_policy, language='rego')
            
            # Download button
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            filename = f"policy_{timestamp}.rego"
            
            st.download_button(
                label="Download Policy",
                data=st.session_state.generated_policy,
                file_name=filename,
                mime="text/plain"
            )
            
            # Show input summary
            st.subheader("Input Used")
            with st.expander("Requirements"):
                st.text(st.session_state.input_requirements)
            
            if st.session_state.pass_test_case:
                with st.expander("Pass Test Case"):
                    st.json(st.session_state.pass_test_case)
            
            if st.session_state.fail_test_case:
                with st.expander("Fail Test Case"):
                    st.json(st.session_state.fail_test_case)
        else:
            st.info("Generate a policy to see it here")
    
    # Footer
    st.markdown("---")
    st.markdown("""
    <div style="text-align: center; color: #666; font-size: 0.9rem;">
        Simple Policy Generator | Built with Streamlit
    </div>
    """, unsafe_allow_html=True)

if __name__ == "__main__":
    main()