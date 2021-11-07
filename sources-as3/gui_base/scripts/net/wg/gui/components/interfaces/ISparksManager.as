package net.wg.gui.components.interfaces
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ISparksManager extends IDisposable
   {
       
      
      function resetZone(param1:Rectangle) : void;
      
      function createSparks() : void;
      
      function get zone() : Rectangle;
      
      function set zone(param1:Rectangle) : void;
      
      function get scope() : Sprite;
      
      function set scope(param1:Sprite) : void;
      
      function get sparkQuantity() : Number;
      
      function set sparkQuantity(param1:Number) : void;
   }
}
