"""LLM interaction utilities"""

import re
from typing import Any, Optional


def extract_code_from_response(response: Any, language: str = "dafny") -> str:
    """Extract code from LLM response"""
    # Handle structured response
    if hasattr(response, 'content'):
        return extract_dafny_code(response)
    
    # Handle string response
    if isinstance(response, str):
        # Look for code block
        pattern = rf"```{language}\n(.*?)\n```"
        match = re.search(pattern, response, re.DOTALL)
        if match:
            return match.group(1).strip()
        return response.strip()
    
    return ""


def extract_dafny_code(response: Any) -> str:
    """Extract Dafny code from Claude response"""
    dafny_code = ""
    
    # Handle structured response with content blocks
    if hasattr(response, 'content'):
        for block in response.content:
            if block.type == 'text':
                # Look for Dafny code block
                code_match = re.search(r"```dafny\n(.*?)\n```", block.text, re.DOTALL)
                if code_match:
                    dafny_code = code_match.group(1).strip()
                    break
        
        # Fallback if no markdown block found
        if not dafny_code:
            for block in response.content:
                if block.type == 'text':
                    dafny_code = block.text.strip()
                    break
    
    # Handle list of content blocks
    elif isinstance(response, list):
        full_text = "\n".join([block.text for block in response if hasattr(block, 'text')])
        code_match = re.search(r"```dafny\n(.*?)\n```", full_text, re.DOTALL)
        if code_match:
            dafny_code = code_match.group(1).strip()
        else:
            dafny_code = full_text.strip()
    
    # Handle string response
    elif isinstance(response, str):
        code_match = re.search(r"```dafny\n(.*?)\n```", response, re.DOTALL)
        if code_match:
            dafny_code = code_match.group(1).strip()
        else:
            dafny_code = response.strip()
            
    return dafny_code


def extract_dummy_method(response: Any) -> str:
    """Extract dummy method from response"""
    dummy_method = ""
    
    # Get full text from response
    full_text = ""
    if hasattr(response, 'content'):
        full_text = "\n".join([block.text for block in response.content if block.type == 'text'])
    elif isinstance(response, list):
        full_text = "\n".join([block.text for block in response if hasattr(block, 'text')])
    elif isinstance(response, str):
        full_text = response
        
    # Look for dummy block
    dummy_match = re.search(r"<dummy>\n(.*?)\n</dummy>", full_text, re.DOTALL)
    if dummy_match:
        dummy_method = dummy_match.group(1).strip()
        
    return dummy_method


def format_conversation_for_transcript(conversation_history: list) -> str:
    """Format conversation history for transcript"""
    transcript = []
    
    for role, content in conversation_history:
        transcript.append(f"{'='*15} {role.upper()} {'='*15}")
        
        if isinstance(content, str):
            transcript.append(content)
        elif isinstance(content, list):
            for block in content:
                if hasattr(block, 'type'):
                    if block.type == 'thinking':
                        transcript.append("--- THINKING ---")
                        transcript.append(block.thinking)
                        transcript.append("")
                    elif block.type == 'text':
                        transcript.append("--- RESPONSE ---")
                        transcript.append(block.text)
        else:
            transcript.append(str(content))
            
        transcript.append("\n")
        
    return "\n".join(transcript) 