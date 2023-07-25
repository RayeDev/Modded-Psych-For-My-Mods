package misc;

import states.PlayState;

class ForeverAccuracy
{
	//
	public static var accuracy:Float;
	public static var trueAccuracy:Float;
    public static var notesHit:Int = 0;
	public static function callAccuracy()
	{
		// reset the accuracy to 0%
		accuracy = 0.001;
		trueAccuracy = 0;
        notesHit = 0;
	}
	public static function updateAccuracy(judgement:Int, ?isSustain:Bool = false, ?segmentCount:Int = 1)
	{
		if (!isSustain)
		{
			notesHit++;
			accuracy += (Math.max(0, judgement));
		}
		else
		{
			accuracy += (Math.max(0, judgement) / segmentCount);
		}
		trueAccuracy = (accuracy / notesHit);
	}
	public static function getAccuracy()
	{
		return trueAccuracy;
	}
}