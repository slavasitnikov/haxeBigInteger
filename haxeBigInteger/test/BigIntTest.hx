package;

import BigInt;
import massive.munit.Assert;

class BigIntTest{
	static var MAX_INT:Int = (1 << 31) - 1;
	static var MIN_INT:Int = -1 * (1 << 31);
	public function new(){}

//	@Test
//	public function zeroToString():Void {
//		Assert.areEqual("0", BigInt.fromInt(0).toString());
//		var b:BigInt = 0;
//		Assert.areEqual("0", b.toString());
//	}
//
//	@Test
//	public function positiveIntToString():Void {
//		Assert.areEqual("2000", BigInt.fromInt(2000).toString());
//	}
//
//	@Test
//	public function negativeIntToString():Void {
//		Assert.areEqual("-2000", BigInt.fromInt(-2000).toString());
//	}
//
//	@Test
//	public function maxIntToString():Void {
//		Assert.areEqual(Std.string(MAX_INT), BigInt.fromInt(MAX_INT).toString());
//	}
//
//	@Test
//	public function minIntToString():Void {
////		Assert.areEqual(Std.string(MIN_INT), BigInt.fromInt(MIN_INT).toString());
//	}

	/**
	*   @:op(A == B) static function eq(a:BigInt, b:Int):Bool;
	**/
//	@Test
//	public function zeroBigIntAndIntEquals():Void {
//		Assert.isTrue(BigInt.fromInt(0) == 0);
//	}
//
//	@Test
//	public function maxIntBigIntAndIntEquals():Void {
//		Assert.isTrue(BigInt.fromInt(MAX_INT) == MAX_INT);
//	}
//
//	@Test
//	public function minIntBigIntAndIntEquals():Void {
//		Assert.isTrue(BigInt.fromInt(MIN_INT) == MIN_INT);
//	}

	@Test
	public function errorTest():Void {
		Assert.isTrue(false);
	}


	/**
	*   @:op(A == B) static function eq(a:BigInt, b:BigInt):Bool;
	**/
	@Test
	public function zeroBigIntsEquals():Void {
		Assert.isTrue(BigInt.fromInt(0) == BigInt.fromInt(0));
	}

	@Test
	public function maxIntBigIntsEquals():Void {
		Assert.isTrue(BigInt.fromInt(MAX_INT) == BigInt.fromInt(MAX_INT));
	}

	@Test
	public function minIntBigIntsEquals():Void {
		Assert.isTrue(BigInt.fromInt(MIN_INT) == BigInt.fromInt(MIN_INT));
	}

	/**
	*   @:op(-A)
	**/
//	@Test
//	public function negBigInt():Void {
//		var b:BigInt = 2000;
//		Assert.isTrue(BigInt.fromInt(-2000) == -b);
//	}

}