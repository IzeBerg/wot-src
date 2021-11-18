package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FreeSheetTitle extends MovieClip implements IDisposable
   {
       
      
      public var titleTf:TextField;
      
      public function FreeSheetTitle()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.titleTf = null;
      }
      
      public function setTitle(param1:String) : void
      {
         this.titleTf.text = param1;
      }
   }
}
