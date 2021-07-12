package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NationFlagContainer extends Sprite implements IDisposable
   {
       
      
      public var nationFlags:MovieClip;
      
      public function NationFlagContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.nationFlags = null;
      }
      
      public function setNation(param1:String) : void
      {
         if(this.nationFlags.currentFrameLabel != param1)
         {
            this.nationFlags.gotoAndStop(param1);
         }
      }
   }
}
