import sys
import re
import os
from pathlib import Path
from shutil import copyfile
import argparse
import logging

logging.getLogger(__name__)


parser = argparse.ArgumentParser()

rgxDraw = [
    re.compile('(.*\.beginDraw\(\)\;)'),
    re.compile('(.*\.endDraw\(\)\;)')
    ]



rgxMethod = re.compile('[a-zA-Z]*\s*\(.*\)\s*{')

regExLoops = [re.compile('for\s*\('), re.compile('if\s*\(')]


def file_extension(choices,fname):
    ext = os.path.splitext(fname)[1][1:]
    if ext not in choices:
       parser.error("file doesn't end with one of {}".format(choices))
    return fname

def JavaToJavascript(file_in, file_out):
    with open(file_in, 'r') as f, open(file_out, 'w') as o:
        code = f.read()

        # replace typed declarations (excluding function)
        types = ['PGraphics', 'PVector','PImage', 'float', 'float[]', 'int', 'int[]']
        
        matches = re.findall(rgxMethod, code)
        for m in matches:
            text = str(m)
            if (any (regex.match(text) for regex in regExLoops)):
                continue

            print(text)
            for var in types:
                text = text.replace(var +  " ", "")

            print(text)
            code = code.replace(str(m), text)  
            

        # replace "void" with function
        code = code.replace('void ', 'function ')
    
        for var in types:
            code = code.replace(var + ' ', 'let ')

        # replace matrix operations
        code = code.replace('.pushMatrix()', '.push()')
        code = code.replace('.popMatrix()', '.pop()')

        # replace console operations
        code = code.replace('println(', 'console.debug(')

        # remove unnecessary operations
        # comment out 'beginDraw'. Using RegEx group replacement
        for r  in rgxDraw:
            code = re.sub(r, r'/* \1 */', code)

        # replaces Java hexadecimal number with quoted string
        rgxColor = re.compile('(#......)')
        code = re.sub(rgxColor, r'"\1"', code)

        # replaces int/float array initialization
        rgxArray = re.compile('new int\[\]{(.*)}')
        code = re.sub(rgxArray, r'[\1]', code)


        # random stuff
        replaces = [ ("Long.signum", "Math.sign"),
        ("new PVector", "new p5.Vector"),
        ("(float)", ""),
        ("size(", "createCanvas("),
        ("surface.setTitle(","document.title="),
        ("saveFrame(","save(")]
        for a,b in replaces:
            code = code.replace(a,b)

        #writes output
        o.writelines(code)


def main():  
    print("Running PDE conversion to P5JS")  
    logging.basicConfig(level=logging.DEBUG,stream=sys.stdout)

    parser.add_argument('file_in', help='input file', type=lambda s:file_extension(("pde","java"),s))
    parser.add_argument('file_out', help='output file')
    args = parser.parse_args()


    # is PDE inside a sketch folder?
    fileName = Path(args.file_in).stem
    sourceFolder = Path(os.path.dirname(args.file_in))
    folderName = sourceFolder.stem
    convertFolder = False
    if fileName == folderName:
        convertFolder = True
    
    if convertFolder:
        logging.info("The file %s is inside a Processing sketch",fileName)
        dirName = "sketch-WIP"
        outputLocation = os.path.join(sourceFolder.parent, dirName)
        os.mkdir(outputLocation)
        outputFile = os.path.join(outputLocation, "sketch.js")
        JavaToJavascript(args.file_in,  outputFile)

        for fileInFolder in os.listdir(sourceFolder):
            base = Path(fileInFolder).stem
            if fileInFolder.endswith(".pde") and base != fileName:
                logging.info("Converting %s to Javascript", fileInFolder)
                JavaToJavascript(os.path.join(sourceFolder,fileInFolder),  os.path.join(outputLocation, base + ".js"))
        
        # copies index.html to ouput
        copyfile("index.html", os.path.join(outputLocation, "index.html"))
    
    else:
        JavaToJavascript(args.file_in,  args.file_out)

    

if __name__ == '__main__':
    main()