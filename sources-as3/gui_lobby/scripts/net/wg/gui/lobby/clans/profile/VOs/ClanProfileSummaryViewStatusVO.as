package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanProfileSummaryViewStatusVO extends DAAPIDataClass
   {
       
      
      public var isShowRequestBtn:Boolean = false;
      
      public var mainStatus:String = "";
      
      public var additionalStatus:String = "";
      
      public var isEnabledRequestBtn:Boolean = false;
      
      public var isShowPersonnelBtn:Boolean = false;
      
      public var tooltip:String = "";
      
      public function ClanProfileSummaryViewStatusVO(param1:Object)
      {
         super(param1);
      }
   }
}
