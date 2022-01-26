package net.wg.gui.bootcamp.messageWindow.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.controls.LoaderContainer;
   
   public class MessageIconContainer extends MovieClip
   {
       
      
      public var iconContainer:LoaderContainer = null;
      
      public function MessageIconContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.iconContainer.dispose();
         this.iconContainer = null;
      }
      
      public function set source(param1:String) : void
      {
         this.iconContainer.source = param1;
      }
   }
}
