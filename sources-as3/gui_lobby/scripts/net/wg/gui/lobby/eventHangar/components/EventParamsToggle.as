package net.wg.gui.lobby.eventHangar.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButtonEx;
   
   public class EventParamsToggle extends SoundButtonEx
   {
      
      private static const IN:String = "in";
      
      private static const OUT:String = "out";
       
      
      public var arrow:MovieClip = null;
      
      public function EventParamsToggle()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         preventAutosizing = true;
      }
      
      override protected function onDispose() : void
      {
         this.arrow = null;
         super.onDispose();
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         var _loc2_:String = !!param1 ? IN : OUT;
         if(this.arrow.currentLabel != _loc2_)
         {
            this.arrow.gotoAndPlay(_loc2_);
         }
      }
   }
}
