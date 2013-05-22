package cn.geckos.display 
{
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import starling.core.Starling;
import starling.display.DisplayObjectContainer;
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
		parent.addChild(this.starlingMc);
		Starling.juggler.add(this.starlingMc);
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
		var matrix:Matrix = new Matrix();
		var bitmapData:BitmapData;
		var texture:Texture;
		var textureVector:Vector.<Texture> = new Vector.<Texture>();
		for (var i:int = 1; i <= totalFrames; i += 1)
		{
			mc.gotoAndStop(i);
			matrix.tx = -maxLeft;
			matrix.ty = -maxTop;
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
	 * 帧频
	 */
	public function get fps():Number { return _fps; };
	public function set fps(value:Number):void 
	{
		_fps = value;
		if (this.starlingMc)
			this.starlingMc.fps = fps;
	}

}
}