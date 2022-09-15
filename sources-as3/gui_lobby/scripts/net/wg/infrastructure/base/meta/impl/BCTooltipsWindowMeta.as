package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   
   public class BCTooltipsWindowMeta extends AbstractView
   {
       
      
      public var animFinish:Function;
      
      public function BCTooltipsWindowMeta()
      {
         super();
      }
      
      public function animFinishS() : void
      {
         App.utils.asserter.assertNotNull(this.animFinish,"animFinish" + Errors.CANT_NULL);
         this.animFinish();
      }
   }
}
