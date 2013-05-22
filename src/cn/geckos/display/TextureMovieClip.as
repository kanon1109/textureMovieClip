package cn.geckos.display 
{
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import starling.core.Starling;
import starling.display.DisplayObjectContainer;
import starling.events.Event;
import starling.events.EventDispatcher;
import starling.textures.Texture;
/**
 * ...基于starling纹理的MovieClip
 * 目的为了方便的将原生的MovieClip直接转换成starling的MovieClip
 * @author Kanon
 */
public class TextureMovieClip extends EventDispatcher 
{
	//starling的影片剪辑
	private var starlingMc:starling.display.MovieClip;
	//存放纹理的列表
	private var textureVector:Vector.<Texture>;
	//播放的帧频
	private var _fps:Number;
	public function TextureMovieClip(mc:MovieClip, parent:DisplayObjectContainer, fps:Number = 12)
	{
		this._fps = fps;
		var o:Object = this.getMaxSize(mc);
		this.textureVector = this.createTextureVector(mc, o.maxWidth, o.maxHeight, o.maxLeft, o.maxTop);
		this.starlingMc = new starling.display.MovieClip(this.textureVector, this._fps);
		this.starlingMc.addEventListener(Event.COMPLETE, completeHandler);
		parent.addChild(this.starlingMc);
		Starling.juggler.add(this.starlingMc);
	}
	
	private function completeHandler(event:Event):void 
	{
		this.dispatchEvent(event); 
	}
	
	/**
	 * 创建纹理序列
	 * @param	mc		待创建的mc
	 * @param	width	创建宽度
	 * @param	height	创建高度
	 * @param	maxLeft	左上角
	 * @param	maxTop	右上角
	 * @return	纹理列表
	 */
	private function createTextureVector(mc:MovieClip, width:Number, height:Number, maxLeft:Number, maxTop:Number):Vector.<Texture>
	{
		var totalFrames:int = mc.totalFrames;
		var matrix:Matrix = new Matrix(1, 0, 0, 1, -maxLeft, -maxTop);
		var bitmapData:BitmapData;
		var texture:Texture;
		var textureVector:Vector.<Texture> = new Vector.<Texture>();
		for (var i:int = 1; i <= totalFrames; i += 1)
		{
			mc.gotoAndStop(i);
			bitmapData = new BitmapData(width, height, true, 0x000000);
			bitmapData.draw(mc, matrix);
			texture = Texture.fromBitmapData(bitmapData, false);
			textureVector.push(texture);
		}
		return textureVector;
	}
	
	/**
	 * 获取影片剪辑尺寸
	 * @param	mc  需要转换bitmapMovieClip的 影片剪辑
	 * @return  尺寸数据对象
	 */
	private function getMaxSize(mc:MovieClip):Object
	{
		var totalFrames:int = mc.totalFrames;
		mc.gotoAndStop(1);
		var rect:Rectangle = mc.getBounds(mc);
		var maxRight:Number = rect.right;
		var maxBottom:Number = rect.bottom;
		var maxLeft:Number = rect.left;
		var maxTop:Number = rect.top;
		//最大高宽
		var maxWidth:Number = rect.right - rect.left;
		var maxHeight:Number = rect.bottom - rect.top;
		if (totalFrames == 1)
			return { "maxWidth":maxWidth, "maxHeight":maxHeight, 
					 "maxLeft":maxLeft, "maxTop":maxTop };
		for (var i:int = 2; i <= totalFrames; i += 1)
		{
			mc.gotoAndStop(i);
			//找出矩形范围最大的位置
			rect = mc.getBounds(mc);
			if (rect.right > maxRight) 
				maxRight = rect.right;
			if (rect.bottom > maxBottom) 
				maxBottom = rect.bottom;
			if (rect.left < maxLeft) 
				maxLeft = rect.left;
			if (rect.top < maxTop)
				maxTop = rect.top;
		}
		maxWidth = maxRight - maxLeft;
		maxHeight = maxBottom - maxTop;
		return { "maxWidth":maxWidth, "maxHeight":maxHeight, 
				 "maxLeft":maxLeft, "maxTop":maxTop };
	}
	
	/**
	 * 销毁自己
	 */
	public function destroy():void
	{
		if (this.starlingMc)
		{
			this.starlingMc.removeEventListener(Event.COMPLETE, completeHandler);
			this.starlingMc.removeFromParent(true);
		}
		this.starlingMc = null;
		var length:int = this.textureVector.length;
		for (var i:int = length - 1; i >= 0; i -= 1) 
		{
			this.textureVector.splice(i, 1);
		}
		this.textureVector = null;
	}
	
	/**
	 * 播放动画
	 */
	public function play():void
	{
		this.starlingMc.play();
	}
	
	/**
	 * 停指播放
	 */
	public function stop():void
	{
		this.starlingMc.stop();
	}
	
	/**
	 * 暂停播放
	 */
	public function pause():void
	{
		this.starlingMc.pause();
	}
	
	/**
	 * x轴缩放比例
	 */
	public function get scaleX():Number { return this.starlingMc.scaleX };
	public function set scaleX(value:Number):void 
	{
		this.starlingMc.scaleX = value;
	}
	
	/**
	 * y轴缩放比例
	 */
	public function get scaleY():Number { return this.starlingMc.scaleY };
	public function set scaleY(value:Number):void 
	{
		this.starlingMc.scaleY = value;
	}
	
	/**
	 * 透明度
	 */
	public function get alpha():Number { return this.starlingMc.alpha };
	public function set alpha(value:Number):void 
	{
		this.starlingMc.alpha = value;
	}
	
	/**
	 * 是否显示
	 */
	public function get visible():Boolean { return this.starlingMc.visible };
	public function set visible(value:Boolean):void 
	{
		this.starlingMc.visible = value;
	}
	
	/**
	 * 角度
	 */
	public function get rotation():Number { return this.starlingMc.rotation };
	public function set rotation(value:Number):void 
	{
		this.starlingMc.rotation = value;
	}
	
	/**
	 * x轴倾斜比例
	 */
	public function get skewX():Number { return this.starlingMc.skewX };
	public function set skewX(value:Number):void 
	{
		this.starlingMc.skewX = value;
	}
	
	/**
	 * y轴倾斜比例
	 */
	public function get skewY():Number { return this.starlingMc.skewY };
	public function set skewY(value:Number):void 
	{
		this.starlingMc.skewY = value;
	}
	
	/**
	 * 是否可以点击
	 */
	public function get touchable():Boolean { return this.starlingMc.touchable };
	public function set touchable(value:Boolean):void 
	{
		this.starlingMc.touchable = value;
	}
	
	/**
	 * 帧频
	 */
	public function get fps():Number { return _fps; };
	public function set fps(value:Number):void 
	{
		_fps = value;
		this.starlingMc.fps = fps;
	}
	
	/**
	 * 是否循环播放
	 */
	public function get loop():Boolean { return this.starlingMc.loop; };
	public function set loop(value:Boolean):void 
	{
		this.starlingMc.loop = value;
	}
	
	/**
	 * 是否播放完毕
	 */
	public function get isComplete():Boolean 
	{ 
		return this.starlingMc.isComplete;
	}
	
	/**
	 * 是否处于播放中
	 */
	public function get isPlaying():Boolean 
	{ 
		return this.starlingMc.isPlaying;
	}
	
	/**
	 * 总帧数
	 */
	public function get numFrames():int 
	{ 
		return this.starlingMc.numFrames;
	}
	
	/**
	 * 播放需要花的总时间
	 */
	public function get totalTime():Number 
	{ 
		return this.starlingMc.totalTime;
	}

	/**
	 * 当前帧
	 */
	public function get currentFrame():int { return this.starlingMc.currentFrame; }
	public function set currentFrame(value:int):void
	{
		this.starlingMc.currentFrame = value;
	}
	
	/**
	 * 获取starling的原生影片剪辑
	 * @return	原生影片剪辑
	 */
	public function getNativeMovieClip():starling.display.MovieClip
	{
		return this.starlingMc;
	}
	
}
}