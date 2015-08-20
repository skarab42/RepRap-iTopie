#!/usr/bin/python

import argparse, os
from argparse import RawTextHelpFormatter
from subprocess import call

# -----------------------------------------------------------------------------
# configuration
# -----------------------------------------------------------------------------
# build tool version
version     = '1.0.0'
description = 'iTopie RepRap DXF builder - v' + version

# output version
# 0 : CNC milling (default)
# 1 : Laser cutting
outputVersion = 0;

# output type
# 0 : all plates
# 1 : plate 1 (horizontal_plate, y_carriage, feet)
# 2 : plate 2 (vertical_plate, triangles, feet)
outputType = 0;

# output path
outputFilename  = 'auto';
outputDirectory = './output';
outputAutoClean = False;

# temporary path
tmpDirectory = './tmp';
tmpAutoClean = True;

# path to OpenSCAD DXF Merge (and clean) Tool
odmtPath = '../odmt/odmt.py';

# iTopie main scad file path
mainScadFile = '../scad/main.scad';

# path to the OpenSCAD binary
openscadPath = 'C:/Program Files/OpenSCAD/openscad.exe';

# -----------------------------------------------------------------------------

# command line parser
parser = argparse.ArgumentParser(
    description = description,
    formatter_class=RawTextHelpFormatter);
parser.add_argument('--target',
    metavar = 'int',
    default = outputVersion,
    help    = 'output version (default : 0)\n'
              '----------------------------\n'
              '0 : CNC milling (default)\n'
              '1 : Laser cutting');
parser.add_argument('--output_type', '-t',
    metavar = 'int',
    default = outputType,
    help    = 'output type (default : 0)\n'
              '-------------------------\n'
              '0 : all (plate 1 and plate 2 in one file)\n'
              '1 : plate 1 (horizontal_plate, y_carriage, feet)\n'
              '2 : plate 2 (vertical_plate, triangles, feet)');
parser.add_argument('--output_dir', '-d',
    metavar = 'path',
    default = outputDirectory,
    help    = 'path to the output directory (default : '+outputDirectory+')');
parser.add_argument('--output_file', '-f',
    metavar = 'filename',
    default = outputFilename,
    help    = 'output filename without extension (default : '+outputFilename+')');
parser.add_argument('--output_clean',
    action  = 'store_true',
    help    = 'remove all files in the output directory (default : false)');
parser.add_argument('--tmp_dir',       
    metavar = 'path', 
    default = tmpDirectory,
    help    = 'path to the temporary directory (default : '+tmpDirectory+')');
parser.add_argument('--tmp_clean',
    action  = 'store_false',
    help    = 'remove all files in the temporary directory (default : true)');
parser.add_argument('--odmt',
    metavar = 'path',
    default = odmtPath,
    help    = 'path to the OpenSCAD DXF Merge Tool (default : '+odmtPath+')');
parser.add_argument('--scad',
    metavar = 'path',
    default = mainScadFile,
    help    = 'path to the main OpenSCAD file (default : '+mainScadFile+')');
parser.add_argument('--openscad',
    metavar = 'path',
    default = openscadPath,
    help    = 'path to the OpenSCAD binary (default : '+openscadPath+')');
parser.add_argument('--clean', '-c',
    action  = 'store_true',
    help    = 'remove all files in temporary and output directories (default : false)');
parser.add_argument('--version', '-v', action='version', version=description);
args = parser.parse_args();

# user settings
outputType      = int(args.output_type);
outputVersion   = int(args.target);
outputAutoClean = args.clean or args.output_clean;
tmpAutoClean    = args.clean or args.tmp_clean;

outputDirectory = os.path.realpath(args.output_dir);
openscadPath    = os.path.realpath(args.openscad);
mainScadFile    = os.path.realpath(args.scad);
tmpDirectory    = os.path.realpath(args.tmp_dir);
odmtPath        = os.path.realpath(args.odmt);

# clean output folder
if outputAutoClean:
    print 'clean -> '+outputDirectory;
    for outputFile in os.listdir(outputDirectory):
        os.unlink(os.path.join(outputDirectory, outputFile));

# output file name
if outputType == 1:
    outputFilename = 'iTopie_plate_1';
elif outputType == 2:
    outputFilename = 'iTopie_plate_2';
else:
    outputType     = 0;
    outputFilename = 'iTopie_plates';

if args.output_file != 'auto':
    outputFilename = args.output_file;

outputFile = os.path.realpath(os.path.join(outputDirectory, outputFilename+'.dxf'));
tmpFile1   = os.path.realpath(os.path.join(tmpDirectory, outputFilename+'_layer_1.dxf'));
tmpFile2   = os.path.realpath(os.path.join(tmpDirectory, outputFilename+'_layer_2.dxf'));

# build process
print 'create -> '+tmpFile1;
call([openscadPath, 
    '-o', tmpFile1,
    '-D', 'output_mode=2', # first layer
    '-D', 'output_type='+str(outputType),
    '-D', 'output_version='+str(outputVersion),
    mainScadFile]);

print 'create -> '+tmpFile2;
call([openscadPath, 
    '-o', tmpFile2,
    '-D', 'output_mode=3', # second layer
    '-D', 'output_type='+str(outputType),
    '-D', 'output_version='+str(outputVersion),
    mainScadFile]);

call(['python', odmtPath, 
    'input', tmpFile1, tmpFile2,
    '--output', outputFile]);

# clean temporary folder
if tmpAutoClean:
    print 'clean -> '+tmpDirectory;
    for tmpFile in os.listdir(tmpDirectory):
        if tmpFile[0] != '.': # avoid remove .git*
            os.unlink(os.path.join(tmpDirectory, tmpFile));

print 'done!';
