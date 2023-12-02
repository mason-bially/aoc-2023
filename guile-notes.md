

Useful links:
- https://www.draketo.de/proj/guile-basics/

### Enable Readline

```guile
(use-modules (ice-9 readline))
(activate-readline)
```

### Enable Documentation Lookup

```guile
(use-modules (texinfo reflection))
(help append)
```