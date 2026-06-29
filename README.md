# BCD Adder – Verilog RTL

Single-digit BCD adder that adds two 4-bit BCD numbers and produces a valid BCD result with carry out.

## How It Works
- Adds two BCD digits using a 4-bit Ripple Carry Adder
- Detects if result exceeds 9 using carry logic
- If yes, adds 0110 (6) correction via a second RCA to get valid BCD output

## Design Hierarchy
bcd_adder
├── ripple_adder rca1  — first addition
│   └── full_adder (x4)
└── ripple_adder rca2  — BCD correction (+6)
└── full_adder (x4)

## Files
| File | Description |
|---|---|
| bcd_adder.v | BCD Adder with correction logic |
| tb_bcd_adder.v | Testbench with 7 test cases |

## Simulation
```bash
iverilog -o bcd_sim bcd_adder.v tb_bcd_adder.v
vvp bcd_sim
gtkwave dump.vcd
```

## Test Cases
| Case | A | B | Cin | Expected Sum | Cout |

| Normal addition | 4 | 3 | 0 | 7 | 0 |
| Boundary (exactly 9) | 5 | 4 | 0 | 9 | 0 |
| Correction triggered | 8 | 5 | 0 | 3 | 1 |
| Exact boundary (10) | 6 | 4 | 0 | 0 | 1 |
| With carry in | 7 | 2 | 1 | 0 | 1 |
| Binary overflow | 8 | 8 | 0 | 6 | 1 |
| Max stress test | 9 | 9 | 1 | 9 | 1 |

## Waveform
[BCD Adder Waveform] (bcd_adder.png)

## Tools
- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code
