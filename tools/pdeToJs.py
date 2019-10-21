import re

input = "example1.pde"
output = "example1.js"

rgxDraw = [
    re.compile('(.*\.beginDraw\(\)\;)'),
    re.compile('(.*\.beginDraw\(\)\;)'
    ]

rgxMethod = re.compile('[a-zA-Z]*\s*\(.*\)\s*{')

regExLoops = [re.compile('for\s*\('), re.compile('if\s*\(')]

with open(input, 'r') as f, open(output, 'w') as o:
    code = f.read()

    # replace typed declarations (excluding function)
    types = ['PGraphics', 'PVector', 'float', 'int']
    
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


    # random stuff
    replaces = [ ("Long.signum", "Math.sign"),
    ("new PVector", "new p5.Vector")]
    for a,b in replaces:
        code = code.replace(a,b)

    #writes output
    o.writelines(code)

