#!/usr/bin/env python3
"""
Spectrum Color Generator - Perceptually-uniform color interpolation
Generates evenly-spaced colors using LAB color space via the colour package.

Dependency: colour (pip install colour / yay -S python-colour)

Usage:
  ./generate-spectrum.py <start_hex> <end_hex> <count>

Example:
  ./generate-spectrum.py c4746e a292a3 9

Output:
  One hex color per line (without #)
"""

import sys
from colour import Color


def generate_spectrum(start_hex: str, end_hex: str, count: int) -> list[str]:
    """
    Generate N evenly-spaced colors using LAB interpolation.

    Args:
        start_hex: Starting color (hex without #)
        end_hex: Ending color (hex without #)
        count: Number of colors to generate

    Returns:
        List of hex colors (without #)
    """
    if count < 1:
        return []
    if count == 1:
        return [start_hex]

    # Create Color objects (colour handles # prefix gracefully)
    start = Color(f"#{start_hex.lstrip('#')}")
    end = Color(f"#{end_hex.lstrip('#')}")

    # Generate perceptually-uniform spectrum (LAB interpolation)
    spectrum = list(start.range_to(end, count))

    # Extract hex values (without #)
    return [color.hex_l[1:] for color in spectrum]


def main():
    """Command-line interface."""
    if len(sys.argv) < 4:
        print(__doc__)
        return 1

    try:
        start_hex = sys.argv[1]
        end_hex = sys.argv[2]
        count = int(sys.argv[3])

        # Validate count
        if count < 1:
            raise ValueError("Count must be at least 1")

        # Generate spectrum
        colors = generate_spectrum(start_hex, end_hex, count)

        # Output: one color per line (easy template parsing)
        for color in colors:
            print(color)

        return 0

    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())