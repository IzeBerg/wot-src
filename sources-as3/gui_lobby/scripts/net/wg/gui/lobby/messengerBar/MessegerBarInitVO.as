package net.wg.gui.lobby.messengerBar
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MessegerBarInitVO extends DAAPIDataClass
   {
       
      
      public var channelsHtmlIcon:String = "";
      
      public var contactsHtmlIcon:String = "";
      
      public var contactsTooltip:String = "";
      
      public var vehicleCompareHtmlIcon:String = "";
      
      public var vehicleCompareTooltip:String = "";
      
      public var referralHtmlIcon:String = "";
      
      public var referralTooltip:String = "";
      
      public var sessionStatsHtmlIcon:String = "";
      
      public var referralCounter:int = 0;
      
      public var isReferralEnabled:Boolean = false;
      
      public var isReferralFirstIndication:Boolean = false;
      
      public function MessegerBarInitVO(param1:Object)
      {
         super(param1);
      }
   }
}
