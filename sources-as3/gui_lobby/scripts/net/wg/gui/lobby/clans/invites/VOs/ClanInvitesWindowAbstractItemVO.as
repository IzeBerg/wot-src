package net.wg.gui.lobby.clans.invites.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanInvitesWindowAbstractItemVO extends DAAPIDataClass
   {
      
      private static const STATUS:String = "status";
       
      
      public var personalRating:String = "";
      
      public var battlesCount:String = "";
      
      public var wins:String = "";
      
      public var awgExp:String = "";
      
      public var messageTooltip:String = "";
      
      public var canShowContextMenu:Boolean = false;
      
      public var hasShowMoreButton:Boolean = false;
      
      public var showMoreButtonEnabled:Boolean = false;
      
      public var dbID:Number = NaN;
      
      private var _status:ClanRequestStatusVO = null;
      
      public function ClanInvitesWindowAbstractItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(STATUS == param1)
         {
            this._status = new ClanRequestStatusVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._status.dispose();
         this._status = null;
         super.onDispose();
      }
      
      public function get status() : ClanRequestStatusVO
      {
         return this._status;
      }
   }
}
