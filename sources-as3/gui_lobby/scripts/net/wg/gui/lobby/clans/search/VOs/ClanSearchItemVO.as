package net.wg.gui.lobby.clans.search.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.clans.common.ClanVO;
   
   public class ClanSearchItemVO extends DAAPIDataClass
   {
      
      public static const CLAN_INFO:String = "clanInfo";
       
      
      public var players:String = "";
      
      public var creationDate:String = "";
      
      public var rating:String = "";
      
      public var arrowIcon:String = "";
      
      private var _clanInfo:ClanVO = null;
      
      public function ClanSearchItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(CLAN_INFO == param1)
         {
            this._clanInfo = new ClanVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._clanInfo.dispose();
         this._clanInfo = null;
         super.onDispose();
      }
      
      public function get clanInfo() : ClanVO
      {
         return this._clanInfo;
      }
   }
}
