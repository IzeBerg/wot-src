package net.wg.gui.battle.views.prebattleTimer
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PrebattleTimerBg extends Sprite implements IDisposable
   {
       
      
      public var shadow:Sprite = null;
      
      public function PrebattleTimerBg()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.shadow = null;
      }
      
      public function updateSize(param1:int, param2:int) : void
      {
         this.shadow.x = -param1 >> 1;
         this.shadow.width = param1;
         this.shadow.height = param2;
      }
   }
}
