package net.wg.gui.lobby.clans.search.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanSearchInfoStateDataVO extends DAAPIDataClass
   {
       
      
      public var requestSentVisible:Boolean = false;
      
      public var sendRequestBtnVisible:Boolean = false;
      
      public var sendRequestBtnEnabled:Boolean = false;
      
      public var alertIconVisible:Boolean = false;
      
      public var sendRequestTooltip:String = "";
      
      public function ClanSearchInfoStateDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
