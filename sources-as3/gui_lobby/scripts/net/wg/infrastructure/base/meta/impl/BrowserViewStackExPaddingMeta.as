package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class BrowserViewStackExPaddingMeta extends BaseDAAPIComponent
   {
       
      
      public var setViewSize:Function;
      
      public function BrowserViewStackExPaddingMeta()
      {
         super();
      }
      
      public function setViewSizeS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.setViewSize,"setViewSize" + Errors.CANT_NULL);
         this.setViewSize(param1,param2);
      }
   }
}
