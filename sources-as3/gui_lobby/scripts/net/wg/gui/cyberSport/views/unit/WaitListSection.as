package net.wg.gui.cyberSport.views.unit
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.cyberSport.data.CandidatesDataProvider;
   import net.wg.gui.rally.views.room.BaseWaitListSection;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class WaitListSection extends BaseWaitListSection
   {
      
      private static const COMMANDER_STATE:Object = {
         "height":310,
         "paddingTop":0
      };
      
      private static const CANDIDATE_STATE:Object = {
         "height":400,
         "paddingTop":0
      };
      
      private static const BTN_INVITE_FRIEND_PADDING_TEXT:Number = 14;
       
      
      public var btnCloseRoom:BlackButton = null;
      
      public var invisibleTF:TextField = null;
      
      public var visibleTF:TextField = null;
      
      public function WaitListSection()
      {
         super();
      }
      
      override protected function initializeDP() : void
      {
         candidatesDP = new CandidatesDataProvider();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         btnInviteFriend.paddingHorizontal = BTN_INVITE_FRIEND_PADDING_TEXT;
         this.visibleTF.text = CYBERSPORT.WINDOW_UNIT_CLOSEROOM;
         this.invisibleTF.text = CYBERSPORT.WINDOW_UNIT_OPENROOM;
         this.visibleTF.visible = false;
         this.invisibleTF.visible = false;
         lblCandidatesHeader.text = CYBERSPORT.WINDOW_UNIT_CANDIDATES;
         btnInviteFriend.label = CYBERSPORT.WINDOW_UNIT_INVITEFRIEND;
         this.btnCloseRoom.addEventListener(ButtonEvent.CLICK,this.onChangeStateClick);
         this.btnCloseRoom.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.btnCloseRoom.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
         this.btnCloseRoom.toggleEnable = true;
      }
      
      override protected function updateControls() : void
      {
         var _loc1_:Boolean = _rallyData.statusValue;
         this.visibleTF.visible = _loc1_;
         this.invisibleTF.visible = !_loc1_;
         this.btnCloseRoom.selected = _loc1_;
         this.btnCloseRoom.iconSource = !!_loc1_ ? RES_ICONS.MAPS_ICONS_BUTTONS_ICON_CHANNELS_SHOW_SYMBOLS_097 : RES_ICONS.MAPS_ICONS_BUTTONS_ICON_CHANNELS_HIDE_SYMBOLS;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Padding = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this.isCloseRoomButtonVisible();
            if(!_loc1_)
            {
               this.btnCloseRoom.visible = this.invisibleTF.visible = this.visibleTF.visible = false;
            }
            else
            {
               this.btnCloseRoom.visible = true;
               if(_rallyData)
               {
                  _loc2_ = _rallyData.statusValue;
                  this.invisibleTF.visible = !_loc2_;
                  this.visibleTF.visible = _loc2_;
               }
            }
            if(_rallyData)
            {
               _loc3_ = candidates.padding;
               if(_loc1_)
               {
                  _loc3_.top = COMMANDER_STATE.paddingTop;
                  candidates.height = COMMANDER_STATE.height;
               }
               else
               {
                  _loc3_.top = CANDIDATE_STATE.paddingTop;
                  candidates.height = CANDIDATE_STATE.height;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.btnCloseRoom.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.btnCloseRoom.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
         this.btnCloseRoom.removeEventListener(ButtonEvent.CLICK,this.onChangeStateClick);
         super.onDispose();
      }
      
      public function enableCloseButton(param1:Boolean) : void
      {
         if(this.btnCloseRoom)
         {
            this.btnCloseRoom.enabled = param1;
         }
      }
      
      protected function isCloseRoomButtonVisible() : Boolean
      {
         return Boolean(_rallyData) ? Boolean(_rallyData.isCommander) : Boolean(false);
      }
      
      private function showTooltip(param1:String, param2:String) : void
      {
         var _loc3_:String = App.toolTipMgr.getNewFormatter().addHeader(param1,true).addBody(param2,true).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }
      
      override protected function onControlRollOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         super.onControlRollOver(param1);
         switch(param1.target)
         {
            case btnInviteFriend:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_INVITEBTN);
               break;
            case this.btnCloseRoom:
               _loc2_ = TOOLTIPS.CYBERSPORT_UNIT_ACCESS_HEADER;
               _loc3_ = _rallyData && !_rallyData.statusValue ? TOOLTIPS.CYBERSPORT_UNIT_ACCESS_BODYCLOSED : TOOLTIPS.CYBERSPORT_UNIT_ACCESS_BODYOPEN;
               this.showTooltip(_loc2_,_loc3_);
         }
      }
      
      private function onChangeStateClick(param1:ButtonEvent) : void
      {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.TOGGLE_STATUS_REQUEST));
      }
   }
}
