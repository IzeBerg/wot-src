package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWrapperView;
   
   public class WindowViewMeta extends AbstractWrapperView
   {
       
      
      public var onWindowMinimize:Function;
      
      public var onSourceLoaded:Function;
      
      public var onTryClosing:Function;
      
      public function WindowViewMeta()
      {
         super();
      }
      
      public function onWindowMinimizeS() : void
      {
         App.utils.asserter.assertNotNull(this.onWindowMinimize,"onWindowMinimize" + Errors.CANT_NULL);
         this.onWindowMinimize();
      }
      
      public function onSourceLoadedS() : void
      {
         App.utils.asserter.assertNotNull(this.onSourceLoaded,"onSourceLoaded" + Errors.CANT_NULL);
         this.onSourceLoaded();
      }
      
      public function onTryClosingS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.onTryClosing,"onTryClosing" + Errors.CANT_NULL);
         return this.onTryClosing();
      }
   }
}
