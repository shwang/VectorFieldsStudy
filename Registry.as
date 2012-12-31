package  {
	import flash.display.Stage;
	
	public class Registry {
		
		public static var stage:Stage = null;
		
		public static var colorSelection:uint = COLOR_RAINBOW_GRADIENT;
		public static var vfSelection:uint = DEFAULT_VF;
		
		//Color Schemes
		public static const COLOR_RAINBOW_GRADIENT:uint = 0;
		public static const COLOR_LIME:uint = 1;
		
		//Vector Fields
		public static const VF_CIRCULAR:uint = 0;
		public static const VF_RANDOM:uint = 1;
		public static const VF_SINE:uint = 2;
		public static const VF_EXPLOSION:uint = 3;
		public static const VF_CONVERGE:uint = 4;
		public static const VF_CIRCLES:uint = 5;
		public static const VF_STREAM:uint = 6;
		public static const NUM_VF:uint = 7;
		
		//Defaults
		public static const DEFAULT_RANGE:uint = 500;
		public static const DEFAULT_POPULATION:uint = 4000;
		public static const DEFAULT_RADIUS:uint = 1;
		public static const DEFAULT_VF:uint = VF_EXPLOSION;
		
		//Handy Constants
		public static const STAGE_WIDTH:Number = 600;
		public static const STAGE_HEIGHT:Number = 600;
		public static var TRANSLATION:WstPoint = new WstPoint(STAGE_WIDTH/2, STAGE_HEIGHT/2); //psuedo constant? :P
		public static function isOffscreen(point:WstPoint):Boolean {
			return point.norm() > DEFAULT_RANGE;
		}
		public static function adjustToScreen(point:WstPoint):WstPoint {
			return WstPoint.add(point, TRANSLATION);
		}
		public static function evaluateVectorAt(point:WstPoint):WstPoint {
			var x:Number = point.x;
			var y:Number = point.y;
			switch(vfSelection) {
				case VF_CIRCULAR:
				return new WstPoint(-point.y, point.x).unit();
				case VF_RANDOM:
				return WstPoint.rand(1);
				case VF_SINE:
				return new WstPoint(1,Math.sin(point.x/3)*2);
				case VF_EXPLOSION:
				return new WstPoint(point.x,point.y).unit(4);
				case VF_CONVERGE:
				return new WstPoint(2*Math.sin(point.x/10)+0.02,2*Math.cos(point.y/10)+0.02);
				case VF_CIRCLES:
				return new WstPoint(Math.pow(Math.sin(y/10),3),Math.pow(Math.cos(x/10),3));
				case VF_STREAM:
				return new WstPoint(0.3, 5*Math.cos(x*x/1000+y*y/10000));
				default:
				return WstPoint.zero;
			}
		}
		public static function evaluateColorAt(point:WstPoint):Number {
			switch(colorSelection) {
				case COLOR_RAINBOW_GRADIENT:
				return rainbowGradient(point.norm()/DEFAULT_RANGE);
				case COLOR_LIME:
				return 0x33FF33;
				default:
				return 0xFFFFFF;
			}
		}
		private static function rainbowGradient(pos:Number):Number
		{
			if (pos > 1 || pos < 0)
			{
				return 0;
			}
			var colors:Array = [0xFF0000,0xFFAA00,0xFFFF00,0x00FF00,0x0000FF,0xFF00FF,0x272727];
			pos *=  colors.length;

			var upper:uint = Math.ceil(pos);
			var lower:uint = Math.floor(pos);
			var uR:uint = (( colors[upper] >> 16 ) & 0xFF);
			var uG:uint = ( (colors[upper] >> 8) & 0xFF );
			var uB:uint = ( colors[upper] & 0xFF );
			var lR:uint = (( colors[lower] >> 16 ) & 0xFF);
			var lG:uint = ( (colors[lower] >> 8) & 0xFF );
			var lB:uint = ( colors[lower] & 0xFF );
			
			var lowerProportion:Number = upper - pos;
			var upperProportion:Number = pos - lower;
			var R:int = lowerProportion * lR + upperProportion * uR;
			var G:int = lowerProportion * lG + upperProportion * uG;
			var B:int = lowerProportion * lB + upperProportion * uB;
			if (R > 0xFF)
			{
				R = 0xFF;
			}
			if (R < 0)
			{
				R = 0;
			}
			if (R > 0xFF)
			{
				R = 0xFF;
			}
			if (G < 0)
			{
				G = 0;
			}
			if (G > 0xFF)
			{
				G = 0xFF;
			}
			if (B > 0xFF)
			{
				B = 0xFF;
			}
			if (B < 0)
			{
				B = 0;
			}
			return ( ( R << 16 ) | ( G << 8 ) | B );
		}

	}
	
}
