package net.wg.infrastructure.base
{
   import flash.display.MovieClip;
   import net.wg.gui.data.ViewModel;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ComponentWithModel extends MovieClip implements IDisposable
   {
       
      
      private var _viewModel:ViewModel = null;
      
      private var _disposed:Boolean = false;
      
      public function ComponentWithModel()
      {
         super();
         this.initialize();
      }
      
      public function as_destroy() : void
      {
         this._viewModel = null;
         this.dispose();
      }
      
      protected function initialize() : void
      {
      }
      
      public function dispose() : void
      {
         this._disposed = true;
      }
      
      public function get viewModel() : ViewModel
      {
         return this._viewModel;
      }
      
      protected function layout() : void
      {
      }
      
      public function set viewModel(param1:ViewModel) : void
      {
         this._viewModel = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
