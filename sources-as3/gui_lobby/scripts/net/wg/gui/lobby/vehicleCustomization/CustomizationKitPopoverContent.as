package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationKitPopoverContent extends Sprite implements IDisposable
   {
      
      private static const CONTENT_H_MARGIN:int = -7;
       
      
      public var table:CustomizationKitTable = null;
      
      public function CustomizationKitPopoverContent()
      {
         super();
      }
      
      override public function get height() : Number
      {
         return super.height + CONTENT_H_MARGIN;
      }
      
      public final function dispose() : void
      {
         this.table.dispose();
         this.table = null;
      }
   }
}
