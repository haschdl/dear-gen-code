At the rose garden
==================

   This composition is part of the `Dear Gen`_ project.

|image0| 

Water color effect
------------------

*At the rose garden* was an experiment with the ideas presented by artist Tyler Hobbs 
in his article *A generative approach to simulating watercolor paints* [1]_.
The idea of the algorithm is to draw a polygon, for example a decahedron, and replace 
each side AB with two new segments, AC' and C'B, where C' is a point around the midpoint C
between A an B. Taylor uses the Gaussian distribution to determine C' from C, meaning 
most points will be very close to C, and a few will be very distant from C, causing an organic 
feel to the distortion.


.. table:: How the algorithm works. (C) Tyler Hobbs [1]_

   =========== ============
   |figure1|   |figure2|          
   |figure3|   |figure4|
   =========== ============

The :code:`deformBlob()` is an implementation of the algorithm above.


.. code-block:: Java
    :lineno-start: 1
    :emphasize-lines: 1,18,19

    ArrayList<PVector> deformBlob(ArrayList<PVector> basePolygon, int iterations) {
        ArrayList<PVector> blob = new ArrayList<PVector>();
        blob.clear();
        for (int j=0, si=basePolygon.size(); j<si; j++) {
            blob.add(basePolygon.get(j));
        }

        for (int i = 1; i < iterations; i++) {
            vertices = new ArrayList<PVector>();
            for (int v =0, l = blob.size(); v<l; v++) {
            PVector A = blob.get((v%l));
            PVector B = blob.get((v+1)%l);
            PVector C = PVector.lerp(A, B, 0.5); //medium point

            // Get a gaussian random number w/ mean of 0 and standard deviation of m
            // moves point B by adding to the Gaussian number
            float m = A.dist(B);
            C.x +=randomGaussian() * m * .25;
            C.y +=randomGaussian() * m * .25;
            
            vertices.add(A);
            vertices.add(C);      
            //Note we don't add "B", since it would be added twice
            //"B" is "A" in the next iteration of "i"

            }
            blob.clear();
            for (int j=0, si=vertices.size(); j<si; j++) {
            blob.add(vertices.get(j));
            }
        }
        vertices.clear();
        return blob;
    }

.. _Dear Gen: :doc:index

.. [1] http://www.tylerlhobbs.com/writings/watercolor

.. |image0| image::  assets/03-sto-extra-rosario-small.png
.. |figure1| image:: /assets/ref-watercolor-01.png
.. |figure2| image:: /assets/ref-watercolor-02.png
.. |figure3| image:: /assets/ref-watercolor-03.png
.. |figure4| image:: /assets/ref-watercolor-04.png
