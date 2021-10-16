package net.wg.gui.bootcamp.battleTopHint.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintBackground extends MovieClip implements IDisposable
   {
       
      
      public var bg:MovieClip = null;
      
      public function HintBackground()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.bg = null;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.bg.width = param1;
      }
   }
}
