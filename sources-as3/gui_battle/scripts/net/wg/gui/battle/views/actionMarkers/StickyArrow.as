package net.wg.gui.battle.views.actionMarkers
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StickyArrow extends Sprite implements IDisposable
   {
       
      
      public var arrow:Sprite = null;
      
      public function StickyArrow()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setRadius(param1:int) : void
      {
         this.arrow.y = -param1;
      }
      
      protected function onDispose() : void
      {
         this.arrow = null;
      }
   }
}
