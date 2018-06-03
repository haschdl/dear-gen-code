Techniques
==========

Using a palette of colors
-------------------------

In several drawings of the Dear Gen project I used a predefined palette of colors, instead of generating the colors with code.
I use services such as `coolors.co <https://coolors.co/>`_ to generate and tweak color palettes, 
and when I am satisfied with the colors, I simply copy and paste the hexadecimal values to an array in my sketch code. 
I can then pick a color from the palette using :code:`palette[index]` and use it to 
set fill color or stroke color.

.. code-block:: Java

    void setup() {
        //A palette with 5 colors
        int[] palette = new int[]{ 0xFFE28413, 0xFFF56416, 0xFFDD4B1A, 0xFFEF271B, 0xFFEA1744 };
        
        //choosing a 'random' color from my palette
        color c = palette[int(random(5))];
        
        //same as 
        color c = palette[int(random(palette.length))];
    }

.. TIP:: Remember that in Processing colors are simple integer numbers. Numbers can also be written in hexadecimal, as above. 

If you are interested in a more comprehensive discussion on colors in generative drawing, I highly recommend the article `Working with 
color in generative art <http://www.tylerlhobbs.com/writings/generative-colors>`_, by the digital artist Tyler Hobs.

Creating high-resolution images
-------------------------------
To create high-resolution image exports, you can draw to a ``PGraphics`` object, which in 
most sketches of this project is named ``buffer``. The basic process is as follows:

1. Declare a PGraphics object as a global variable on the top of the sketch code: 
    ``PGraphics buffer;``

2. In :code:`setup()`, you must use the method `createGraphics()` to instantiate the object. 
      ``buffer = createGraphics(3000, 2000);``

3. In ``setup()`` and ``draw()``, do all drawing operations on the ``buffer`` object.

4. Finally, at the end of the ``draw()`` method, show the contents of the buffer with ``image(buffer,0,0,width,height)``.
   This approach scales down the contents of the buffer to the size of your sketch (``width`` and ``height``).




Saving the file
---------------
In most sketches the code to export the image is inside the :code:`keyPressed()` method, as below.
In line 2, I used the key :kbd:`S` to save the sketch by checking the variable :code:`key`, which is available in Processing 
as a global variable. The with :code:`String.format` I create the file name, usually adding the time to the file name, so 
that all files are saved - if you use only "filename.jpg", then the exported image is replaced every time you press :kbd:`S`.



.. code-block:: Java
 
    void keyPressed() {
        if (key == 'S' || key == 's') {
            String fileName = String.format("water_color_%02d%02d%02d.tiff", hour(), minute(), second());
            buffer.save(fileName);
            println("Composition saved!");
        }
    }




