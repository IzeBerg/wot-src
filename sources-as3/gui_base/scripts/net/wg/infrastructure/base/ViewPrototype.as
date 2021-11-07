package net.wg.infrastructure.base
{
   import flash.display.MovieClip;
   import net.wg.gui.data.ViewModel;
   
   public class ViewPrototype extends MovieClip
   {
       
      
      public var viewModel:ViewModel = null;
      
      public function ViewPrototype()
      {
         super();
         this.initialize();
      }
      
      public function as_destroy() : void
      {
         this.viewModel = null;
      }
      
      protected function initialize() : void
      {
      }
   }
}
