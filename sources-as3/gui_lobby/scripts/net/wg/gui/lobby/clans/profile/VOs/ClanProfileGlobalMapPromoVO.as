package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanProfileGlobalMapPromoVO extends DAAPIDataClass
   {
       
      
      public var header:String = "";
      
      public var description:String = "";
      
      public var infoLinkLabel:String = "";
      
      public var mapLinkLabel:String = "";
      
      public var background:String = "";
      
      public function ClanProfileGlobalMapPromoVO(param1:Object)
      {
         super(param1);
      }
   }
}
