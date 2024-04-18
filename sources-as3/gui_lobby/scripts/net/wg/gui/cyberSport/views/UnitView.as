package net.wg.gui.cyberSport.views
{
   import fl.transitions.easing.Strong;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.cyberSport.views.unit.TeamSection;
   import net.wg.gui.cyberSport.views.unit.WaitListSection;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.gui.rally.vo.RallyVO;
   import net.wg.infrastructure.base.meta.ICyberSportUnitMeta;
   import net.wg.infrastructure.base.meta.impl.CyberSportUnitMeta;
   import scaleform.clik.motion.Tween;
   
   public class UnitView extends CyberSportUnitMeta implements ICyberSportUnitMeta
   {
      
      private static const ANIMATION_DELAY:uint = 700;
      
      private static const CHANGE_UNIT_STATE:int = 27;
      
      private static const SET_PLAYER_STATE:int = 6;
      
      private static const CLOSE_SLOT:int = 17;
       
      
      public var headerTF:TextField = null;
      
      public var rosterTeamSection:RosterSettingsView;
      
      public var rosterTeamContext:Boolean = false;
      
      private var _tweens:Vector.<Tween>;
      
      private var _isRosterSettingsVisible:Boolean = false;
      
      public function UnitView()
      {
         this._tweens = new Vector.<Tween>();
         super();
      }
      
      override protected function getRallyViewAlias() : String
      {
         return CYBER_SPORT_ALIASES.UNIT_VIEW_UI;
      }
      
      override protected function getIRallyVOForRally(param1:Object) : IRallyVO
      {
         return new RallyVO(param1);
      }
      
      override protected function getTitleStr() : String
      {
         return CYBERSPORT.WINDOW_UNIT_UNITNAME;
      }
      
      override protected function coolDownControls(param1:Boolean, param2:int) : void
      {
         if(param2 == CHANGE_UNIT_STATE)
         {
            WaitListSection(waitingListSection).enableCloseButton(param1);
            this.unitTeamSection.enableFreezeButton(param1);
            IChatSectionWithDescription(chatSection).enableEditCommitButton(param1);
         }
         else if(param2 == SET_PLAYER_STATE)
         {
            teamSection.enableFightButton(param1);
         }
         else if(param2 == CLOSE_SLOT)
         {
            teamSection.cooldownSlots(param1);
         }
         super.coolDownControls(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rosterTeamSection.alpha = 0;
         this.rosterTeamSectionMouseEnabled = false;
         addEventListener(CSComponentEvent.TOGGLE_FREEZE_REQUEST,this.onToggleFreezeRequestHandler);
         addEventListener(CSComponentEvent.TOGGLE_STATUS_REQUEST,this.onToggleStatusRequestHandler);
         addEventListener(CSComponentEvent.LOCK_SLOT_REQUEST,this.onLockSlotRequestHandler);
         addEventListener(CSComponentEvent.CLICK_CONFIGURE_BUTTON,this.onClickConfigureButtonHandler);
         addEventListener(CSComponentEvent.SHOW_SETTINGS_ROSTER_WND,this.onShowSettingsRosterWndHandler);
         addEventListener(CSComponentEvent.APPLY_ROSTER_SETTINGS,this.onApplyRosterSettingsHandler);
         addEventListener(CSComponentEvent.CANCEL_ROSTER_SETTINGS,this.onCancelRosterSettingsHandler);
         titleLbl.text = Values.EMPTY_STR;
         descrLbl.text = CYBERSPORT.WINDOW_UNIT_DESCRIPTION;
         backBtn.label = CYBERSPORT.WINDOW_UNIT_LEAVE;
         this.headerTF.text = CYBERSPORT.UNITVIEW_HEADER;
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.headerTF = null;
         this.cleanTweens();
         removeEventListener(CSComponentEvent.TOGGLE_FREEZE_REQUEST,this.onToggleFreezeRequestHandler);
         removeEventListener(CSComponentEvent.TOGGLE_STATUS_REQUEST,this.onToggleStatusRequestHandler);
         removeEventListener(CSComponentEvent.CLICK_CONFIGURE_BUTTON,this.onClickConfigureButtonHandler);
         removeEventListener(CSComponentEvent.SHOW_SETTINGS_ROSTER_WND,this.onShowSettingsRosterWndHandler);
         removeEventListener(CSComponentEvent.APPLY_ROSTER_SETTINGS,this.onApplyRosterSettingsHandler);
         removeEventListener(CSComponentEvent.CANCEL_ROSTER_SETTINGS,this.onCancelRosterSettingsHandler);
         removeEventListener(CSComponentEvent.LOCK_SLOT_REQUEST,this.onLockSlotRequestHandler);
         this.rosterTeamSection.dispose();
         this.rosterTeamSection = null;
         super.onDispose();
      }
      
      override protected function lockUnit(param1:Boolean, param2:Array) : void
      {
         if(rallyData)
         {
            this.unitTeamSection.updateLockedUnit(param1,param2);
         }
      }
      
      override protected function updateSlotSettings(param1:Array) : void
      {
         this.rosterTeamSection.setSelectedSettings = param1;
      }
      
      public function as_closeSlot(param1:uint, param2:uint, param3:String) : void
      {
         if(rallyData)
         {
            this.unitTeamSection.closeSlot(param1,false,param2,param3,true,-1);
         }
      }
      
      public function as_openSlot(param1:uint, param2:Boolean, param3:String, param4:uint) : void
      {
         if(rallyData)
         {
            this.unitTeamSection.closeSlot(param1,param2,0,param3,false,param4);
         }
      }
      
      public function as_setOpened(param1:Boolean, param2:String) : void
      {
         if(rallyData)
         {
            waitingListSection.updateRallyStatus(param1,param2);
         }
      }
      
      public function as_setPlayerCountLbl(param1:String) : void
      {
         this.unitTeamSection.teamLabel = param1;
      }
      
      public function as_setTotalLabel(param1:Boolean, param2:String, param3:int) : void
      {
         if(rallyData)
         {
            this.unitTeamSection.updateTotalLabel(param1,param2,param3);
         }
      }
      
      public function preInitFadeAnimationCancel() : void
      {
         this.initFadeAnimation();
         cancelRosterSlotsSettingsS();
      }
      
      private function initFadeAnimation() : void
      {
         if(!this._isRosterSettingsVisible)
         {
            this.fadeIn();
         }
         else
         {
            this.fadeOut();
         }
      }
      
      private function fadeIn() : void
      {
         var _loc1_:Array = rallyData.slotsArray;
         if(_loc1_)
         {
            this.rosterTeamSection.setData(_loc1_);
         }
         this.rosterTeamSection.animationIn();
         this.rosterTeamSectionMouseEnabled = true;
         this.playAnimation({"alpha":0});
      }
      
      private function fadeOut() : void
      {
         this.rosterTeamSection.animationOut();
         this.rosterTeamSectionMouseEnabled = false;
         this.playAnimation({"alpha":1});
      }
      
      private function playAnimation(param1:Object) : void
      {
         this.cleanTweens();
         this._tweens = new <Tween>[new Tween(ANIMATION_DELAY,waitingListSection,param1,{
            "paused":false,
            "ease":Strong.easeOut,
            "onComplete":null
         }),new Tween(ANIMATION_DELAY,teamSection,param1,{
            "paused":false,
            "ease":Strong.easeOut,
            "onComplete":null
         }),new Tween(ANIMATION_DELAY,chatSection,param1,{
            "paused":false,
            "ease":Strong.easeOut,
            "onComplete":null
         })];
      }
      
      private function cleanTweens() : void
      {
         var _loc1_:Tween = null;
         if(this._tweens)
         {
            for each(_loc1_ in this._tweens)
            {
               _loc1_.paused = true;
            }
            this._tweens.splice(0,this._tweens.length);
         }
      }
      
      public function get unitTeamSection() : TeamSection
      {
         return teamSection as TeamSection;
      }
      
      private function set rosterTeamSectionMouseEnabled(param1:Boolean) : void
      {
         this._isRosterSettingsVisible = param1;
         this.rosterTeamSection.mouseEnabled = param1;
         this.rosterTeamSection.mouseChildren = param1;
         Sprite(teamSection).mouseEnabled = !param1;
         Sprite(teamSection).mouseChildren = !param1;
         waitingListSection.mouseEnabled = !param1;
         waitingListSection.mouseChildren = !param1;
         Sprite(chatSection).mouseEnabled = !param1;
         Sprite(chatSection).mouseChildren = !param1;
         this.rosterTeamContext = param1;
      }
      
      override protected function onChooseVehicleRequest(param1:RallyViewsEvent) : void
      {
         if(!this.rosterTeamContext)
         {
            chooseVehicleRequestS();
         }
      }
      
      private function onClickConfigureButtonHandler(param1:CSComponentEvent) : void
      {
         this.initFadeAnimation();
      }
      
      private function onToggleFreezeRequestHandler(param1:CSComponentEvent) : void
      {
         toggleFreezeRequestS();
      }
      
      private function onToggleStatusRequestHandler(param1:CSComponentEvent) : void
      {
         toggleStatusRequestS();
      }
      
      private function onApplyRosterSettingsHandler(param1:CSComponentEvent) : void
      {
         resultRosterSlotsSettingsS(this.rosterTeamSection.getSettingsResults());
         this.initFadeAnimation();
      }
      
      private function onCancelRosterSettingsHandler(param1:CSComponentEvent) : void
      {
         this.preInitFadeAnimationCancel();
      }
      
      private function onShowSettingsRosterWndHandler(param1:CSComponentEvent) : void
      {
         if(this.rosterTeamContext)
         {
            showSettingsRosterS(param1.data);
         }
      }
      
      private function onLockSlotRequestHandler(param1:CSComponentEvent) : void
      {
         lockSlotRequestS(param1.data);
      }
   }
}
