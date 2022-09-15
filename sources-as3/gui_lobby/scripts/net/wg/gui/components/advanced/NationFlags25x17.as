package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.interfaces.IUILoaderBased;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NationFlags25x17 extends MovieClip implements IUILoaderBased, IDisposable
   {
       
      
      public var loader:UILoaderAlt = null;
      
      private var _isDisposed:Boolean = false;
      
      public function NationFlags25x17()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._isDisposed = true;
         this.loader.dispose();
         this.loader = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function setSource(param1:String) : void
      {
         this.loader.source = RES_ICONS.getNationFlag25x17(param1);
      }
   }
}
