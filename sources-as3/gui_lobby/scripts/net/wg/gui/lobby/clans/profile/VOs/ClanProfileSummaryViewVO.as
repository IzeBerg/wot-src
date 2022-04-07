package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanProfileSummaryViewVO extends DAAPIDataClass
   {
       
      
      public var totalRating:String = "";
      
      public var clanDescription:String = "";
      
      public var isShowFortBtn:Boolean = false;
      
      public var isShowClanNavBtn:Boolean = false;
      
      public var isShowUrlString:Boolean = false;
      
      public var isDetailLinkEnabled:Boolean = false;
      
      public var totalRatingTooltip:String = "";
      
      public function ClanProfileSummaryViewVO(param1:Object)
      {
         super(param1);
      }
   }
}
