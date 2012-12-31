package  {
	
	public class WstPoint {

		public var x:Number;
		public var y:Number;
		
		public function WstPoint(x:Number, y:Number) {
			this.x = x;
			this.y = y;
		}
		
		public function addTo(other:WstPoint):void {
			x += other.x;
			y += other.y;
		}
		
		public function multiplyBy(k:Number):void {
			x *= k;
			y *= k;
		}
		
		public function negative():WstPoint {
			return new WstPoint(-x, -y);
		}
		
		public function unit(length:Number = 1):WstPoint {
			return WstPoint.multiply(this, length/norm());
		}
		
		public function norm():Number {
			return Math.sqrt(x*x + y*y);
		}
		
		public function rotate(degrees:Number):WstPoint {
			var cos:Number = Math.cos(degrees*Math.PI/180);
			var sin:Number = Math.sin(degrees*Math.PI/180);
			
			return new WstPoint(x*cos - y*sin, x*sin + y*cos);
		}
		
		public function equals(o:WstPoint):Boolean {
			return o.x == x && o.y == y;
		}
		
		public static function add(a:WstPoint, b:WstPoint):WstPoint {
			return new WstPoint(a.x + b.x, a.y + b.y);
		}
		
		public static function subtract(a:WstPoint, b:WstPoint):WstPoint {
			return new WstPoint(a.x - b.x, a.y - b.y);
		}
		
		public static function multiply(a:WstPoint, k:Number):WstPoint {
			return new WstPoint(a.x*k, a.y*k);
		}
		
		public static function dotProduct(a:WstPoint, b:WstPoint):Number {
			return a.x * b.x + a.y * b.y;
		}
		
		public static function distance(a:WstPoint, b:WstPoint) {
			return Math.sqrt((a.x - b.x)*(a.x - b.x) + (a.y - b.y) *(a.y - b.y));
		}
		
		public static function get zero():WstPoint {
			return new WstPoint(0,0);
		}
		
		
		public static function rand(magnitude:Number, origin:WstPoint = null):WstPoint {
			if (origin == null)
				origin = WstPoint.zero;
			return add(origin, (new WstPoint(magnitude * Math.random(), 0)).rotate(Math.random() * 360));
		}

	}
	
}
