package net.wg.gui.bootcamp.tooltipsWindow.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BCBgContainer extends MovieClip implements IDisposable
   {
       
      
      public var bg:MovieClip = null;
      
      public function BCBgContainer()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.bg = null;
      }
      
      public function setWidth(param1:int) : void
      {
         this.bg.width = param1;
      }
   }
}
