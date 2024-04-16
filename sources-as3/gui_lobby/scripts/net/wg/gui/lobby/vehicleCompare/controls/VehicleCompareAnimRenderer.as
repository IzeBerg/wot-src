package net.wg.gui.lobby.vehicleCompare.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAnimVO;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleCompareAnimRenderer extends MovieClip implements IDisposable
   {
       
      
      public var typeIcon:IImage;
      
      public var tankName:TextField;
      
      public var bg:Sprite;
      
      private var _disposed:Boolean = false;
      
      public function VehicleCompareAnimRenderer()
      {
         super();
         this.tankName.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.typeIcon.dispose();
         this.typeIcon = null;
         this.tankName = null;
         this.bg = null;
      }
      
      public function setData(param1:VehicleCompareAnimVO) : void
      {
         this.typeIcon.source = param1.vehType;
         this.tankName.htmlText = param1.vehName;
         this.bg.x = -(this.bg.width - (this.tankName.x + this.tankName.width - this.typeIcon.x) >> 1);
      }
      
      override public function get width() : Number
      {
         return this.tankName.x + this.tankName.width - this.typeIcon.x >> 0;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
