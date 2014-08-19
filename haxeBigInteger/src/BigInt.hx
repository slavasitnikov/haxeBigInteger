package ;

//TODO check platforms
//TODO add Float like 1e10;
/**
*   i:Int optimization:
*   _sign = i;
*   _bits = null;
*
*   e.g.
*   fromInt(23) -> {sign:23, bits:null}
*
*   bits in big-endian order
**/
abstract BigInt(_BigInt){
	static inline var MIN_INT_32:Int = -1 * (1 << 31);
	static inline var MAX_INT_32:Int = (1 << 31) - 1;
	static inline var MASK_HIGH_BIT_INT = MIN_INT_32;
	static inline var CHUNK_BIT = 32;
	static inline var STRING_BASE = 10;

	var val(get, never):_BigInt;
	function get_val():_BigInt{ return this; }

	inline public function new():_BigInt{
		this = {sign:0, bits:null};
	}

	@:from
	public static function fromInt(value:Int):BigInt{
		var res:BigInt = new BigInt();

		if(value == MIN_INT_32){
			res.val.sign = -1;
			res.val.bits = [cast MIN_INT_32];
		}else{
			res.val.sign = value;
			res.val.bits = null;
		}

		return res;
	}

	@:from
	public static function fromUInt(value:UInt):BigInt{
		var res:BigInt = new BigInt();

		if(value <= cast(MAX_INT_32, UInt)){
			res.val.sign = cast value;
			res.val.bits = null;
		}else{
			res.val.sign = 1;
			res.val.bits = [value];
		}

		return res;
	}
//
//	@:from
//	public static function fromString(value:String):BigInt{
//
//	}


	@:to
	public function toString():String{
		if(isZero()){
			return "0";
		}
		else if(val.bits == null){
			return Std.string(val.sign);
		}else{
			var res:String = (isNeg() ? "-" : "");
			for(i in 0...val.bits.length){
				res += Std.string(val.bits[i]);
			}
			return res;
		}
	}

	public function isZero():Bool{
		return val.sign == 0;
	}

	public function isNeg():Bool{
		return val.sign < 0;
	}

	public function isPos():Bool{
		return val.sign > 0;
	}

	@:op(-A) function _neg():BigInt{
		var res:BigInt = new BigInt();
		res.val.sign = -val.sign;
		res.val.bits = val.bits;
		return res;
	}

//	@:op(++A) function _preIncrement():BigInt;
//	@:op(A++) function _postIncrement():BigInt;
//	@:op(--A) function _preDecrement():BigInt;
//	@:op(A--) function _postDecrement():BigInt;

//	@:op(A + B) static function add(a:BigInt, b:BigInt):BigInt{
//		var res:BigInt = new BigInt();
//		return res;
//	}

//	@:op(A + B) @:commutative static function addInt(a:BigInt, b:Int):BigInt{
//		var res:BigInt = new BigInt();
//		return res;
//	}
//	@:op(A + B) @:commutative static function addUInt(a:BigInt, b:UInt):BigInt;
//	@:op(A + B) @:commutative static function addString(a:BigInt, b:String):BigInt;

//	@:op(A - B) static function sub(a:BigInt, b:BigInt):BigInt;
//	@:op(A - B) static function subInt(a:BigInt, b:Int):BigInt;
//	@:op(A - B) static function intSub(a:Int, b:BigInt):BigInt;
//	@:op(A - B) static function subUInt(a:BigInt, b:UInt):BigInt;
//	@:op(A - B) static function uintSub(a:UInt, b:BigInt):BigInt;
//	@:op(A - B) static function subString(a:BigInt, b:String):BigInt;
//	@:op(A - B) static function stringSub(a:String, b:BigInt):BigInt;

//	@:op(A * B) static function mul(a:BigInt, b:BigInt):BigInt;
//	@:op(A * B) @:commutative static function mulInt(a:BigInt, b:Int):BigInt;
//	@:op(A * B) @:commutative static function mulBInt(a:BigInt, b:BInt):BigInt;
//	@:op(A * B) @:commutative static function mulString(a:BigInt, b:String):BigInt;

//	@:op(A / B) static function div(a:BigInt, b:BigInt):BigInt;
//	@:op(A / B) static function divInt(a:BigInt, b:Int):BigInt;
//	@:op(A / B) static function intDiv(a:Int, b:BigInt):BigInt;
//	@:op(A / B) static function divUInt(a:BigInt, b:UInt):BigInt;
//	@:op(A / B) static function uintDiv(a:UInt, b:BigInt):BigInt;
//	@:op(A / B) static function divString(a:BigInt, b:String):BigInt;
//	@:op(A / B) static function stringDiv(a:String, b:BigInt):BigInt;

//	@:op(A % B) static function mod(a:BigInt, b:BigInt):BigInt;
//	@:op(A % B) static function modInt(a:BigInt, b:Int):BigInt;
//	@:op(A % B) static function intMod(a:Int, b:BigInt):BigInt;
//	@:op(A % B) static function modUInt(a:BigInt, b:UInt):BigInt;
//	@:op(A % B) static function uintMod(a:UInt, b:BigInt):BigInt;
//	@:op(A % B) static function modString(a:BigInt, b:String):BigInt;
//	@:op(A % B) static function stringMod(a:String, b:BigInt):BigInt;

	@:op(A == B) static function eq(a:BigInt, b:BigInt):Bool{
		if(a.isZero() && b.isZero()) return true;
		if(a.val.bits == null && b.val.bits == null) return a.val.sign == b.val.sign;
		if(a.val.bits == null && b.val.bits != null || a.val.bits != null && b.val.bits == null) return false;
		if(a.val.sign != b.val.sign) return false;
		if(a.val.bits.length != b.val.bits.length) return false;
		for(i in 0...a.val.bits.length){
			if(a.val.bits[i] != b.val.bits[i]) return false;
		}
		return true;
	}

	@:op(A == B) @:commutative static function eqInt(a:BigInt, b:Int):Bool{
		if(b == MIN_INT_32){
			return a.val.sign == -1 && a.val.bits.length == 1 && a.val.bits[0] == cast MIN_INT_32;
		}else{
			return a.val.bits == null && a.val.sign == b;
		}
	}

//	@:op(A == B) @:commutative static function eqUInt(a:BigInt, b:UInt):Bool;
//	@:op(A == B) @:commutative static function eqString(a:BigInt, b:String):Bool;

	@:op(A != B) static function neq(a:BigInt, b:BigInt):Bool{
		return !(a == b);
	}

	@:op(A != B) @:commutative static function neqInt(a:BigInt, b:Int):Bool{
		return !(a == b);
	}
//	@:op(A != B) @:commutative static function neqUInt(a:BigInt, b:UInt):Bool;
//	@:op(A != B) @:commutative static function neqString(a:BigInt, b:String):Bool;

//	@:op(A < B) static function lt(a:BigInt, b:BigInt):Bool;
//	@:op(A < B) @:commutative static function ltInt(a:BigInt, b:Int):Bool;
//	@:op(A < B) @:commutative static function ltUInt(a:BigInt, b:UInt):Bool;
//	@:op(A < B) @:commutative static function ltString(a:BigInt, b:String):Bool;

//	@:op(A <= B) static function lte(a:BigInt, b:BigInt):Bool;
//	@:op(A <= B) @:commutative static function lteInt(a:BigInt, b:Int):Bool;
//	@:op(A <= B) @:commutative static function lteUInt(a:BigInt, b:UInt):Bool;
//	@:op(A <= B) @:commutative static function lteString(a:BigInt, b:String):Bool;

//	@:op(A > B) static function gt(a:BigInt, b:BigInt):Bool;
//	@:op(A > B) @:commutative static function gtInt(a:BigInt, b:Int):Bool;
//	@:op(A > B) @:commutative static function gtUInt(a:BigInt, b:UInt):Bool;
//	@:op(A > B) @:commutative static function gtString(a:BigInt, b:String):Bool;

//	@:op(A >= B) static function gte(a:BigInt, b:BigInt):Bool;
//	@:op(A >= B) @:commutative static function gteInt(a:BigInt, b:Int):Bool;
//	@:op(A >= B) @:commutative static function gteUInt(a:BigInt, b:UInt):Bool;
//	@:op(A >= B) @:commutative static function gteString(a:BigInt, b:String):Bool;



}

private typedef _BigInt = {
	var sign:Int;
	var bits:Array<UInt>;
}
