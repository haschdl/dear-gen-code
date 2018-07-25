public boolean InsideHexagon(float x, float y, float outerRadius)
{
  // Check length against inner and outer radius
  float l2 =  (x * x + y * y) / pow(outerRadius, 2);
  if (l2 > 1.0f) return false;
  if (l2 < 0.75f ) return true; // (sqrt(3)/2)^2 = 3/4

  // Check against borders
  float px = x * 1.15470053838f  ; // 2/sqrt(3)
  if (px > 1.0f || px < - 1.0f) return false;

  float py = 0.5f * px  + y;
  if (py > 1.0f || py < - 1.0f) return false;

  if (px - py > 1.0f || px - py < -1.0f) return false;

  return true;
}
