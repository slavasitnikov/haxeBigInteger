package;

import BigInt;
import flash.display.Sprite;

class Main extends Sprite {
	public function new () {
		super ();

		var i:Int = -1 * (1 << 31);
		var b = BigInt.fromInt(i);
	}
}