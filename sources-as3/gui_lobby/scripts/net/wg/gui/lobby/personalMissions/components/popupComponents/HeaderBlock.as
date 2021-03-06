package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HeaderBlock extends MovieClip implements IDisposable
   {
       
      
      public var headerTf:TextField;
      
      private var _disposed:Boolean = false;
      
      public function HeaderBlock()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.headerTf = null;
      }
      
      public function setText(param1:String) : void
      {
         this.headerTf.text = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
