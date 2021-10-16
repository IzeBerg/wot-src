package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class AbstractViewMeta extends BaseDAAPIComponent
   {
       
      
      public var onFocusIn:Function;
      
      public function AbstractViewMeta()
      {
         super();
      }
      
      public function onFocusInS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onFocusIn,"onFocusIn" + Errors.CANT_NULL);
         this.onFocusIn(param1);
      }
   }
}
