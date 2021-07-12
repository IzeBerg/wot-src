package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
   import net.wg.gui.lobby.epicBattles.data.EpicBattleSkillInitVO;
   import net.wg.gui.lobby.epicBattles.data.EpicBattleSkillVO;
   import net.wg.gui.lobby.epicBattles.events.EpicBattlesSkillViewClickEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SkillInfoPaneContent extends UIComponentEx
   {
      
      private static const IMAGE_Y_OFFSET:int = 12;
      
      private static const DESC_Y_OFFSET:int = 12;
      
      private static const LEVEL_Y_OFFSET:int = 25;
      
      private static const BTN_Y_OFFSET:int = 16;
      
      private static const ALERT_Y_OFFSET:int = 12;
      
      private static const IMAGE_SMALL_SCALE:Number = 0.75;
      
      private static const IMAGE_REG_SIZE:int = 176;
      
      private static const IMAGE_SMALL_SIZE:int = IMAGE_REG_SIZE * IMAGE_SMALL_SCALE;
      
      private static const STATS_Y_OFFSET:int = 10;
      
      private static const MIN_TOP_OFFSET:int = 46;
       
      
      public var skillLevelAnimation:SkillLevelUpAnimationContainer = null;
      
      public var upgradeBtn:SoundButtonEx = null;
      
      public var descriptionTF:TextField = null;
      
      public var skillIcon:EpicBattlesSkillImage = null;
      
      public var skillLevelBar:EpicBattlesSkillLevelBar = null;
      
      public var titleTF:TextField = null;
      
      public var upgradeTF:TextField = null;
      
      public var statsComparisonPanel:SkillStatsPanel = null;
      
      private var _initData:EpicBattleSkillInitVO = null;
      
      private var _data:EpicBattleSkillVO = null;
      
      public function SkillInfoPaneContent()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.upgradeBtn.removeEventListener(MouseEvent.CLICK,this.onButtonUpgradeMouseClickHandler);
         this.upgradeBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onButtonUpgradeMouseRollOverHandler);
         this.upgradeBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onButtonUpgradeMouseRollOutHandler);
         this.upgradeBtn.dispose();
         this.upgradeBtn = null;
         this.descriptionTF = null;
         this.skillIcon.dispose();
         this.skillIcon = null;
         this.titleTF = null;
         this.upgradeTF = null;
         this.skillLevelBar.dispose();
         this.skillLevelBar = null;
         this.statsComparisonPanel.dispose();
         this.statsComparisonPanel = null;
         this._data.removeEventListener(Event.CHANGE,this.onSkillVOChangeHandler);
         this._data = null;
         this._initData = null;
         this.skillLevelAnimation.stop();
         this.skillLevelAnimation.dispose();
         this.skillLevelAnimation = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._data.title;
            this.descriptionTF.text = this._data.desc;
            this.skillIcon.source = this._data.iconUrl;
            this.skillIcon.switchColorization(Boolean(this._data.level));
            this.skillLevelBar.setData(this._data);
            this.upgradeTF.x = parent.width - this.upgradeTF.width >> 1;
            this.updateButtonState();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.layout(parent.width < SkillInfoPane.INFO_WIDTH_REGULAR);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.skillLevelAnimation.mouseEnabled = this.skillLevelAnimation.mouseChildren = false;
         this.upgradeBtn.addEventListener(MouseEvent.CLICK,this.onButtonUpgradeMouseClickHandler);
         this.upgradeBtn.addEventListener(MouseEvent.ROLL_OVER,this.onButtonUpgradeMouseRollOverHandler);
         this.upgradeBtn.addEventListener(MouseEvent.ROLL_OUT,this.onButtonUpgradeMouseRollOutHandler);
      }
      
      public function animateSkillLevelUp(param1:int) : void
      {
         this.skillLevelAnimation.setDataAndAnimate(param1);
      }
      
      public function initData(param1:EpicBattleSkillInitVO) : void
      {
         this._initData = param1;
         this.statsComparisonPanel.setHtmlText(this._initData.statsTitleLoc);
      }
      
      public function layout(param1:Boolean) : void
      {
         var _loc3_:Rectangle = null;
         this.titleTF.x = parent.width - this.titleTF.width >> 1;
         this.titleTF.y = 0;
         var _loc2_:int = !!param1 ? int(IMAGE_SMALL_SIZE) : int(IMAGE_REG_SIZE);
         this.skillIcon.scaleX = this.skillIcon.scaleY = !!param1 ? Number(IMAGE_SMALL_SCALE) : Number(1);
         this.skillIcon.x = parent.width - _loc2_ >> 1;
         this.skillIcon.y = this.titleTF.y + this.titleTF.height + IMAGE_Y_OFFSET | 0;
         this.descriptionTF.x = parent.width - this.descriptionTF.width >> 1;
         this.descriptionTF.y = this.skillIcon.y + _loc2_ + DESC_Y_OFFSET | 0;
         this.skillLevelBar.x = parent.width - this.skillLevelBar.width >> 1;
         this.skillLevelBar.y = this.descriptionTF.y + this.descriptionTF.height + LEVEL_Y_OFFSET | 0;
         _loc3_ = this.skillLevelBar.getBounds(this.skillLevelBar);
         this.upgradeBtn.x = parent.width - this.upgradeBtn.width - this.upgradeBtn.getBounds(this.upgradeBtn).left >> 1;
         this.upgradeBtn.y = this.skillLevelBar.y + this.skillLevelBar.height + _loc3_.top + BTN_Y_OFFSET | 0;
         this.upgradeTF.x = parent.width - this.upgradeTF.width >> 1;
         this.upgradeTF.y = this.skillLevelBar.y + this.skillLevelBar.height + _loc3_.top + ALERT_Y_OFFSET | 0;
         this.statsComparisonPanel.x = parent.width - this.statsComparisonPanel.width >> 1;
         this.statsComparisonPanel.y = this.upgradeBtn.y + this.upgradeBtn.height + STATS_Y_OFFSET | 0;
         this.skillLevelAnimation.x = this.skillIcon.x + (_loc2_ >> 1) | 0;
         this.skillLevelAnimation.y = this.skillIcon.y + (_loc2_ >> 1) | 0;
         y = Math.max(MIN_TOP_OFFSET,parent.height - _height + getBounds(this).top >> 1) | 0;
         x = 0;
      }
      
      public function setAvailableSkillPoints(param1:int) : void
      {
         this.upgradeBtn.visible = param1 > 0 && this._data.level < this._data.maxLevel;
         this.upgradeTF.visible = !this.upgradeBtn.visible;
         if(!this.upgradeTF.visible || !this._initData)
         {
            return;
         }
         if(this._data.level == this._data.maxLevel)
         {
            this.upgradeTF.htmlText = this._initData.abilityMaxLevelTxtLoc;
         }
         else if(this._data.level > 0)
         {
            this.upgradeTF.htmlText = this._initData.abilityNotPointsTxtLoc;
         }
         else
         {
            this.upgradeTF.htmlText = this._initData.abilityLockedTxtLoc;
         }
         App.utils.commons.updateTextFieldSize(this.upgradeTF,true,false);
         this.upgradeTF.x = parent.width - this.upgradeTF.width >> 1;
      }
      
      public function setBlockData(param1:BlockDataItemVO) : void
      {
         this.statsComparisonPanel.setBlock(param1);
      }
      
      public function setSkillInfo(param1:EpicBattleSkillVO, param2:int) : void
      {
         this._data = param1;
         this._data.removeEventListener(Event.CHANGE,this.onSkillVOChangeHandler);
         this._data.addEventListener(Event.CHANGE,this.onSkillVOChangeHandler);
         this.setAvailableSkillPoints(param2);
         invalidateData();
      }
      
      private function updateButtonState() : void
      {
         if(this._initData)
         {
            this.upgradeBtn.label = this._data.level > 0 ? this._initData.upgradeBtnLoc : this._initData.acquireBtnLoc;
         }
      }
      
      private function onSkillVOChangeHandler(param1:Event) : void
      {
         invalidateData();
      }
      
      private function onButtonUpgradeMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EPIC_SKILL_INFO,null,this._data.skillID,this._data.level + 1);
         }
      }
      
      private function onButtonUpgradeMouseRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onButtonUpgradeMouseClickHandler(param1:MouseEvent) : void
      {
         if(this._data)
         {
            dispatchEvent(new EpicBattlesSkillViewClickEvent(EpicBattlesSkillViewClickEvent.SKILL_LEVEL_UP_CLICKED,this._data.skillID,true));
         }
      }
   }
}
