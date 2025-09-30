# Spectrum Color Generation System

## Purpose
Algorithmic generation of perceptually-uniform color progressions for aesthetic purposes.

## Key Insight
Separates **spectral** (aesthetic) from **semantic** (meaning) colors:
- **Semantic colors**: error=red, success=green (meaning matters)
- **Spectral colors**: rainbow progressions (position in spectrum matters)

## Architecture
- **Python Script**: `scripts/generate-spectrum.py` - LAB interpolation via `colour` package
- **Dependency**: `python-colour` (installed via pacman)
- **Method**: Perceptually-uniform LAB color space interpolation
- **Implementation**: Waybar status modules (10 colors: red → violet)

## Usage Example (Waybar CSS Template)
```go-template
{{- $modules := list "disk" "cpu" "memory" "backlight" "pulseaudio" "bluetooth" "network" "custom-weather" "battery" "clock" -}}
{{- $script := joinPath .chezmoi.sourceDir ".." "scripts" "generate-spectrum.py" -}}
{{- $output := output "python3" $script (index $c "red") (index $c "magenta") (toString (len $modules)) -}}
{{- $spectrum := $output | trim | splitList "\n" -}}

{{- range $i, $module := $modules }}
#{{ $module }} { color: #{{ index $spectrum $i }}; }
{{- end }}
```

## Benefits
- **Automatic Adjustment**: Add/remove modules → spectrum rebalances perfectly
- **Perceptually Uniform**: Colors appear evenly-spaced to human eye (LAB color space)
- **Zero Maintenance**: No manual color picking ever again
- **Flexibility**: Change endpoints (red→violet, warm, cool, etc.)

## When to Use
- Status bars with multiple modules requiring visual progression
- Any UI needing evenly-distributed color sequences
- Aesthetic color gradients that must adapt to varying item counts

## See Also
`docs/semantic-color-architecture.md` for complete documentation