package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class TextManagerMeta extends BaseDAAPIModule
   {
       
      
      public var getTextStyle:Function;
      
      public function TextManagerMeta()
      {
         super();
      }
      
      public function getTextStyleS(param1:String) : String
      {
         App.utils.asserter.assertNotNull(this.getTextStyle,"getTextStyle" + Errors.CANT_NULL);
         return this.getTextStyle(param1);
      }
   }
}
