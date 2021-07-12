package net.wg.gui.lobby.epicBattles.views
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.gui.components.advanced.BackButton;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
   import net.wg.gui.lobby.epicBattles.components.skillView.EpicBattlesSkillsGroup;
   import net.wg.gui.lobby.epicBattles.components.skillView.EpicBattlesUnspentPoints;
   import net.wg.gui.lobby.epicBattles.components.skillView.SkillInfoPane;
   import net.wg.gui.lobby.epicBattles.data.EpicBattleSkillVO;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesSkillViewVO;
   import net.wg.gui.lobby.epicBattles.events.EpicBattlesSkillViewClickEvent;
   import net.wg.gui.lobby.epicBattles.events.SkillLevelBarMouseEvent;
   import net.wg.infrastructure.base.meta.IEpicBattlesSkillViewMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattlesSkillViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class EpicBattlesSkillView extends EpicBattlesSkillViewMeta implements IEpicBattlesSkillViewMeta
   {
      
      private static const CLOSE_BTN_RIGHT_OFFSET:int = 22;
      
      private static const SKILL_TILES_Y_OFFSET:int = 250;
      
      private static const CLOSE_BTN_RIGHT_OFFSET_SMALL:int = 36;
      
      private static const HEIGHT_TRANSITION_LIMIT:int = 900;
      
      private static const WIDTH_TRANSITION_LIMIT:int = 1440;
      
      private static const MIN_BOTTOM_GAP:int = 50;
      
      private static const TOP_OFFSET_RATIO:Number = 0.5;
      
      private static const TITLE_TO_POINTS_GAP:int = 12;
      
      private static const SKILLS_TO_PANEL_GAP:int = 6;
      
      private static const BIG_SKILL_TO_PANEL_GAP:int = 34;
      
      private static const RIGHT_OFFSET:int = 28;
      
      private static const BOTTOM_OFFSET:int = 35;
      
      private static const BACK_BTN_RIGHT_MARGIN:int = 7;
      
      private static const SKILL_GROUP_NAME:String = "skillGroup";
      
      private static const INVALID_INITIAL_DATA:String = "invInitData";
       
      
      public var titleTF:TextField = null;
      
      public var unspentPoints:EpicBattlesUnspentPoints = null;
      
      public var infoPane:SkillInfoPane = null;
      
      public var closeBtn:CloseButtonText = null;
      
      public var backButton:BackButton = null;
      
      private var _data:EpicBattlesSkillViewVO = null;
      
      private var _lastTitleStr:String = "";
      
      private var _currentlySelectedSkillID:int = -1;
      
      private var _skillsGroup:EpicBattlesSkillsGroup = null;
      
      public function EpicBattlesSkillView()
      {
         super();
         this._skillsGroup = new EpicBattlesSkillsGroup();
         this._skillsGroup.name = SKILL_GROUP_NAME;
         addChild(this._skillsGroup);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.backButton.x = BACK_BTN_RIGHT_MARGIN;
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         super.draw();
         this.infoPane.y = 0;
         if(this._data)
         {
            _loc1_ = isInvalid(InvalidationType.SIZE);
            if(isInvalid(INVALID_INITIAL_DATA))
            {
               setBackground(this._data.backgroundImageSrc);
               this.unspentPoints.updateData(this._data.skillsLabel,this._data.showSkillPoints,this._data.skillPoints);
               _loc1_ = true;
            }
            if(isInvalid(InvalidationType.DATA))
            {
               this.unspentPoints.updateData(this._data.skillsLabel,this._data.showSkillPoints,this._data.skillPoints);
               this.unspentPoints.x = this._skillsGroup.x + (this._skillsGroup.width - this.unspentPoints.width >> 1);
               this.infoPane.infoPaneContent.setAvailableSkillPoints(this._data.skillPoints);
            }
            if(_loc1_)
            {
               _loc2_ = App.appHeight < HEIGHT_TRANSITION_LIMIT || App.appWidth < WIDTH_TRANSITION_LIMIT;
               this._skillsGroup.switchRenderersSize(_loc2_);
               _loc3_ = !!_loc2_ ? int(SkillInfoPane.INFO_WIDTH_MINRES) : int(SkillInfoPane.INFO_WIDTH_REGULAR);
               this.infoPane.setSize(_loc3_,bgActualHeight - BOTTOM_OFFSET);
               _loc4_ = bgActualHeight - this._skillsGroup.height - MIN_BOTTOM_GAP;
               _loc5_ = Math.max(SKILL_TILES_Y_OFFSET,_loc4_ * TOP_OFFSET_RATIO);
               this._skillsGroup.y = _loc5_;
               _loc6_ = !!_loc2_ ? this._data.header : this._data.headerBig;
               if(this._lastTitleStr != _loc6_)
               {
                  this._lastTitleStr = _loc6_;
                  this.titleTF.htmlText = _loc6_;
                  App.utils.commons.updateTextFieldSize(this.titleTF,true,true);
               }
               this.unspentPoints.y = this.titleTF.y + this.titleTF.height + TITLE_TO_POINTS_GAP;
               _loc7_ = !!_loc2_ ? int(SKILLS_TO_PANEL_GAP) : int(BIG_SKILL_TO_PANEL_GAP);
               _loc8_ = !!_loc2_ ? int(RIGHT_OFFSET) : int(0);
               _loc9_ = this._skillsGroup.width + _loc7_ + _loc3_ + _loc8_;
               this._skillsGroup.x = bgActualWidth - _loc9_ >> 1;
               _loc10_ = this._skillsGroup.x + (this._skillsGroup.width >> 1);
               this.infoPane.x = this._skillsGroup.x + this._skillsGroup.width + _loc7_;
               this.titleTF.x = _loc10_ - (this.titleTF.width >> 1);
               this.unspentPoints.x = _loc10_ - (this.unspentPoints.width >> 1);
               this.closeBtn.visibleText = !_loc2_;
               this.closeBtn.validateNow();
               if(_loc2_)
               {
                  this.closeBtn.x = bgActualWidth - CLOSE_BTN_RIGHT_OFFSET_SMALL;
               }
               else
               {
                  this.closeBtn.x = bgActualWidth - this.closeBtn.width - CLOSE_BTN_RIGHT_OFFSET;
               }
            }
         }
      }
      
      override protected function setSkillDataBlock(param1:BlockDataItemVO) : void
      {
         this.infoPane.setSkillData(param1);
      }
      
      override protected function onDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeButtonPressedHandler);
         this._skillsGroup.removeEventListener(Event.RESIZE,this.onSkillGroupResizeHandler);
         this._skillsGroup.removeEventListener(EpicBattlesSkillViewClickEvent.SLOT_ITEM_CLICKED,this.onSkillSlotItemClickedHandler);
         this._skillsGroup.dispose();
         this._skillsGroup = null;
         this.infoPane.dispose();
         this.infoPane = null;
         this._data = null;
         this.titleTF = null;
         this.unspentPoints.dispose();
         this.unspentPoints = null;
         this.backButton.dispose();
         this.backButton.enabled = false;
         this.backButton = null;
         this.closeBtn.dispose();
         this.closeBtn.enabled = false;
         this.closeBtn = null;
         super.onDispose();
      }
      
      override protected function setData(param1:EpicBattlesSkillViewVO) : void
      {
         this._data = param1;
         this.backButton.visible = param1.showBackButton;
         this._skillsGroup.dataProvider = this._data.skills;
         this.infoPane.infoPaneContent.initData(this._data.skillInfo);
         invalidate(INVALID_INITIAL_DATA);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeButtonPressedHandler,true);
         this.closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.backButton.label = MENU.VIEWHEADER_BACKBTN_LABEL;
         this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
         this._skillsGroup.addEventListener(EpicBattlesSkillViewClickEvent.SLOT_ITEM_CLICKED,this.onSkillSlotItemClickedHandler);
         this._skillsGroup.addEventListener(Event.RESIZE,this.onSkillGroupResizeHandler);
         this.infoPane.addEventListener(SkillLevelBarMouseEvent.LEVEL_BAR_SECTION_OVER,this.onSkillLevelBarSectionOverHandler);
         this.infoPane.addEventListener(EpicBattlesSkillViewClickEvent.SKILL_LEVEL_UP_CLICKED,this.onButtonSkillLevelUpClickedHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
         this.infoPane.removeEventListener(SkillLevelBarMouseEvent.LEVEL_BAR_SECTION_OVER,this.onSkillLevelBarSectionOverHandler);
         this.infoPane.removeEventListener(EpicBattlesSkillViewClickEvent.SKILL_LEVEL_UP_CLICKED,this.onButtonSkillLevelUpClickedHandler);
         super.onBeforeDispose();
      }
      
      public function as_setSelectedSkill(param1:int) : void
      {
         if(this._currentlySelectedSkillID == param1)
         {
            return;
         }
         this._currentlySelectedSkillID = param1;
         this.setSelectedSkill(param1);
      }
      
      public function as_updateData(param1:Object) : void
      {
         this._data.update(param1);
         invalidateData();
      }
      
      private function onEscapeButtonPressedHandler() : void
      {
         onEscapePressS();
      }
      
      private function setSelectedSkill(param1:int) : void
      {
         var _loc4_:EpicBattleSkillVO = null;
         var _loc2_:int = this._data.skills.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._data.skills[_loc3_];
            if(_loc4_ && _loc4_.skillID == param1)
            {
               this._currentlySelectedSkillID = _loc4_.skillID;
               this.infoPane.setSkillInfo(_loc4_,this._data.skillPoints);
               this._skillsGroup.setSelectedTile(_loc3_);
               break;
            }
            _loc3_++;
         }
      }
      
      private function onBackButtonClickHandler(param1:ButtonEvent) : void
      {
         onBackBtnClickS();
      }
      
      private function onSkillGroupResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onSkillLevelBarSectionOverHandler(param1:SkillLevelBarMouseEvent) : void
      {
         onSkillOverLevelS(this._currentlySelectedSkillID,param1.overLevel);
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         onCloseBtnClickS();
      }
      
      private function onButtonSkillLevelUpClickedHandler(param1:EpicBattlesSkillViewClickEvent) : void
      {
         onSkillUpgradeS(param1.skillID);
      }
      
      private function onSkillSlotItemClickedHandler(param1:EpicBattlesSkillViewClickEvent) : void
      {
         onSelectSkillBtnClickS(param1.skillID);
      }
   }
}
