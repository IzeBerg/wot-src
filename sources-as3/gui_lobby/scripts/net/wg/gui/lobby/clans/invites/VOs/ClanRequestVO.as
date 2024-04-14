package net.wg.gui.lobby.clans.invites.VOs
{
   public class ClanRequestVO extends UserInvitesWindowItemVO
   {
      
      private static const ACTIONS:String = "actions";
       
      
      private var _actions:ClanRequestActionsVO = null;
      
      public function ClanRequestVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._actions.dispose();
         this._actions = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(ACTIONS == param1)
         {
            this._actions = new ClanRequestActionsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get actions() : ClanRequestActionsVO
      {
         return this._actions;
      }
   }
}
