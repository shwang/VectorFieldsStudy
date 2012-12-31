package  {
	import flash.display.*;
	public class Particle extends WstPoint implements IUpdateable, IDrawable{
		
		public function Particle(x:Number, y:Number) {
			super(x, y);
		}
		
		public function update():void {
			if (Registry.isOffscreen(this)) {
				var loc:WstPoint = WstPoint.rand(Registry.DEFAULT_RANGE);
				this.x = loc.x;
				this.y = loc.y;
			}
			addTo(Registry.evaluateVectorAt(this));
		}
		
		public function draw(g:Graphics):void {
			var color:Number = Registry.evaluateColorAt(this);
			var prime:WstPoint = Registry.adjustToScreen(this);
			g.beginFill(color);
			g.drawCircle(prime.x, prime.y, Registry.DEFAULT_RADIUS);
			g.endFill();
		}
		
		public static function rand(magnitude:Number, origin:WstPoint = null):Particle {
			var loc:WstPoint = WstPoint.rand(magnitude, origin);
			return new Particle(loc.x, loc.y);
		}

	}
	
}
