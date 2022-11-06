package net.wg.gui.rally.views.room
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.ExtendedUserVO;
   import net.wg.data.VoDAAPIDataProvider;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.rally.controls.CandidatesScrollingList;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class BaseWaitListSection extends UIComponentEx
   {
       
      
      public var lblCandidatesHeader:TextField = null;
      
      public var btnInviteFriend:SoundButtonEx = null;
      
      public var candidates:CandidatesScrollingList = null;
      
      protected var candidatesDP:VoDAAPIDataProvider = null;
      
      protected var _rallyData:IRallyVO = null;
      
      public function BaseWaitListSection()
      {
         super();
         this.initializeDP();
      }
      
      protected function initializeDP() : void
      {
      }
      
      protected function updateControls() : void
      {
      }
      
      protected function onControlRollOver(param1:MouseEvent) : void
      {
      }
      
      public function updateRallyStatus(param1:Boolean, param2:String) : void
      {
         this._rallyData.statusLbl = param2;
         this._rallyData.statusValue = param1;
         this.updateControls();
      }
      
      public function get rallyData() : IRallyVO
      {
         return this._rallyData;
      }
      
      public function set rallyData(param1:IRallyVO) : void
      {
         this._rallyData = param1;
         invalidateData();
      }
      
      public function getCandidatesDP() : VoDAAPIDataProvider
      {
         return this.candidatesDP;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.candidates)
         {
            this.candidates.dataProvider = this.candidatesDP;
            this.candidates.addEventListener(ListEventEx.ITEM_CLICK,this.onListItemClick);
            this.candidates.addEventListener(ListEventEx.ITEM_RIGHT_CLICK,this.onListItemClick);
         }
         if(this.btnInviteFriend)
         {
            this.btnInviteFriend.addEventListener(ButtonEvent.CLICK,this.onInviteFriendClickHandler);
            this.btnInviteFriend.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.btnInviteFriend.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = Boolean(this._rallyData) ? Boolean(this._rallyData.isCommander) : Boolean(false);
            _loc2_ = Boolean(this._rallyData) ? Boolean(this._rallyData.canInvite) : Boolean(false);
            this.btnInviteFriend.visible = _loc1_ || _loc2_;
            if(_loc1_)
            {
               this.updateControls();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.lblCandidatesHeader = null;
         if(this.btnInviteFriend)
         {
            this.btnInviteFriend.removeEventListener(ButtonEvent.CLICK,this.onInviteFriendClickHandler);
            this.btnInviteFriend.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.btnInviteFriend.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.btnInviteFriend.dispose();
            this.btnInviteFriend = null;
         }
         if(this.candidates)
         {
            this.candidates.removeEventListener(ListEventEx.ITEM_CLICK,this.onListItemClick);
            this.candidates.removeEventListener(ListEventEx.ITEM_RIGHT_CLICK,this.onListItemClick);
            this.candidates.dispose();
            this.candidates = null;
         }
         if(this._rallyData)
         {
            this._rallyData.dispose();
            this._rallyData = null;
         }
         this.candidatesDP = null;
         App.contextMenuMgr.hide();
         super.onDispose();
      }
      
      protected function onInviteFriendClick() : void
      {
      }
      
      private function onInviteFriendClickHandler(param1:ButtonEvent) : void
      {
         this.onInviteFriendClick();
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.INVITE_FRIEND_REQUEST));
      }
      
      protected function onListItemClick(param1:ListEventEx) : void
      {
         var _loc2_:ExtendedUserVO = param1.itemData as ExtendedUserVO;
         if(_loc2_ && param1.buttonIdx == MouseEventEx.RIGHT_BUTTON && !UserTags.isCurrentPlayer(_loc2_.tags))
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.UNIT_USER,this,_loc2_);
         }
      }
      
      protected function onControlRollOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
