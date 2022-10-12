package net.wg.gui.lobby.components
{
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.lobby.components.data.BaseTankmanVO;
   import net.wg.gui.lobby.components.data.SkillsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class SmallSkillsList extends UIComponentEx
   {
      
      private static const PERCENT_SIGN:String = "%";
      
      private static const MAX_RENDER_SKILLS:int = 5;
      
      private static const SHIFT_SKILLS_COUNT:int = 2;
       
      
      public var skills:TileList = null;
      
      public var lastSkillLevel:TextField = null;
      
      private var _buySkillCount:int = 0;
      
      private var _isEmptySkillShifted:Boolean = false;
      
      private var _showBuyAnimation:Boolean = true;
      
      private var _renderSkillsData:Array = null;
      
      private var _groupIcons:Vector.<SmallSkillGroupIcons> = null;
      
      public function SmallSkillsList()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.skills.dispose();
         this.skills = null;
         this.lastSkillLevel = null;
         this.tryDisposeGroupIcons();
         this.tryDisposeSkillsRenderersData();
         super.onDispose();
      }
      
      public function updateSkills(param1:BaseTankmanVO) : void
      {
         var _loc7_:SkillsVO = null;
         var _loc8_:int = 0;
         this.tryDisposeGroupIcons();
         this.tryDisposeSkillsRenderersData();
         var _loc2_:Array = param1.skills;
         var _loc3_:int = _loc2_.length;
         this._renderSkillsData = [];
         var _loc4_:Boolean = param1.canBuySkill;
         var _loc5_:Boolean = param1.lastSkillInProgress;
         var _loc6_:int = _loc3_ + (!!_loc4_ ? 1 : 0);
         this._buySkillCount = param1.buySkillCount + param1.buyFreeSkillCount;
         this._isEmptySkillShifted = param1.buyFreeSkillCount > 0 && _loc5_;
         if(_loc6_ >= MAX_RENDER_SKILLS)
         {
            this.addGroupIcon(_loc3_ - (!!_loc5_ ? 1 : 0));
            if(_loc5_)
            {
               this._renderSkillsData.push(_loc2_[_loc3_ - 2].clone());
            }
            else
            {
               this._renderSkillsData.push(_loc2_[_loc3_ - 1].clone());
            }
            if(_loc5_ || _loc4_)
            {
               this._renderSkillsData.push(this.createEmptySkillItem());
               this._renderSkillsData.push(this.createEmptySkillItem());
               if(_loc5_)
               {
                  this._renderSkillsData.push(_loc2_[_loc3_ - 1].clone());
                  if(param1.buyFreeSkillCount > 0)
                  {
                     this.createSeparatedEmptySkill(param1);
                  }
               }
               else
               {
                  this.createSeparatedEmptySkill(param1);
               }
            }
         }
         else
         {
            for each(_loc7_ in _loc2_)
            {
               this._renderSkillsData.push(_loc7_.clone());
            }
            if(_loc4_)
            {
               this.createSeparatedEmptySkill(param1);
            }
         }
         if(this.skills.dataProvider != null)
         {
            this.skills.dataProvider.cleanUp();
         }
         this.skills.dataProvider = new DataProvider(this._renderSkillsData);
         this.skills.validateNow();
         if(this._renderSkillsData.length > 0)
         {
            this.lastSkillLevel.visible = _loc5_;
            if(this.lastSkillLevel.visible)
            {
               this.lastSkillLevel.text = param1.lastSkillLevel + PERCENT_SIGN;
               App.utils.commons.updateTextFieldSize(this.lastSkillLevel);
               _loc8_ = this._renderSkillsData.length - (!!this._isEmptySkillShifted ? SHIFT_SKILLS_COUNT + 1 : 0);
               this.lastSkillLevel.x = this.skills.x + (this.skills.columnWidth + this.skills.paddingRight) * _loc8_ | 0;
            }
         }
         else
         {
            this.lastSkillLevel.visible = false;
         }
      }
      
      private function createSeparatedEmptySkill(param1:BaseTankmanVO) : void
      {
         var _loc2_:int = 0;
         if(this._isEmptySkillShifted)
         {
            _loc2_ = 0;
            while(_loc2_ < SHIFT_SKILLS_COUNT)
            {
               this._renderSkillsData.push(this.createEmptySkillItem());
               _loc2_++;
            }
         }
         if(this._buySkillCount > 1)
         {
            this.addGroupIcon(this._buySkillCount,true);
         }
         this._renderSkillsData.push(this.createBuySkillItem(param1));
      }
      
      private function tryDisposeGroupIcons() : void
      {
         var _loc1_:SmallSkillGroupIcons = null;
         if(this._groupIcons != null)
         {
            for each(_loc1_ in this._groupIcons)
            {
               removeChild(_loc1_);
               _loc1_.dispose();
            }
            this._groupIcons.splice(0,this._groupIcons.length);
            this._groupIcons = null;
         }
      }
      
      private function tryDisposeSkillsRenderersData() : void
      {
         var _loc1_:IDisposable = null;
         if(this._renderSkillsData != null)
         {
            for each(_loc1_ in this._renderSkillsData)
            {
               _loc1_.dispose();
            }
            this._renderSkillsData.splice(0,this._renderSkillsData.length);
            this._renderSkillsData = null;
         }
      }
      
      private function addGroupIcon(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:SmallSkillGroupIcons = App.utils.classFactory.getComponent(Linkages.SMALL_SKILL_GROUP_ICON,SmallSkillGroupIcons);
         _loc3_.setSkillsNumber(param1);
         _loc3_.changeInnerFrame(param2);
         if(this._groupIcons == null)
         {
            this._groupIcons = new <SmallSkillGroupIcons>[_loc3_];
         }
         else
         {
            this._groupIcons.push(_loc3_);
         }
         addChild(_loc3_);
         _loc3_.x = this.skills.x + this._renderSkillsData.length * (this.skills.columnWidth + this.skills.paddingRight) | 0;
      }
      
      private function createEmptySkillItem() : SkillsVO
      {
         return new SkillsVO({});
      }
      
      private function createBuySkillItem(param1:BaseTankmanVO) : SkillsVO
      {
         var _loc2_:SkillsVO = this.createEmptySkillItem();
         _loc2_.icon = RES_ICONS.MAPS_ICONS_TANKMEN_SKILLS_SMALL_NEW_SKILL;
         _loc2_.tankmanID = param1.tankmanID;
         _loc2_.level = param1.buySkillLevel;
         _loc2_.buyCount = param1.buySkillCount;
         _loc2_.buyFreeCount = param1.buyFreeSkillCount;
         _loc2_.buy = true;
         _loc2_.showBuyAnimation = this._showBuyAnimation;
         return _loc2_;
      }
      
      public function get showBuyAnimation() : Boolean
      {
         return this._showBuyAnimation;
      }
      
      public function set showBuyAnimation(param1:Boolean) : void
      {
         this._showBuyAnimation = param1;
      }
   }
}
