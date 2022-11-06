package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   
   public class BCHighlightsMeta extends AbstractView
   {
       
      
      public var onComponentTriggered:Function;
      
      public var onHighlightAnimationComplete:Function;
      
      public function BCHighlightsMeta()
      {
         super();
      }
      
      public function onComponentTriggeredS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onComponentTriggered,"onComponentTriggered" + Errors.CANT_NULL);
         this.onComponentTriggered(param1);
      }
      
      public function onHighlightAnimationCompleteS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onHighlightAnimationComplete,"onHighlightAnimationComplete" + Errors.CANT_NULL);
         this.onHighlightAnimationComplete(param1);
      }
   }
}
