# Highly customizable iTopie frame generator
The [configuration file](https://github.com/lautr3k/RepRap-iTopie/blob/dev/scad/config.scad) contains about 80 variables (evilly commented) you can adjust for fine tuning (all will not be explained here).

# Some basic examples
### Output mode
`output_mode = 0` 2D preview (default)

<img src="http://pix.slic.it/p/4fa" title="output_mode=0" width="600" />

`output_mode = 1` extruded view

<img src="http://pix.slic.it/p/4fb" title="output_mode=1" width="600" />

`output_mode = 2` first layer only (plates)

<img src="http://pix.slic.it/p/4fc" title="output_mode=2" width="600" />

`output_mode = 3` second layer only (pockets)

<img src="http://pix.slic.it/p/4fd" title="output_mode=3" width="600" />

4` 3D build preview

<img src="http://pix.slic.it/p/4fe" title="output_mode=4" width="600" />

### Output type
`output_type = 0` all parts

<img src="http://pix.slic.it/p/4fa" title="output_type=0" width="600" />

`output_type = 1` plate 1 (horizontal_plate, y_carriage, feet)

<img src="http://pix.slic.it/p/4fg" title="output_type=1" width="300" />

`output_type = 2` plate 2 (vertical_plate, triangles, feet)

<img src="http://pix.slic.it/p/4fh" title="output_type=2" width="300" />

`output_type = 3` horizontal_plate only

<img src="http://pix.slic.it/p/4fi" title="output_type=3" width="300" />

`output_type = 4` vertical_plate only

<img src="http://pix.slic.it/p/4fj" title="output_type=4" width="300" />

`output_type = 5` y_carriage only

<img src="http://pix.slic.it/p/4fk" title="output_type=6" width="300" />

`output_type = 6` triangle only

<img src="http://pix.slic.it/p/4fl" title="output_type=5" width="300" />

`output_type = 7` feet only

<img src="http://pix.slic.it/p/4ff" title="output_type=7" width="600" />
