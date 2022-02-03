package net.wg.gui.components.icons
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SquadIcon extends Sprite implements IDisposable
   {
      
      private static const ICO_START_NAME:String = "squad";
      
      private static const ICO_TYPE_GOLD:String = "Gold";
      
      private static const ICO_TYPE_SILVER:String = "Silver";
       
      
      public var icoFeelPlace:BitmapFill = null;
      
      private var _disposed:Boolean = false;
      
      public function SquadIcon()
      {
         super();
      }
      
      private static function getBitmapName(param1:Boolean, param2:uint) : String
      {
         var _loc3_:String = !!param1 ? ICO_TYPE_GOLD : ICO_TYPE_SILVER;
         return ICO_START_NAME + _loc3_ + param2.toString();
      }
      
      override public function toString() : String
      {
         return "[WG SquadIcon " + name + "]";
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.icoFeelPlace.dispose();
         this.icoFeelPlace = null;
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function show(param1:Boolean, param2:uint) : void
      {
         this.icoFeelPlace.source = getBitmapName(param1,param2);
         visible = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
