package net.wg.gui.bootcamp.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TipHintAnimation extends MovieClip implements IDisposable
   {
       
      
      public var container:HintContainer = null;
      
      public function TipHintAnimation()
      {
         super();
      }
      
      public function setLabel(param1:String) : void
      {
         this.container.setLabel(param1);
      }
      
      public final function dispose() : void
      {
         this.container.dispose();
         this.container = null;
      }
   }
}
