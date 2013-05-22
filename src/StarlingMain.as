package  
{
import cn.geckos.display.TextureMovieClip;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLRequest;
import starling.display.Sprite;
import starling.events.Event
/**
 * ...starling主类
 * @author Kanon
 */
public class StarlingMain extends Sprite 
{
	public function StarlingMain() 
	{
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, loaderComplete);
		loader.load(new URLRequest("../assets/assets.swf"));
	}
	
	private function loaderComplete(event:flash.events.Event):void 
	{
		trace("loaderComplete");
		var contentLoaderInfo:LoaderInfo = event.currentTarget as LoaderInfo;
		var MyClass:Class = contentLoaderInfo.applicationDomain.getDefinition("mc") as Class;
		var mc:MovieClip = new MyClass();
		
		var textureMovieClip:TextureMovieClip = new TextureMovieClip(mc, this, 30);
		textureMovieClip.loop = false;
		textureMovieClip.alpha = .8;
		textureMovieClip.touchable = true;
		textureMovieClip.addEventListener(starling.events.Event.COMPLETE, completeHandler);
		textureMovieClip.play();
	}
	
	private function completeHandler(event:starling.events.Event):void 
	{
		trace("event", event.currentTarget);
	}
	
}
}