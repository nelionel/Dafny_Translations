def do_algebra(operator, operand):
    """
    Given two lists operator, and operand. The first list has basic algebra operations, and 
    the second list is a list of integers. Use the two given lists to build the algebric 
    expression and return the evaluation of this expression.

    The basic algebra operations:
    Addition ( + ) 
    Subtraction ( - ) 
    Multiplication ( * ) 
    Floor division ( // ) 
    Exponentiation ( ** ) 

    Example:
    operator['+', '*', '-']
    array = [2, 3, 4, 5]
    result = 2 + 3 * 4 - 5
    => result = 9

    Note:
        The length of operator list is equal to the length of operand list minus one.
        Operand is a list of of non-negative integers.
        Operator list has at least one operator, and operand list has at least two operands.

    """
    # Create a copy of operands to work with
    operands = operand.copy()
    operators = operator.copy()
    
    # Process exponentiation first (highest precedence)
    i = 0
    while i < len(operators):
        if operators[i] == '**':
            result = operands[i] ** operands[i + 1]
            operands[i] = result
            operands.pop(i + 1)
            operators.pop(i)
        else:
            i += 1
    
    # Process multiplication and floor division (medium precedence)
    i = 0
    while i < len(operators):
        if operators[i] == '*':
            result = operands[i] * operands[i + 1]
            operands[i] = result
            operands.pop(i + 1)
            operators.pop(i)
        elif operators[i] == '//':
            result = operands[i] // operands[i + 1]
            operands[i] = result
            operands.pop(i + 1)
            operators.pop(i)
        else:
            i += 1
    
    # Process addition and subtraction (lowest precedence)
    i = 0
    while i < len(operators):
        if operators[i] == '+':
            result = operands[i] + operands[i + 1]
            operands[i] = result
            operands.pop(i + 1)
            operators.pop(i)
        elif operators[i] == '-':
            result = operands[i] - operands[i + 1]
            operands[i] = result
            operands.pop(i + 1)
            operators.pop(i)
        else:
            i += 1
    
    return operands[0]