function setup() {
    createCanvas(1500, 1000, WEBGL);
    smooth(32);
    strokeWeight(2);
    rectMode(CENTER);
    background(255);
    stroke(color(0,9));
    noFill();
}


function draw() {
   reflection1();
}


function reflection1() {
    translate(0,-height/2);    
    beginShape();
    for(let i = 1; i <= 100; i++) {  
        let f =  1/pow(2,floor(i/2)*.02);
        let xf = [-1,-1,1,1][i%4]; //sequence  [0,0,1,1]*
        let x =  xf * f * f* f * width /2;
        
        let y = [ height*(1-f), f*height, f*height,  height*(1-f)][i % 4];//(i % 3) * f * height;
        let yy = y + random();
        let xx = x; 
        vertex(xx, yy);
    }
    endShape();


}
function reflection2() {
    translate(width/2,height/2);
    push();
    for(let i = 0; i <50; i++) {        
        let f =  pow(2,i*.2) ;
        //fill(noise(i,millis()/4000)*255, noise(millis()/5000+3324)*255,noise( millis()/5000 + 1233)*255,50);
        
        rect(0,0,width/f,height/f);
    }
    pop();
    ///noLoop();
}