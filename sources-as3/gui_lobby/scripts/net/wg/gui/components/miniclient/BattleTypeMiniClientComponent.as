package net.wg.gui.components.miniclient
{
   import flash.display.MovieClip;
   
   public class BattleTypeMiniClientComponent extends LinkedMiniClientComponent
   {
       
      
      public var background:MovieClip = null;
      
      public function BattleTypeMiniClientComponent()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.background = null;
         super.onDispose();
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this.background.height = height;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this.background.width = width;
      }
   }
}
