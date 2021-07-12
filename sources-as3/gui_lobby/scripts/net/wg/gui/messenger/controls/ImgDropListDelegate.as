package net.wg.gui.messenger.controls
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class ImgDropListDelegate extends UIComponentEx implements IDropItem, IUpdatable
   {
       
      
      private var _data:Object;
      
      public function ImgDropListDelegate()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function get getCursorType() : String
      {
         return "";
      }
      
      public function update(param1:Object) : void
      {
         this._data = param1;
      }
      
      public function setProvider(param1:DisplayObject) : void
      {
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,App.utils.commons.rgbToArgb(0,0));
         _loc2_.draw(param1);
         var _loc3_:Bitmap = new Bitmap(_loc2_);
         addChild(_loc3_);
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         super.onDispose();
      }
   }
}
