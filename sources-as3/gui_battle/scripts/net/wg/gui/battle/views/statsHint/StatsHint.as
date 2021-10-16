package net.wg.gui.battle.views.statsHint
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StatsHint extends Sprite implements IDisposable
   {
       
      
      public var label:TextField = null;
      
      public function StatsHint()
      {
         super();
         this.label.text = INGAME_GUI.TABSTATSHINT;
      }
      
      public function dispose() : void
      {
         this.label = null;
      }
   }
}
