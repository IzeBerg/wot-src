package net.wg.gui.battle.views.destroyTimers.components.notifiers
{
   import flash.display.MovieClip;
   
   public class SimpleNotifier extends MovieClip implements INotifier
   {
       
      
      public function SimpleNotifier()
      {
         super();
         mouseEnabled = mouseChildren = false;
      }
      
      public function dispose() : void
      {
      }
   }
}
