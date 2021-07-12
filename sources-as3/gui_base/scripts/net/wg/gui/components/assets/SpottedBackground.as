package net.wg.gui.components.assets
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SpottedBackground extends Sprite implements IDisposable
   {
      
      private static const SPOTTED_BG_IMG_ALIAS:String = "ShadowBgBitmapUI";
       
      
      private var _bitmapData:BitmapData;
      
      public function SpottedBackground()
      {
         super();
         var _loc1_:Class = App.utils.classFactory.getClass(SPOTTED_BG_IMG_ALIAS);
         this._bitmapData = new _loc1_();
         var _loc2_:Sprite = new Sprite();
         addChild(_loc2_);
         hitArea = _loc2_;
      }
      
      public final function dispose() : void
      {
         this._bitmapData.dispose();
         this._bitmapData = null;
      }
      
      public function setWidth(param1:int) : void
      {
         graphics.clear();
         graphics.beginBitmapFill(this._bitmapData);
         graphics.drawRect(0,0,param1,this._bitmapData.height);
         graphics.endFill();
      }
   }
}
