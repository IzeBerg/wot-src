package net.wg.gui.lobby.clans.search.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanSearchInfoInitDataVO extends DAAPIDataClass
   {
       
      
      public var ratingDescription:String = "";
      
      public var ratingTooltip:String = "";
      
      public var requestSent:String = "";
      
      public var clanProfileBtnLabel:String = "";
      
      public var sendRequestBtnLabel:String = "";
      
      public function ClanSearchInfoInitDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
