#!/usr/bin/python

import argparse, sys, os, glob, ezdxf

# configuration
app_name        = 'odmt'
app_version     = '1.0.0'
app_description = 'OpenSCAD DXF Merge Tool (odmt) - v' + app_version
output_file     = './merged.dxf'

# command line parser
parser = argparse.ArgumentParser(
    prog = app_name, 
    description = app_description)
parser.add_argument('--output', '-o', 
    metavar = 'path', 
    default = output_file,
    help='output file path to save the merged file')
parser.add_argument('--input_type', '-t', 
    choices = ['file', 'dir'], 
    default = 'file',
    help='set the input type')
parser.add_argument('input', 
    metavar='input', 
    nargs = '+',
    help='a directory or one or more file to be merged')
parser.add_argument('--version', '-v', action='version', version='%(prog)s ' + app_version)
args = parser.parse_args()

# variables...
input_files = []
output_file = os.path.realpath(args.output)
output_dir  = os.path.dirname(output_file)

# test output path
if os.path.isdir(output_dir) == False:
    print 'output directory not found :', output_dir
    sys.exit(1);

# input type file
if args.input_type == 'file':
    for input_file in args.input:
        if input_file.endswith('.dxf'):
            input_files.append(input_file)
    # no DXF file provided
    if len(input_files) == 0:
        print 'at least one DXF file must be provided'
        sys.exit(1);

# input type directory
elif args.input_type == 'dir':
    input_dir = os.path.realpath(args.input[0])
    if os.path.isdir(input_dir) == False:
        print 'input directory not found :', input_dir
        sys.exit(1);
    input_files = glob.glob(input_dir + '/*.dxf')
    # no DXF file provided
    if len(input_files) == 0:
        print 'no DXF file found in', input_dir
        sys.exit(1);

# ...
def merge_dxf_file(file):
    'Merge DXF file and convert continuous line to polyline.'

    print 'merging ->', file
    
    dwg.layers.create(name=layer_name, dxfattribs={'color': layer_num})

    counter    = 0
    points     = []
    last_block = []

    with open(file) as f:
        for line in f:
            line = line.strip('\n');
            
            # block start
            if line == 'LINE':
                counter = 1;
                block   = [[0, 0], [0, 0]];
            
            # in the block
            if counter > 0:
                # start line
                if counter == 5:
                    block[0][0] = line
                if counter == 7:
                    block[0][1] = line
                # end line
                if counter == 9:
                    block[1][0] = line
                if counter == 11:
                    block[1][1] = line
                # increment
                counter += 1

            # end block
            if counter == 13:
                counter = 0
                
                # discontinued line
                if len(last_block) and block[0] != last_block[1]:
                    msp.add_lwpolyline(points, dxfattribs={'layer': layer_name})
                    points = []

                points.append((block[0][0], block[0][1]))
                points.append((block[1][0], block[1][1]))
                last_block = block
            
    if len(points):
        msp.add_lwpolyline(points, dxfattribs={'layer': layer_name})

    return

# DXF file
dwg = ezdxf.new('AC1015')
msp = dwg.modelspace()

# layer
layer_name = None
layer_num  = 0

# for each file
for input_file in input_files:
    layer_name = os.path.basename(input_file).rstrip('.dxf')
    layer_num += 1
    merge_dxf_file(input_file)

# save output
dwg.saveas(output_file)
print 'output :', output_file
