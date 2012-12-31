package  {
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class Main extends Sprite {
		private var started:Boolean = false;
		private var paused:Boolean = false;
		
		private var particles:Array = [];
		
		public function Main() {
			start();
		}
		
		public function start():void {
			populateParticles();
			addEventListener(Event.ENTER_FRAME, step);
			Registry.stage.addEventListener(MouseEvent.CLICK, mouseClick);
			Registry.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function populateParticles():void {
			var i:uint = 0;
			do {
				particles[i] = Particle.rand(Registry.DEFAULT_RANGE);
			} while(++i < Registry.DEFAULT_POPULATION)
		}
		public function end():void {
			started = false;
			particles = [];
		}
		
		public function reset():void {
			if (started) end();
			start();
		}
		
		public function step(evt:Event = null):void {
			if (paused) return;
			graphics.clear();
			var i:int = -1;
			while(++i < particles.length) {
				var e:Particle = particles[i];
				e.update();
				e.draw(graphics);
			}
			//paused = true;
		}
		
		
		public function mouseClick(evt:Event = null):void {
			//trace("click");
			++Registry.vfSelection;
			Registry.vfSelection %= Registry.NUM_VF;
		}
		
		public function keyUp(evt:KeyboardEvent):void {
		}

	}
	
}
