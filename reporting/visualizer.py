"""Visualization generation for results"""

import plotly.graph_objects as go
import plotly.express as px
import plotly.io as pio
from plotly.subplots import make_subplots
from pathlib import Path
from typing import Dict, List, Tuple
import pandas as pd

from ..core.models import EvaluationResult, CompilationStatus, VerificationStatus


def interpolate_color(color1: str, color2: str, factor: float) -> str:
    """Interpolate between two hex colors"""
    # Convert hex to RGB
    def hex_to_rgb(hex_color):
        hex_color = hex_color.lstrip('#')
        return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))
    
    def rgb_to_hex(rgb):
        return f"#{rgb[0]:02x}{rgb[1]:02x}{rgb[2]:02x}"
    
    rgb1 = hex_to_rgb(color1)
    rgb2 = hex_to_rgb(color2)
    
    # Interpolate each component
    r = int(rgb1[0] + factor * (rgb2[0] - rgb1[0]))
    g = int(rgb1[1] + factor * (rgb2[1] - rgb1[1]))
    b = int(rgb1[2] + factor * (rgb2[2] - rgb1[2]))
    
    return rgb_to_hex((r, g, b))


def generate_color_gradient(base_light: str, base_dark: str, num_colors: int) -> List[str]:
    """Generate a color gradient from light to dark with specified number of colors"""
    if num_colors == 1:
        return [base_light]
    
    colors = []
    for i in range(num_colors):
        factor = i / (num_colors - 1) if num_colors > 1 else 0
        colors.append(interpolate_color(base_light, base_dark, factor))
    
    return colors


