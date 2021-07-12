package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   
   public class BCIntroFadeOutMeta extends AbstractView
   {
       
      
      public var finished:Function;
      
      public function BCIntroFadeOutMeta()
      {
         super();
      }
      
      public function finishedS() : void
      {
         App.utils.asserter.assertNotNull(this.finished,"finished" + Errors.CANT_NULL);
         this.finished();
      }
   }
}
