package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CarouselRTSInfo extends Sprite implements IDisposable
   {
       
      
      public var indexLabel:TextField = null;
      
      private var _isDisposed:Boolean = false;
      
      public function CarouselRTSInfo()
      {
         super();
         mouseChildren = mouseEnabled = false;
      }
      
      public final function dispose() : void
      {
         this.indexLabel = null;
         this._isDisposed = true;
      }
      
      public function setData(param1:Number) : void
      {
         var _loc2_:Boolean = param1 > 0;
         this.indexLabel.visible = _loc2_;
         this.indexLabel.text = param1.toString();
      }
      
      public final function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
