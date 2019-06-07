function setup() {
    createCanvas(750, 500);
    smooth(8);
    strokeWeight(.9);
    rectMode(CENTER);
    background(255);
    stroke(color(0,9));
    noFill();
}


function draw() {
   reflection2();
}


function reflection1() {
    translate(width/2,0);    
    beginShape();
    for(let i = 1; i <= 100; i++) {  
        let f =  1/pow(2,floor(i/2)*.02);
        let xf = [-1,-1,1,1][i%4]; //sequence  [0,0,1,1]*
        let x =  xf * f * f* f * width /2;
        
        let y = [ height*(1-f), f*height, f*height,  height*(1-f)][i % 4];//(i % 3) * f * height;
        let yy = y + random()*2;
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