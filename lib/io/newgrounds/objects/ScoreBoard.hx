package io.newgrounds.objects;

import io.newgrounds.components.ScoreBoardComponent;
import io.newgrounds.NGLite;

class ScoreBoard extends Object {
	
	public var scores(default, null):Array<Dynamic>;
	
	/** The numeric ID of the scoreboard.*/
	public var id(default, null):Int;
	
	/** The name of the scoreboard. */
	public var name(default, null):String;
	
	public function new(core:NGLite, data:Dynamic):Void {super(core, data); }
	
	override function parse(data:Dynamic):Void {
		
		id   = data.id;
		name = data.name;
	}
	
	public function getScores
	( limit :Int     = 10
	, skip  :Int     = 0
	, period:String  = null
	, social:Bool    = false
	, tag   :String  = null
	, user  :Dynamic = null
	):Call {
		
		return _core.scoreBoard.getScores(id, limit, skip, period, social, tag, user);
	}
	
	@:allow(ScoreBoardComponent)
	function parseScores(scores:Array<Dynamic>):Void {
		
		//TODO: keep old scores and unify new + old?
		scores = new Array<Score>();
		
		for (boardData in scores)
			scores.push(new ScoreBoard(_core, boardData));
		
		_core.log('created ${scores.length} scores');
	}
	
	public function postScore(value :Int, tag:String = null):Call {
		
		return _core.scoreBoard.postScore(id, value, tag);
	}
	
	public function toString():String {
		
		return 'ScoreBoard: $id@$name';
	}
	
}