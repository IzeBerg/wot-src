package net.wg.gui.lobby.linkedSet.components
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.containers.AnimatedLoaderTextContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimatedLoaderContainer extends MovieClip implements IDisposable
   {
       
      
      public var content:AnimatedLoaderTextContainer = null;
      
      public function AnimatedLoaderContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.content.dispose();
         this.content = null;
      }
      
      public function set source(param1:String) : void
      {
         this.content.source = param1;
      }
   }
}
