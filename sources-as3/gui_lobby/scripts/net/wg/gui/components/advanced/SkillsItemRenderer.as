package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PERSONALCASECONST;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;
   import net.wg.gui.lobby.tankman.RankElement;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.StatusIndicator;
   
   public class SkillsItemRenderer extends SoundListItemRenderer
   {
      
      protected static const BG_FRAME_LABEL_NEW_SKILL:String = "new_skill";
      
      protected static const BG_FRAME_LABEL_NEW_SKILL_BC:String = "new_skill_bootcamp";
      
      protected static const BG_FRAME_LABEL_INACTIVE:String = "not_active_up";
      
      protected static const BG_FRAME_LABEL_ACTIVE:String = "active_up";
      
      protected static const RANK_MC_FRAME_LABEL_ENABLED:String = "enabled";
      
      protected static const RANK_MC_FRAME_LABEL_DISABLED:String = "disabled";
      
      private static const MAX_LEVEL:int = 100;
      
      private static const ALPHA_FULL:int = 1;
      
      private static const ALPHA_HALF:Number = 0.5;
      
      private static const ALPHA_ZERO:int = 0;
       
      
      public var loader:UILoaderAlt = null;
      
      public var loadingBar:StatusIndicator = null;
      
      public var _titleLabel:TextField = null;
      
      public var bg:MovieClip = null;
      
      public var levelMc:SkillsLevelItemRenderer = null;
      
      public var rankMc:RankElement = null;
      
      public var notActive:MovieClip = null;
      
      public var activeFrame:MovieClip = null;
      
      private var _model:CarouselTankmanSkillsModel = null;
      
      private var _isNewSkill:Boolean = false;
      
      private var _isBootcamp:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _isCommon:Boolean = false;
      
      private var _isDisabled:Boolean = false;
      
      private var _isShowLoadingBar:Boolean = false;
      
      private var _skillLevel:int = -1;
      
      private var _bgIcon:String = "";
      
      private var _skillName:String = "";
      
      private var _rollIcon:String = "";
      
      private var _tankmanID:int = -1;
      
      private var _skillsCountForLearn:int = -1;
      
      private var _relatedTab:String = "";
      
      private var _selectedTab:String = "";
      
      private var _isFreeSkill:Boolean = false;
      
      private var _skillEnabled:Boolean = false;
      
      public function SkillsItemRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         this.soundType = SoundTypes.TAB;
      }
      
      override protected function onDispose() : void
      {
         this.levelMc.dispose();
         this.levelMc = null;
         this.rankMc.dispose();
         this.rankMc = null;
         this.loader.dispose();
         this.loader = null;
         this.loadingBar.dispose();
         this.loadingBar = null;
         this.bg = null;
         this.notActive = null;
         this.activeFrame = null;
         this._titleLabel = null;
         this._model = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && this.data)
         {
            this.setup();
         }
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         var _loc2_:PersonalCaseEvent = null;
         super.handleClick(param1);
         if(this._isNewSkill)
         {
            _loc2_ = new PersonalCaseEvent(PersonalCaseEvent.CHANGE_TAB,true);
            _loc2_.relatedTabId = this._relatedTab;
            dispatchEvent(_loc2_);
         }
      }
      
      private function setup() : void
      {
         this._model = this.data as CarouselTankmanSkillsModel;
         App.utils.asserter.assertNotNull(this._model,"_model " + Errors.CANT_NULL);
         buttonMode = true;
         this.initializeFields();
         this.updateLoader();
         this.updateLoaderEffects();
         this.updateRoleIcon();
         this.updateVisibility();
         this.bgUpdate();
         if(this._isNewSkill)
         {
            this.updateNewSkillState();
         }
         else
         {
            this.updateInProgressSkillState();
         }
         this._model = null;
      }
      
      private function initializeFields() : void
      {
         this._skillsCountForLearn = this._model.skillsCountForLearn;
         this._isDisabled = !this._model.isActive || !this._model.enabled;
         this._isNewSkill = this._model.isNewSkill;
         this._isBootcamp = this._model.isBootcamp;
         this._skillEnabled = this._model.enabled;
         this._tankmanID = this._model.tankmanID;
         this._isCommon = this._model.isCommon;
         this._rollIcon = this._model.roleIcon;
         this._skillLevel = this._model.level;
         this._skillName = this._model.name;
         this._bgIcon = this._model.icon;
         this._selectedTab = this._model.selectedTab;
         this._isFreeSkill = this._model.isFreeSkill;
         this._relatedTab = !!this._isFreeSkill ? PERSONALCASECONST.FREE_SKILLS_TAB_ID : PERSONALCASECONST.SKILLS_TAB_ID;
         this._isShowLoadingBar = !this._isNewSkill && this._skillLevel != MAX_LEVEL;
      }
      
      private function updateVisibility() : void
      {
         this.notActive.visible = this._isDisabled && !this._isNewSkill;
         this.activeFrame.visible = this._selectedTab == this._relatedTab && this._isNewSkill;
         this.loadingBar.visible = this._titleLabel.visible = this._isShowLoadingBar;
      }
      
      private function updateRoleIcon() : void
      {
         this.rankMc.visible = !this._isCommon;
         if(!this._isCommon)
         {
            this.rankMc.setSource(this._rollIcon);
            this.rankMc.gotoAndPlay(!!this._skillEnabled ? RANK_MC_FRAME_LABEL_ENABLED : RANK_MC_FRAME_LABEL_DISABLED);
         }
      }
      
      private function updateNewSkillState() : void
      {
         this.rankMc.visible = false;
         if(this._skillsCountForLearn > 1)
         {
            this.levelMc.visible = true;
            this.levelMc.updateText(this._skillsCountForLearn - 1);
         }
         else
         {
            this.levelMc.visible = false;
         }
         this.levelMc.alpha = !!this.levelMc.visible ? Number(ALPHA_FULL) : Number(ALPHA_ZERO);
         this.alpha = this._selectedTab == this._relatedTab ? Number(ALPHA_FULL) : Number(ALPHA_HALF);
      }
      
      private function bgUpdate() : void
      {
         if(this._isNewSkill)
         {
            this.bg.gotoAndPlay(!!this._isBootcamp ? BG_FRAME_LABEL_NEW_SKILL_BC : BG_FRAME_LABEL_NEW_SKILL);
         }
         else
         {
            this.bg.gotoAndPlay(!!this._isDisabled ? BG_FRAME_LABEL_INACTIVE : BG_FRAME_LABEL_ACTIVE);
         }
      }
      
      private function updateInProgressSkillState() : void
      {
         this.levelMc.visible = false;
         if(this._isShowLoadingBar)
         {
            this.loadingBar.position = this._skillLevel;
         }
         this._titleLabel.text = this._skillLevel.toString() + "%";
      }
      
      private function updateLoaderEffects() : void
      {
         if(this.loader.visible)
         {
            if(this._isDisabled)
            {
               App.utils.commons.setColorTransformMultipliers(this.loader,1,0.6,0.6,0.6);
            }
            else
            {
               App.utils.commons.setColorTransformMultipliers(this.loader,1,1,1,1);
            }
         }
      }
      
      private function updateLoader() : void
      {
         var _loc1_:Boolean = StringUtils.isNotEmpty(this._bgIcon) && !this._isNewSkill;
         if(_loc1_)
         {
            this.loader.visible = true;
            this.loader.source = this._bgIcon;
         }
         else
         {
            this.loader.visible = false;
         }
      }
      
      private function showToolTip() : void
      {
         if(this._isNewSkill)
         {
            if(this._isFreeSkill)
            {
               this._tooltipMgr.show(TOOLTIPS.BUYFREESKILL_HEADER);
            }
            else
            {
               this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN_NEW_SKILL,null,this._tankmanID);
            }
         }
         else
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN_SKILL,null,this._skillName,this._tankmanID,this._isFreeSkill);
         }
      }
      
      [Inspectable(defaultValue="",type="string")]
      override public function get data() : Object
      {
         return _data;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.data = param1;
         invalidate(InvalidationType.DATA);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         if(this._skillName == Values.EMPTY_STR && this._tankmanID == Values.DEFAULT_INT)
         {
            return;
         }
         this.showToolTip();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
   }
}
