package net.wg.gui.lobby.clans.invites.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanRequestStatusVO extends DAAPIDataClass
   {
       
      
      public var text:String = "";
      
      public var tooltip:String = "";
      
      public var date:String = "";
      
      public var user:String = "";
      
      public function ClanRequestStatusVO(param1:Object)
      {
         super(param1);
      }
   }
}
