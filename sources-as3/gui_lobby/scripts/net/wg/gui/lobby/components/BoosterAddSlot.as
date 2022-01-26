package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   
   public class BoosterAddSlot extends BaseBoosterSlot
   {
       
      
      public var animation:MovieClip;
      
      public function BoosterAddSlot()
      {
         super();
         addOffsettedItems(this.animation);
      }
      
      override protected function onDispose() : void
      {
         this.animation = null;
         super.onDispose();
      }
   }
}
