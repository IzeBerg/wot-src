package net.wg.gui.bootcamp.introVideoPage.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LoadingContainer extends MovieClip implements IDisposable
   {
       
      
      public var gradientBg:MovieClip;
      
      public function LoadingContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.gradientBg = null;
      }
      
      public function setWidth(param1:int) : void
      {
         this.gradientBg.width = param1;
         this.gradientBg.x = -param1 >> 1;
      }
   }
}
