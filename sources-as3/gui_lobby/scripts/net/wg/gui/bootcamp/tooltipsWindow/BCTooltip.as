package net.wg.gui.bootcamp.tooltipsWindow
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   import net.wg.gui.bootcamp.tooltipsWindow.containers.BCBgContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BCTooltip extends MovieClip implements IDisposable
   {
       
      
      public var textContainer:AnimatedTextContainer = null;
      
      public var bgContainer:BCBgContainer = null;
      
      public function BCTooltip()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this.textContainer.dispose();
         this.textContainer = null;
         this.bgContainer.dispose();
         this.bgContainer = null;
      }
      
      public function setText(param1:String) : void
      {
         this.textContainer.text = param1;
      }
      
      public function updateStage(param1:int) : void
      {
         this.bgContainer.setWidth(param1);
      }
   }
}
