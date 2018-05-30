# Techniques

## Using a palette of colors

When drawing with code, you have many options to apply color. One common way, especially when getting started, or just for trying out, is simply to assign a random color to your composition, by using `random(255)`. 

```java
color c = color(random(255), random(255),random(255))
``` 
One idea that I used in several drawings is to first choose a few colors and pick randomly from that list. I use services such as [coolors.co/](https://coolors.co/) to generate and tweak color palettes, and when I am satisfied with the colors, I simply copy and paste the hexadecimal values to Processing.

```java
//A palette with 5 colors
int[] palette = new int[]{ #88498F, #779FA1, #E0CBA8, #FF6542, #564154 };
//choosing a 'random' color from my palette
color c = palette[int(random(5))];
//same as 
color c = palette[int(random(palette.length))];

```
> Remember that in Processing colors are simple integer numbers. Numbers can also be written in hexadecimal, as above. 