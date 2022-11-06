package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NationButtonStates extends MovieClip implements IDisposable
   {
       
      
      public var ico:UILoaderAlt;
      
      public var icoAdd:UILoaderAlt;
      
      private var _disposed:Boolean = false;
      
      public function NationButtonStates()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this.ico != null)
         {
            this.ico.dispose();
            this.ico = null;
         }
         if(this.ico != null)
         {
            this.icoAdd.dispose();
            this.icoAdd = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setIconState(param1:String) : void
      {
         var _loc2_:String = RES_ICONS.getNationFlag60x40(param1);
         if(this.ico != null)
         {
            this.ico.source = _loc2_;
         }
         if(this.icoAdd != null)
         {
            this.icoAdd.source = _loc2_;
         }
      }
      
      public function get contentSize() : Rectangle
      {
         return scale9Grid;
      }
   }
}
