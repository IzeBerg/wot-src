package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
   import net.wg.gui.rally.AbstractRallyView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class BasePrebattleRoomViewMeta extends AbstractRallyView
   {
       
      
      public var requestToReady:Function;
      
      public var requestToLeave:Function;
      
      public var showPrebattleSendInvitesWindow:Function;
      
      public var canSendInvite:Function;
      
      public var canKickPlayer:Function;
      
      public var isPlayerReady:Function;
      
      public var isPlayerCreator:Function;
      
      public var isReadyBtnEnabled:Function;
      
      public var isLeaveBtnEnabled:Function;
      
      public var getClientID:Function;
      
      public function BasePrebattleRoomViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
      
      public function requestToReadyS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.requestToReady,"requestToReady" + Errors.CANT_NULL);
         this.requestToReady(param1);
      }
      
      public function requestToLeaveS() : void
      {
         App.utils.asserter.assertNotNull(this.requestToLeave,"requestToLeave" + Errors.CANT_NULL);
         this.requestToLeave();
      }
      
      public function showPrebattleSendInvitesWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.showPrebattleSendInvitesWindow,"showPrebattleSendInvitesWindow" + Errors.CANT_NULL);
         this.showPrebattleSendInvitesWindow();
      }
      
      public function canSendInviteS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.canSendInvite,"canSendInvite" + Errors.CANT_NULL);
         return this.canSendInvite();
      }
      
      public function canKickPlayerS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.canKickPlayer,"canKickPlayer" + Errors.CANT_NULL);
         return this.canKickPlayer();
      }
      
      public function isPlayerReadyS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isPlayerReady,"isPlayerReady" + Errors.CANT_NULL);
         return this.isPlayerReady();
      }
      
      public function isPlayerCreatorS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isPlayerCreator,"isPlayerCreator" + Errors.CANT_NULL);
         return this.isPlayerCreator();
      }
      
      public function isReadyBtnEnabledS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isReadyBtnEnabled,"isReadyBtnEnabled" + Errors.CANT_NULL);
         return this.isReadyBtnEnabled();
      }
      
      public function isLeaveBtnEnabledS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isLeaveBtnEnabled,"isLeaveBtnEnabled" + Errors.CANT_NULL);
         return this.isLeaveBtnEnabled();
      }
      
      public function getClientIDS() : Number
      {
         App.utils.asserter.assertNotNull(this.getClientID,"getClientID" + Errors.CANT_NULL);
         return this.getClientID();
      }
      
      public final function as_setRosterList(param1:int, param2:Boolean, param3:Array) : void
      {
         var _loc4_:DataProvider = new DataProvider();
         var _loc5_:uint = param3.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_[_loc6_] = new PlayerPrbInfoVO(param3[_loc6_]);
            _loc6_++;
         }
         this.setRosterList(param1,param2,_loc4_);
      }
      
      protected function setRosterList(param1:int, param2:Boolean, param3:DataProvider) : void
      {
         var _loc4_:String = "as_setRosterList" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
   }
}
