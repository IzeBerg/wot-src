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
       
      
      public var skills:TileList = null;
      
      public var lastSkillLevel:TextField = null;
      
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
         var _loc8_:SkillsVO = null;
         this.tryDisposeGroupIcons();
         this.tryDisposeSkillsRenderersData();
         var _loc2_:Array = param1.skills;
         var _loc3_:int = _loc2_.length;
         this._renderSkillsData = [];
         var _loc4_:Boolean = param1.canBuySkill;
         var _loc5_:int = param1.buySkillCount;
         var _loc6_:Boolean = param1.lastSkillInProgress;
         var _loc7_:int = _loc3_ + (!!_loc4_ ? 1 : 0);
         if(_loc7_ >= MAX_RENDER_SKILLS)
         {
            this.addGroupIcon(_loc3_ - (!!_loc6_ ? 1 : 0));
            if(_loc6_)
            {
               this._renderSkillsData.push(_loc2_[_loc3_ - 2].clone());
            }
            else
            {
               this._renderSkillsData.push(_loc2_[_loc3_ - 1].clone());
            }
            if(_loc6_ || _loc4_)
            {
               this._renderSkillsData.push(this.createEmptySkillItem());
               this._renderSkillsData.push(this.createEmptySkillItem());
               if(_loc6_)
               {
                  this._renderSkillsData.push(_loc2_[_loc3_ - 1].clone());
               }
               else
               {
                  if(_loc5_ > 1)
                  {
                     this.addGroupIcon(_loc5_);
                  }
                  this._renderSkillsData.push(this.createBuySkillItem(param1));
               }
            }
         }
         else
         {
            for each(_loc8_ in _loc2_)
            {
               this._renderSkillsData.push(_loc8_.clone());
            }
            if(_loc4_)
            {
               if(_loc5_ > 1)
               {
                  this.addGroupIcon(_loc5_);
               }
               this._renderSkillsData.push(this.createBuySkillItem(param1));
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
            this.lastSkillLevel.visible = _loc6_;
            if(this.lastSkillLevel.visible)
            {
               this.lastSkillLevel.text = param1.lastSkillLevel + PERCENT_SIGN;
               App.utils.commons.updateTextFieldSize(this.lastSkillLevel);
               this.lastSkillLevel.x = this.skills.x + (this.skills.columnWidth + this.skills.paddingRight) * this._renderSkillsData.length | 0;
            }
         }
         else
         {
            this.lastSkillLevel.visible = false;
         }
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
      
      private function addGroupIcon(param1:int) : void
      {
         var _loc2_:SmallSkillGroupIcons = App.utils.classFactory.getComponent(Linkages.SMALL_SKILL_GROUP_ICON,SmallSkillGroupIcons);
         _loc2_.setSkillsNumber(param1);
         if(this._groupIcons == null)
         {
            this._groupIcons = new <SmallSkillGroupIcons>[_loc2_];
         }
         else
         {
            this._groupIcons.push(_loc2_);
         }
         addChild(_loc2_);
         _loc2_.x = this.skills.x + this._renderSkillsData.length * (this.skills.columnWidth + this.skills.paddingRight) | 0;
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
