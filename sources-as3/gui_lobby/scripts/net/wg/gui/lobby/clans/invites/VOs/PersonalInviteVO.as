package net.wg.gui.lobby.clans.invites.VOs
{
   import net.wg.gui.lobby.clans.common.ClanVO;
   
   public class PersonalInviteVO extends ClanInvitesWindowAbstractItemVO
   {
      
      private static const ACTIONS:String = "actions";
      
      private static const CLAN_VO:String = "clanVO";
       
      
      public var checked:Boolean = false;
      
      public var enabled:Boolean = false;
      
      private var _clanVO:ClanVO = null;
      
      private var _actions:AcceptActionsVO = null;
      
      public function PersonalInviteVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._actions.dispose();
         this._actions = null;
         this._clanVO.dispose();
         this._clanVO = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(ACTIONS == param1)
         {
            this._actions = new AcceptActionsVO(param2);
            return false;
         }
         if(CLAN_VO == param1)
         {
            this._clanVO = new ClanVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get actions() : AcceptActionsVO
      {
         return this._actions;
      }
      
      public function get clanVO() : ClanVO
      {
         return this._clanVO;
      }
   }
}
