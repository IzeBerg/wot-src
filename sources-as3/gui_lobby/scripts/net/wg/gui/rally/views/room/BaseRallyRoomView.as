package net.wg.gui.rally.views.room
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.gui.rally.controls.RallyInvalidationType;
   import net.wg.gui.rally.data.TooltipDataVO;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.helpers.RallyDragDropListDelegateController;
   import net.wg.gui.rally.interfaces.IBaseChatSection;
   import net.wg.gui.rally.interfaces.IBaseTeamSection;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.gui.rally.vo.ActionButtonVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.meta.IBaseRallyRoomViewMeta;
   import net.wg.infrastructure.base.meta.impl.BaseRallyRoomViewMeta;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BaseRallyRoomView extends BaseRallyRoomViewMeta implements IBaseRallyRoomViewMeta, IChannelComponentHolder
   {
       
      
      public var teamSection:IBaseTeamSection;
      
      public var chatSection:IBaseChatSection;
      
      private var _actionButtonData:ActionButtonVO;
      
      private var _rallyData:IRallyVO;
      
      public function BaseRallyRoomView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(RallyViewsEvent.ASSIGN_SLOT_REQUEST,this.onAssignPlaceRequest);
         addEventListener(RallyViewsEvent.LEAVE_SLOT_REQUEST,this.onRemoveRequest);
         addEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleRequest);
         addEventListener(RallyViewsEvent.INVITE_FRIEND_REQUEST,this.onInviteFriendRequest);
         addEventListener(RallyViewsEvent.TOGGLE_READY_STATE_REQUEST,this.onToggleReadyStateRequest);
         addEventListener(RallyViewsEvent.IGNORE_USER_REQUEST,this.onIgnoreUserRequest);
         addEventListener(RallyViewsEvent.EDIT_RALLY_DESCRIPTION,this.onEditRallyDescription);
         addEventListener(RallyViewsEvent.SHOW_FAQ_WINDOW,this.onShowFAQWindowRequest);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(RallyInvalidationType.RALLY_DATA) && this.rallyData)
         {
            this.chatSection.rallyData = this.rallyData;
            this.updateTitle();
         }
         if(isInvalid(RallyInvalidationType.UPDATE_COMMENTS) && this.rallyData)
         {
            this.chatSection.setDescription(this.rallyData.description);
         }
         if(isInvalid(RallyInvalidationType.ACTION_BUTTON_DATA))
         {
            this.teamSection.actionButtonData = this._actionButtonData;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(RallyViewsEvent.ASSIGN_SLOT_REQUEST,this.onAssignPlaceRequest);
         removeEventListener(RallyViewsEvent.LEAVE_SLOT_REQUEST,this.onRemoveRequest);
         removeEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleRequest);
         removeEventListener(RallyViewsEvent.INVITE_FRIEND_REQUEST,this.onInviteFriendRequest);
         removeEventListener(RallyViewsEvent.TOGGLE_READY_STATE_REQUEST,this.onToggleReadyStateRequest);
         removeEventListener(RallyViewsEvent.IGNORE_USER_REQUEST,this.onIgnoreUserRequest);
         removeEventListener(RallyViewsEvent.EDIT_RALLY_DESCRIPTION,this.onEditRallyDescription);
         removeEventListener(RallyViewsEvent.SHOW_FAQ_WINDOW,this.onShowFAQWindowRequest);
         if(this.teamSection)
         {
            this.teamSection.dispose();
            this.teamSection = null;
         }
         if(this.chatSection)
         {
            this.chatSection.dispose();
            this.chatSection = null;
         }
         this._actionButtonData = null;
         this._rallyData = null;
         super.onDispose();
      }
      
      public function as_getCandidatesDP() : Object
      {
         return null;
      }
      
      override protected function highlightSlots(param1:Array) : void
      {
         this.teamSection.highlightSlots(param1);
      }
      
      override protected function setActionButtonState(param1:ActionButtonVO) : void
      {
         if(param1)
         {
            this._actionButtonData = param1;
            invalidate(RallyInvalidationType.ACTION_BUTTON_DATA);
         }
      }
      
      public function as_setComment(param1:String) : void
      {
         if(this.rallyData)
         {
            this.rallyData.description = param1;
            invalidate(RallyInvalidationType.UPDATE_COMMENTS);
         }
      }
      
      public function as_setMemberOffline(param1:uint, param2:Boolean) : void
      {
         if(this.rallyData)
         {
            this.teamSection.setOfflineStatus(param1,param2);
         }
      }
      
      public function as_setMemberStatus(param1:uint, param2:uint) : void
      {
         if(this.rallyData)
         {
            this.teamSection.setMemberStatus(param1,param2);
         }
      }
      
      override protected function setMemberVehicle(param1:uint, param2:uint, param3:VehicleVO) : void
      {
         if(this.rallyData)
         {
            this.teamSection.setMemberVehicle(param1,param2,param3);
         }
      }
      
      override protected function setMembers(param1:Boolean, param2:Array) : void
      {
         if(this.rallyData)
         {
            this.teamSection.updateMembers(param1,param2);
         }
      }
      
      override protected function setVehiclesTitle(param1:String, param2:TooltipDataVO) : void
      {
         this.teamSection.setVehiclesInfoTooltipId(param2.id,param2.header,param2.body);
         this.teamSection.vehiclesLabel = param1;
      }
      
      override protected function updateRally(param1:IRallyVO) : void
      {
         if(param1)
         {
            this.rallyData = param1;
            this.teamSection.rallyData = this.rallyData;
            invalidate(RallyInvalidationType.RALLY_DATA);
         }
      }
      
      public function getChannelComponent() : ChannelComponent
      {
         return this.chatSection.getChannelComponent();
      }
      
      protected function updateTitle() : void
      {
         if(!titleLbl)
         {
            return;
         }
         titleLbl.text = App.utils.locale.makeString(this.getTitleStr(),{"commanderName":App.utils.commons.getFullPlayerName(App.utils.commons.getUserProps(this.rallyData.commanderExtendedUserVO.userName,this.rallyData.commanderExtendedUserVO.clanAbbrev,this.rallyData.commanderExtendedUserVO.region))});
      }
      
      protected function getDragDropDeligateController(param1:Array) : IDisposable
      {
         var _loc2_:Class = App.utils.classFactory.getClass(Linkages.RALLY_DRAG_DROP_DELEGATE);
         return new RallyDragDropListDelegateController(Vector.<InteractiveObject>(param1),_loc2_,Linkages.CANDIDATE_LIST_ITEM_RENDERER_UI,onSlotsHighlihgtingNeedS,assignSlotRequestS,leaveSlotRequestS);
      }
      
      protected function getTitleStr() : String
      {
         return null;
      }
      
      public function get rallyData() : IRallyVO
      {
         return this._rallyData;
      }
      
      public function set rallyData(param1:IRallyVO) : void
      {
         this._rallyData = param1;
      }
      
      protected function onAssignPlaceRequest(param1:RallyViewsEvent) : void
      {
         assignSlotRequestS(param1.data,-1);
      }
      
      protected function onRemoveRequest(param1:RallyViewsEvent) : void
      {
         leaveSlotRequestS(param1.data);
      }
      
      protected function onChooseVehicleRequest(param1:RallyViewsEvent) : void
      {
         chooseVehicleRequestS();
      }
      
      protected function onInviteFriendRequest(param1:RallyViewsEvent) : void
      {
         inviteFriendRequestS();
      }
      
      protected function onToggleReadyStateRequest(param1:RallyViewsEvent) : void
      {
         toggleReadyStateRequestS();
      }
      
      protected function onIgnoreUserRequest(param1:RallyViewsEvent) : void
      {
         ignoreUserRequestS(param1.data);
      }
      
      protected function onEditRallyDescription(param1:RallyViewsEvent) : void
      {
         editDescriptionRequestS(param1.data);
      }
      
      protected function onShowFAQWindowRequest(param1:RallyViewsEvent) : void
      {
         showFAQWindowS();
      }
   }
}
