package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DialogSettingsVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var submitBtnLabel:String = "";
      
      public var cancelBtnLabel:String = "";
      
      public function DialogSettingsVO(param1:Object)
      {
         super(param1);
      }
   }
}
