package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NationButtonStates extends MovieClip implements IDisposable
   {
       
      
      public var ico:MovieClip;
      
      public var icoAdd:MovieClip;
      
      private var _disposed:Boolean = false;
      
      public function NationButtonStates()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.ico = null;
         this.icoAdd = null;
      }
      
      public function setIconState(param1:String) : void
      {
         if(this.ico != null)
         {
            this.ico.gotoAndStop(param1);
         }
         if(this.icoAdd != null)
         {
            this.icoAdd.gotoAndStop(param1);
         }
      }
      
      public function get contentSize() : Rectangle
      {
         return scale9Grid;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
