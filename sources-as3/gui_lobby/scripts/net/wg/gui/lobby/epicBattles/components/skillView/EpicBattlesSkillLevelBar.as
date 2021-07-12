package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.lobby.epicBattles.data.EpicBattleSkillVO;
   import net.wg.gui.lobby.epicBattles.events.SkillLevelBarMouseEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicBattlesSkillLevelBar extends UIComponentEx
   {
      
      private static const MAX_LEVEL:int = 5;
      
      private static const SECTION_TIER_OFFSET:int = 48;
       
      
      public var levelTF:TextField = null;
      
      public var section1:EpicBattlesSkillBarSection = null;
      
      public var section2:EpicBattlesSkillBarSection = null;
      
      public var section3:EpicBattlesSkillBarSection = null;
      
      public var section4:EpicBattlesSkillBarSection = null;
      
      public var section5:EpicBattlesSkillBarSection = null;
      
      public var skillBarSteps:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      private var _sections:Vector.<EpicBattlesSkillBarSection> = null;
      
      private var _data:EpicBattleSkillVO = null;
      
      private var _currentlyActiveLevel:int = 0;
      
      public function EpicBattlesSkillLevelBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.skillBarSteps.mouseChildren = this.skillBarSteps.mouseEnabled = false;
         this.bg.mouseChildren = this.bg.mouseEnabled = false;
         var _loc1_:int = this._sections.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._sections[_loc2_].index = _loc2_;
            this._sections[_loc2_].gotoAndPlay(EpicBattlesSkillBarSection.ACTIVE_STATE);
            this._sections[_loc2_].addEventListener(MouseEvent.ROLL_OVER,this.onLevelBarSectionRollOverHandler);
            this._sections[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.onLevelBarSectionRollOutHandler);
            _loc2_++;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EpicBattlesSkillBarSection = null;
         for each(_loc1_ in this._sections)
         {
            _loc1_.stop();
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onLevelBarSectionRollOverHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onLevelBarSectionRollOutHandler);
         }
         this._sections.splice(0,this._sections.length);
         this._sections = null;
         this.levelTF = null;
         this.section1.dispose();
         this.section1 = null;
         this.section2.dispose();
         this.section2 = null;
         this.section3.dispose();
         this.section3 = null;
         this.section4.dispose();
         this.section4 = null;
         this.section5.dispose();
         this.section5 = null;
         this.skillBarSteps = null;
         this.bg = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.highlightLevel(this._currentlyActiveLevel);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._sections = new <EpicBattlesSkillBarSection>[this.section1,this.section2,this.section3,this.section4,this.section5];
      }
      
      public function setData(param1:EpicBattleSkillVO) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            this._data = param1;
            _loc2_ = param1.level > MAX_LEVEL ? int(MAX_LEVEL) : int(this._data.level);
            this._currentlyActiveLevel = _loc2_;
            this.skillBarSteps.gotoAndStop(_loc2_ > 0 ? _loc2_ + 1 : 1);
            invalidateData();
         }
      }
      
      private function highlightLevel(param1:int) : void
      {
         if(param1 > 0)
         {
            this.levelTF.visible = true;
            this.levelTF.text = this._data.skillLevelLabels[param1 - 1];
            this.levelTF.x = this._sections[param1 - 1].x + SECTION_TIER_OFFSET;
         }
         else
         {
            this.levelTF.visible = false;
         }
      }
      
      private function onLevelBarSectionRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:EpicBattlesSkillBarSection = param1.target as EpicBattlesSkillBarSection;
         if(this._data && _loc2_)
         {
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
            this._currentlyActiveLevel = this._sections.indexOf(_loc2_) + 1;
            _loc2_.setState(EpicBattlesSkillBarSection.OVER_STATE);
            invalidateData();
            dispatchEvent(new SkillLevelBarMouseEvent(SkillLevelBarMouseEvent.LEVEL_BAR_SECTION_OVER,this._sections.indexOf(_loc2_) + 1));
         }
      }
      
      private function onLevelBarSectionRollOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:EpicBattlesSkillBarSection = param1.target as EpicBattlesSkillBarSection;
         if(_loc2_)
         {
            this._currentlyActiveLevel = this._data.level;
            this.highlightLevel(this._data.level);
            _loc2_.setState(EpicBattlesSkillBarSection.OUT_STATE);
            dispatchEvent(new SkillLevelBarMouseEvent(SkillLevelBarMouseEvent.LEVEL_BAR_SECTION_OVER,this._currentlyActiveLevel));
         }
      }
   }
}
