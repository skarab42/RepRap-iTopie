# iTopie DXF build tool

# Usage
```
usage: build.py [-h] [--output_type type] [--output_dir path]
                [--output_file filename] [--output_clean] [--tmp_dir path]
                [--tmp_clean] [--odmt path] [--scad path] [--openscad path]
                [--clean] [--version]

iTopie RepRap DXF builder - v1.0.0

optional arguments:
  -h, --help            show this help message and exit
  --output_type type, -t type
                        output type (default : 0)
                        -------------------------
                        0 : all (plate 1 and plate 2 in one file)
                        1 : plate 1 (horizontal_plate, y_carriage, feet)
                        2 : plate 2 (vertical_plate, triangles, feet)
  --output_dir path, -d path
                        path to the output directory (default : ./output)
  --output_file filename, -f filename
                        output filename without extension (default : auto)
  --output_clean        remove all files in the output directory (default : false)
  --tmp_dir path        path to the temporary directory (default : ./tmp)
  --tmp_clean           remove all files in the temporary directory (default : true)
  --odmt path           path to the OpenSCAD DXF Merge Tool (default : ../odmt/odmt.py)
  --scad path           path to the main OpenSCAD file (default : ../scad/main.scad)
  --openscad path       path to the OpenSCAD binary (default : C:/Program Files/OpenSCAD/openscad.exe)
  --clean, -c           remove all files in temporary and output directories (default : false)
  --version, -v         show program's version number and exit
```
