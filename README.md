# 5-bit Booth's Multiplication Algorithm in Verilog

Booth's algorithm is a procedure for the multiplication of two signed binary numbers in two's complement notation.

This code is a behavioral implementation of Booth's algorithm in Verilog.

## Algorithm
Let's say we want to multiply 13 and 11.
- **M** is the multiplicand.
- **Q** is the multiplier.

Given:
- \( M = 01101 \) (13 in decimal)
- \( -M = 10011 \) (-13 in decimal, two's complement of 13)
- \( Q = 01011 \) (11 in decimal)

We need a total register that is double the size of the operand bits. For 5-bit numbers, the total register will be 10 bits.

1. **Initialization**:
   - The `total` register is initialized to zero: `total = 00000 00000`.
   - Assign the lower 5 bits of `total` to the multiplier `Q`: `total = 00000 10100`.
   - Initialize the 1-bit `qbit` to 0: `qbit = 0`.

2. **Process Description**:

| Step | `total`         | `qbit` | Action Description (total[0],qbit)                                               |
|------|-----------------|--------|----------------------------------------------------------------------------------|
| 0    | 00000 01011     | 0      | 10 : Upper 5 bits of total = total - M. Assign qbit to total[0] and shift right. |
| 1    | 11001 10101     | 1      | 11 : Assign qbit to be total[0] and shift right                                  |
| 2    | 11100 11010     | 1      | 01 : Upper 5 bits of total = total + M. Assign qbit to total[0] and shift right. |
| 3    | 00100 11101     | 0      | 10 : Upper 5 bits of total = total - M. Assign qbit to total[0] and shift right. |
| 4    | 11011 11110     | 1      | 01 : Upper 5 bits of total = total + M. Assign qbit to total[0] and shift right. |
| 5    | 00100 01111     | x      | End Result (00100 01111 = 143 = 13 * 11)                                         |


   **Notes**:
   - In each step, observe how `total` and `qbit` are updated.
   - Adjust the action based on the value of `qbit`.
   - The final value of `total` after all iterations represents the result of the multiplication.

Continue this process for the fixed number of iterations (equal to the bit-width of `Q`, which is 5). After the loop completes, the `total` register will contain the result of the multiplication.
