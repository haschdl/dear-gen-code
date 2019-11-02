precision mediump float;

precision mediump int;


#define M_PI 3.1415926535897932384626433832795
#define HALF_PI 1.5707963267948966192313216916398



uniform vec2 iResolution;

uniform float iTime;
const float n_points = 4.0;
uniform float fillRate;

uniform vec3 baseColor;
varying vec2 vTexCoord;


vec2 hash( vec2 p ) { 
    p=vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))); 
    return fract(sin(p)*18.5453); 
}

// return distance, and cell id
vec2 voronoi( in vec2 x )
{
    vec2 n = floor( x );
    vec2 f = fract( x );

	vec3 m = vec3( 8.0 );
    for( int j=-1; j<=1; j++ )
    for( int i=-1; i<=1; i++ )
    {
        vec2  g = vec2( float(i), float(j) );
        vec2  o = hash( n + g );
      //vec2  r = g - f + o;
	    vec2  r = g - f + (0.5+0.5*sin(iTime+6.2831*o));
		float d = dot( r, r );
        if( d<m.x )
            m = vec3( d, o );
    }

    return vec2( sqrt(m.x), m.y+m.z );
}



void main() {
     // Normalized pixel coordinates (from 0 to 1)
    float ar = iResolution.x/iResolution.y;
    vec2 uv = (2. * gl_FragCoord.xy - iResolution.xy)/iResolution.y;
    
    float m = 0.;
    float t = iTime;
    float minDist = 100.;
    
    for(float i=1.; i<=n_points; i++) {
     vec2 n = hash(vec2(i));   
        vec2 p = vec2(sin(n.x*t) * fillRate ,sin(n.y*t)/ar* fillRate);
        p.x *= ar; //aspect ratio
        
        float d = length(uv-p);
        m+= smoothstep(.02, .01,d);
        
        if(d<minDist) {
         minDist = d;   
            
        }
    }   
    
    //vec3 col = vec3(m); //m shows the points
    vec3 col = vec3(pow(minDist, 0.4));
    vec3 red = vec3(1.0,0,0);

    gl_FragColor = vec4(mix(baseColor, vec3(1.0), col.r),1.0);

   /*vec2 p = gl_FragCoord.xy/max(iResolution.x,iResolution.y);
    
    // computer voronoi patterm
    vec2 c = voronoi( (14.0+6.0*sin(0.2*iTime))*p );

    // colorize
    vec3 col = 0.5 + 0.5*cos( c.y*6.2831 + vec3(0.0,1.0,2.0) );	
    col *= clamp(1.0 - 0.4*c.x*c.x,0.0,1.0);
    col -= (1.0-smoothstep( 0.08, 0.09, c.x));
	
    gl_FragColor = vec4( col, 1.0 );
    */
}