package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FreeSheetTitle extends MovieClip implements IDisposable
   {
       
      
      public var titleTf:TextField;
      
      private var _disposed:Boolean = false;
      
      public function FreeSheetTitle()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.titleTf = null;
      }
      
      public function setTitle(param1:String) : void
      {
         this.titleTf.text = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