class Visualizer:
    """Handles visualization of results"""
    
    def generate_summary_plot(self, results: List[EvaluationResult], 
                             output_path: Path, run_id: int, model: str):
        """Generate modern summary bar chart with Plotly showing attempt distributions"""
        # Calculate basic statistics
        total_problems = len(results)
        compiled_count = sum(1 for r in results 
                           if r.compilation.status == CompilationStatus.PASSED)
        verified_count = sum(1 for r in results 
                           if r.verification and r.verification.status == VerificationStatus.PASSED)
        
        # Calculate test statistics
        total_tests = 0
        passed_tests = 0
        for r in results:
            if r.compilation.status == CompilationStatus.PASSED and r.testing:
                total_tests += r.testing.total
                passed_tests += r.testing.passed
                
        # Calculate spec validation statistics
        spec_validated_count = sum(1 for r in results if r.spec_validation)
        good_specs_count = sum(1 for r in results 
                              if r.spec_validation and r.spec_validation.has_proper_specs)
        
        # Analyze attempt distributions
        compilation_attempts = self._analyze_compilation_attempts(results)
        testing_attempts = self._analyze_testing_attempts(results)
        verification_attempts = self._analyze_verification_attempts(results)
        spec_validation_attempts = self._analyze_spec_validation_attempts(results)
        
        # Calculate rates
        compilation_rate = (compiled_count / total_problems) * 100 if total_problems > 0 else 0
        verification_rate = (verified_count / total_problems) * 100 if total_problems > 0 else 0
        test_pass_rate = (passed_tests / total_tests) * 100 if total_tests > 0 else 0
        spec_validation_rate = (good_specs_count / spec_validated_count) * 100 if spec_validated_count > 0 else 0
        
        # Create plot data
        labels = ['Compilation', 'Testing', 'Verification']
        rates = [compilation_rate, test_pass_rate, verification_rate]
        counts = [f'{compiled_count}/{total_problems}', 
                 f'{passed_tests}/{total_tests}', 
                 f'{verified_count}/{total_problems}']
        attempt_data = [compilation_attempts, testing_attempts, verification_attempts]
        
        # Add spec validation if any problems were spec validated
        if spec_validated_count > 0:
            labels.append('Spec Validation')
            rates.append(spec_validation_rate)
            counts.append(f'{good_specs_count}/{spec_validated_count}')
            attempt_data.append(spec_validation_attempts)
        
        # Color schemes for each category (light to dark)
        color_schemes = [
            ('#90EE90', '#006400'),  # Compilation: Light green to dark green
            ('#87CEEB', '#000080'),  # Testing: Light blue to navy blue  
            ('#DDA0DD', '#4B0082'),  # Verification: Light purple to indigo
            ('#FFE4B5', '#FF4500'),  # Spec Validation: Light orange to orange red
        ]
        
        # Create stacked bar chart
        fig = go.Figure()
        
        for i, (label, rate, count, attempts, color_scheme) in enumerate(zip(labels, rates, counts, attempt_data, color_schemes)):
            if not attempts:  # No attempt data available
                # Fall back to simple bar
                fig.add_trace(go.Bar(
                    name=f'{label}',
                    x=[label],
                    y=[max(rate, 2) if rate == 0 else rate],
                    text=[count],
                    textposition='auto',
                    textfont=dict(size=13, color='white', family='Arial Black'),
                    marker=dict(color=color_schemes[i][1], opacity=0.85),
                    hovertemplate=f'<b>{label}</b><br>Success Rate: {rate:.1f}%<br>Count: {count}<extra></extra>',
                    showlegend=False
                ))
            else:
                # Create stacked bars for attempt distribution using proper stacking
                max_attempts = max(attempts.keys()) if attempts else 1
                colors = generate_color_gradient(color_scheme[0], color_scheme[1], max_attempts)
                
                # Calculate cumulative heights for proper stacking
                attempt_rates = []
                attempt_counts_list = []
                attempt_numbers = []
                cumulative_height = 0
                
                # Normal order: start with lowest attempts (first attempts at bottom)
                for attempt_num in sorted(attempts.keys()):
                    attempt_count = attempts[attempt_num]
                    attempt_rate = (attempt_count / total_problems) * 100 if total_problems > 0 else 0
                    
                    # Use appropriate denominators for each category
                    if label == 'Testing':
                        # For testing, calculate based on problems that compiled successfully
                        compiled_problems = sum(1 for r in results if r.compilation.status == CompilationStatus.PASSED)
                        attempt_rate = (attempt_count / compiled_problems) * 100 if compiled_problems > 0 else 0
                    elif label == 'Spec Validation':
                        attempt_rate = (attempt_count / spec_validated_count) * 100 if spec_validated_count > 0 else 0
                    
                    attempt_rates.append(attempt_rate)
                    attempt_counts_list.append(attempt_count)
                    attempt_numbers.append(attempt_num)
                    cumulative_height += attempt_rate
                
                # Create a single stacked bar using Plotly's proper stacking mechanism
                for j, (attempt_num, attempt_rate, attempt_count) in enumerate(zip(attempt_numbers, attempt_rates, attempt_counts_list)):
                    # Inverted color assignment: lowest attempts get darkest colors (at the base)
                    color_index = max_attempts - attempt_num  # Attempt 1 gets darkest, higher attempts get lighter
                    color = colors[color_index] if color_index < len(colors) else colors[-1]
                    
                    fig.add_trace(go.Bar(
                        name=f'{label} (Attempt {attempt_num})',
                        x=[label],
                        y=[attempt_rate],
                        marker=dict(color=color, opacity=0.85, line=dict(color='rgba(255,255,255,0.3)', width=1)),
                        hovertemplate=f'<b>{label} - Attempt {attempt_num}</b><br>' +
                                    f'Count: {attempt_count}<br>' +
                                    f'Rate: {attempt_rate:.1f}%<extra></extra>',
                        showlegend=False
                    ))
                
                # Add overall count text on top of stacked bar
                fig.add_annotation(
                    x=label,
                    y=max(cumulative_height + 3, 8),  # Position at top of stacked bar
                    text=f'<b>{count}</b>',
                    showarrow=False,
                    font=dict(size=13, color='#2c3e50', family='Arial Black'),
                )
        
        # Update layout with modern styling
        fig.update_layout(
            barmode='stack',  # Enable proper stacking
            title=dict(
                text=f'<b>Dafny Translation & Evaluation Summary</b><br>' +
                     f'<span style="font-size:16px; color:#666">Run {run_id} • {model} • {total_problems} problems</span>',
                x=0.5,
                font=dict(size=20, family='Arial', color='#2c3e50')
            ),
            xaxis=dict(
                title=dict(
                    text='<b>Evaluation Stage</b>',
                    font=dict(size=14, family='Arial', color='#34495e')
                ),
                tickfont=dict(size=13, family='Arial', color='#2c3e50'),
                showgrid=False,
                showline=True,
                linewidth=2,
                linecolor='#bdc3c7'
            ),
            yaxis=dict(
                title=dict(
                    text='<b>Success Rate (%)</b>',
                    font=dict(size=14, family='Arial', color='#34495e')
                ),
                tickfont=dict(size=12, family='Arial', color='#2c3e50'),
                range=[0, 105],
                showgrid=True,
                gridwidth=1,
                gridcolor='rgba(189, 195, 199, 0.3)',
                showline=True,
                linewidth=2,
                linecolor='#bdc3c7'
            ),
            plot_bgcolor='#fafafa',  # Off-white background
            paper_bgcolor='white',
            font=dict(family='Arial', color='#2c3e50'),
            margin=dict(l=80, r=40, t=100, b=80),
            width=800,
            height=500,
            showlegend=False
        )
        
        # Add percentage annotations above bars that don't have attempt data
        for i, (label, rate, count, attempts) in enumerate(zip(labels, rates, counts, attempt_data)):
            if not attempts:  # Only add annotation if we didn't create stacked bars
                y_pos = max(rate + 3, 8)
                fig.add_annotation(
                    x=label,
                    y=y_pos,
                    text=f'<b>{rate:.1f}%</b>',
                    showarrow=False,
                    font=dict(size=14, color='#2c3e50', family='Arial Black'),
                )
        
        # Save as PNG with high quality
        pio.write_image(fig, output_path, format='png', width=800, height=500, scale=2)
        
        return {
            'total_problems': total_problems,
            'compiled_count': compiled_count,
            'verified_count': verified_count,
            'total_tests': total_tests,
            'passed_tests': passed_tests,
            'compilation_rate': compilation_rate,
            'verification_rate': verification_rate,
            'test_pass_rate': test_pass_rate,
            'spec_validated_count': spec_validated_count,
            'good_specs_count': good_specs_count,
            'spec_validation_rate': spec_validation_rate
        }
    
    def generate_attempts_histograms(self, results: List[EvaluationResult], 
                                    output_dir: Path, run_id: int, model: str):
        """Generate histograms showing attempt distributions for solutions and tests"""
        # Filter results with translation data
        translation_results = [r for r in results if r.solution_result and r.test_result]
        
        if not translation_results:
            print("No translation data available for attempt histograms")
            return
        
        # Extract attempt data
        solution_attempts = [r.solution_result.attempts for r in translation_results]
        test_attempts = [r.test_result.attempts for r in translation_results]
        
        # Get the maximum attempts to set the range
        max_solution_attempts = max(solution_attempts) if solution_attempts else 1
        max_test_attempts = max(test_attempts) if test_attempts else 1
        max_attempts = max(max_solution_attempts, max_test_attempts)
        
        # Create subplot with two histograms side by side
        fig = make_subplots(
            rows=1, cols=2,
            subplot_titles=('<b>Solution Translation Attempts</b>', '<b>Test Translation Attempts</b>'),
            specs=[[{"secondary_y": False}, {"secondary_y": False}]]
        )
        
        # Count occurrences for each attempt number
        solution_counts = {}
        test_counts = {}
        
        for i in range(1, max_attempts + 1):
            solution_counts[i] = solution_attempts.count(i)
            test_counts[i] = test_attempts.count(i)
        
        # Add solution attempts histogram
        fig.add_trace(
            go.Bar(
                x=list(solution_counts.keys()),
                y=list(solution_counts.values()),
                name='Solution Attempts',
                marker=dict(color='#2E8B57', opacity=0.8),
                text=[f'{count}' for count in solution_counts.values()],
                textposition='auto',
                textfont=dict(size=12, color='white', family='Arial Black'),
                hovertemplate='<b>%{x} Attempts</b><br>Problems: %{y}<extra></extra>'
            ),
            row=1, col=1
        )
        
        # Add test attempts histogram  
        fig.add_trace(
            go.Bar(
                x=list(test_counts.keys()),
                y=list(test_counts.values()),
                name='Test Attempts',
                marker=dict(color='#4169E1', opacity=0.8),
                text=[f'{count}' for count in test_counts.values()],
                textposition='auto', 
                textfont=dict(size=12, color='white', family='Arial Black'),
                hovertemplate='<b>%{x} Attempts</b><br>Problems: %{y}<extra></extra>'
            ),
            row=1, col=2
        )
        
        # Update layout
        fig.update_layout(
            title=dict(
                text=f'<b>Translation Attempt Distribution</b><br>' +
                     f'<span style="font-size:16px; color:#666">Run {run_id} • {model} • {len(translation_results)} problems</span>',
                x=0.5,
                font=dict(size=20, family='Arial', color='#2c3e50')
            ),
            plot_bgcolor='#fafafa',
            paper_bgcolor='white',
            font=dict(family='Arial', color='#2c3e50'),
            margin=dict(l=60, r=60, t=100, b=80),
            width=1000,
            height=500,
            showlegend=False
        )
        
        # Update x-axes
        fig.update_xaxes(
            title_text='<b>Number of Attempts</b>',
            tickmode='linear',
            tick0=1,
            dtick=1,
            range=[0.5, max_attempts + 0.5],
            showgrid=True,
            gridwidth=1,
            gridcolor='rgba(189, 195, 199, 0.3)',
            row=1, col=1
        )
        
        fig.update_xaxes(
            title_text='<b>Number of Attempts</b>',
            tickmode='linear', 
            tick0=1,
            dtick=1,
            range=[0.5, max_attempts + 0.5],
            showgrid=True,
            gridwidth=1,
            gridcolor='rgba(189, 195, 199, 0.3)',
            row=1, col=2
        )
        
        # Update y-axes
        fig.update_yaxes(
            title_text='<b>Number of Problems</b>',
            showgrid=True,
            gridwidth=1,
            gridcolor='rgba(189, 195, 199, 0.3)',
            row=1, col=1
        )
        
        fig.update_yaxes(
            title_text='<b>Number of Problems</b>',
            showgrid=True,
            gridwidth=1,
            gridcolor='rgba(189, 195, 199, 0.3)',
            row=1, col=2
        )
        
        # Save the histogram
        histogram_path = output_dir / "dafny_attempts_histogram.png"
        pio.write_image(fig, histogram_path, format='png', width=1000, height=500, scale=2)
        print(f"Attempt distribution histogram saved to {histogram_path.name}")
        
        return {
            'solution_attempts': solution_counts,
            'test_attempts': test_counts,
            'max_attempts': max_attempts,
            'total_problems': len(translation_results)
        }
    
    def generate_success_vs_attempts_plot(self, results: List[EvaluationResult],
                                        output_dir: Path, run_id: int, model: str):
        """Generate plot showing compilation success rate vs number of attempts"""
        # Filter results with translation data
        translation_results = [r for r in results if r.solution_result and r.test_result]
        
        if not translation_results:
            print("No translation data available for success vs attempts plot")
            return
        
        # Group by attempt count and calculate success rates
        attempt_data = {}
        
        for result in translation_results:
            # Use solution attempts as the primary metric
            attempts = result.solution_result.attempts
            compiled = result.compilation.status == CompilationStatus.PASSED
            
            if attempts not in attempt_data:
                attempt_data[attempts] = {'total': 0, 'success': 0}
            
            attempt_data[attempts]['total'] += 1
            if compiled:
                attempt_data[attempts]['success'] += 1
        
        # Calculate success rates
        attempts_list = sorted(attempt_data.keys())
        success_rates = []
        problem_counts = []
        
        for attempts in attempts_list:
            data = attempt_data[attempts]
            success_rate = (data['success'] / data['total']) * 100 if data['total'] > 0 else 0
            success_rates.append(success_rate)
            problem_counts.append(data['total'])
        
        # Create the plot
        fig = go.Figure()
        
        # Add bars for success rate
        fig.add_trace(
            go.Bar(
                x=attempts_list,
                y=success_rates,
                name='Compilation Success Rate',
                marker=dict(color='#8A2BE2', opacity=0.8),
                text=[f'{rate:.1f}%<br>({attempt_data[att]["success"]}/{attempt_data[att]["total"]})' 
                      for att, rate in zip(attempts_list, success_rates)],
                textposition='auto',
                textfont=dict(size=12, color='white', family='Arial Black'),
                hovertemplate='<b>%{x} Attempts</b><br>' +
                            'Success Rate: %{y:.1f}%<br>' +
                            'Problems: %{text}<br>' +
                            '<extra></extra>'
            )
        )
        
        # Update layout
        fig.update_layout(
            title=dict(
                text=f'<b>Compilation Success Rate vs Translation Attempts</b><br>' +
                     f'<span style="font-size:16px; color:#666">Run {run_id} • {model} • {len(translation_results)} problems</span>',
                x=0.5,
                font=dict(size=20, family='Arial', color='#2c3e50')
            ),
            xaxis=dict(
                title=dict(
                    text='<b>Number of Solution Translation Attempts</b>',
                    font=dict(size=14, family='Arial', color='#34495e')
                ),
                tickmode='linear',
                tick0=1,
                dtick=1,
                range=[0.5, max(attempts_list) + 0.5],
                showgrid=True,
                gridwidth=1,
                gridcolor='rgba(189, 195, 199, 0.3)',
            ),
            yaxis=dict(
                title=dict(
                    text='<b>Compilation Success Rate (%)</b>',
                    font=dict(size=14, family='Arial', color='#34495e')
                ),
                range=[0, 105],
                showgrid=True,
                gridwidth=1,
                gridcolor='rgba(189, 195, 199, 0.3)',
            ),
            plot_bgcolor='#fafafa',
            paper_bgcolor='white',
            font=dict(family='Arial', color='#2c3e50'),
            margin=dict(l=80, r=40, t=100, b=80),
            width=800,
            height=500,
            showlegend=False
        )
        
        # Save the plot
        success_path = output_dir / "dafny_success_vs_attempts.png"
        pio.write_image(fig, success_path, format='png', width=800, height=500, scale=2)
        print(f"Success vs attempts plot saved to {success_path.name}")
        
        return {
            'attempt_data': attempt_data,
            'success_rates': dict(zip(attempts_list, success_rates))
        } 
    
    def _analyze_compilation_attempts(self, results: List[EvaluationResult]) -> Dict[int, int]:
        """Analyze attempt distribution for successful compilations"""
        attempt_counts = {}
        
        for result in results:
            if (result.compilation.status == CompilationStatus.PASSED and 
                result.solution_result and result.solution_result.attempts):
                attempts = result.solution_result.attempts
                attempt_counts[attempts] = attempt_counts.get(attempts, 0) + 1
        
        return attempt_counts
    
    def _analyze_testing_attempts(self, results: List[EvaluationResult]) -> Dict[int, int]:
        """Analyze attempt distribution for successful testing"""
        attempt_counts = {}
        
        for result in results:
            if (result.compilation.status == CompilationStatus.PASSED and 
                result.testing and result.testing.total > 0 and 
                result.testing.passed == result.testing.total and
                result.test_result and result.test_result.attempts):
                attempts = result.test_result.attempts
                attempt_counts[attempts] = attempt_counts.get(attempts, 0) + 1
        
        return attempt_counts
    
    def _analyze_verification_attempts(self, results: List[EvaluationResult]) -> Dict[int, int]:
        """Analyze attempt distribution for successful verification"""
        attempt_counts = {}
        
        for result in results:
            if (result.verification and result.verification.status == VerificationStatus.PASSED and
                result.solution_result and result.solution_result.attempts):
                attempts = result.solution_result.attempts
                attempt_counts[attempts] = attempt_counts.get(attempts, 0) + 1
        
        return attempt_counts
    
    def _analyze_spec_validation_attempts(self, results: List[EvaluationResult]) -> Dict[int, int]:
        """Analyze attempt distribution for successful spec validation"""
        attempt_counts = {}
        
        for result in results:
            if (result.spec_validation and result.spec_validation.has_proper_specs and
                result.spec_validation.attempts):
                attempts = result.spec_validation.attempts
                attempt_counts[attempts] = attempt_counts.get(attempts, 0) + 1
        
        return attempt_counts 