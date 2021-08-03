# Highly customizable iTopie frame generator
The [configuration file](https://github.com/lautr3k/RepRap-iTopie/blob/dev/scad/config.scad) contains about 80 variables (evilly commented) you can adjust for fine tuning (all will not be explained here). See the [build directory](https://github.com/lautr3k/RepRap-iTopie/tree/dev/build) for DXF merging/layering/cleaning tool.

# Some basic examples
### Output version
`output_version = 0` CNC milling (default)

`output_version = 1` Laser cutting (two layers glued together - Miguel Sánchez version)

### Output mode
`output_mode = 0` 2D preview (default)

`output_mode = 1` extruded view

`output_mode = 2` first layer only (plates)

`output_mode = 3` second layer only (pockets)

`output_mode = 4` 3D build preview

### Output type
`output_type = 0` all parts

`output_type = 1` plate 1 (horizontal_plate, y_carriage, feet)

`output_type = 2` plate 2 (vertical_plate, triangles, feet)

`output_type = 3` horizontal_plate only

`output_type = 4` vertical_plate only

`output_type = 5` y_carriage only

`output_type = 6` triangle only

`output_type = 7` feet only
