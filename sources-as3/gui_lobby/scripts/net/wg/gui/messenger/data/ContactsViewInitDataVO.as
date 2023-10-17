package net.wg.gui.messenger.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ContactsViewInitDataVO extends DAAPIDataClass
   {
       
      
      public var btOkLbl:String = "";
      
      public var mainLbl:String = "";
      
      public var btnCancelLbl:String = "";
      
      public var btOkTooltip:String = "";
      
      public var btnCancelTooltip:String = "";
      
      public function ContactsViewInitDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
