package net.wg.gui.lobby.battleResults.progressReport
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class BattleResultUnlockItem extends UIComponentEx implements ISubtaskComponent
   {
      
      private static const SKILLS_Y_INITIAL:int = 4;
      
      private static const SKILLS_Y_SHIFT:int = 24;
      
      private static const TEXTS_Y_SHIFT:int = 22;
      
      private static const LINE_Y_SHIFT:int = 52;
      
      private static const DOUBLE_SKILLS_HEIGHT:int = 81;
      
      private static const SKILL_LINK_TYPE:String = "NEW_SKILL_LINK_TYPE";
       
      
      public var newSkill:NewSkillInfo;
      
      public var newFreeSkill:NewSkillInfo;
      
      public var newUnlock:NewSkillInfo;
      
      public var fittingIcon:ModuleTypesUIWithFill;
      
      public var vehicleIcon:UILoaderAlt;
      
      public var tankmenIcon:UILoaderAlt;
      
      public var lvlIcon:UILoaderAlt;
      
      public var description:TextField;
      
      public var prediction:TextField;
      
      public var price:CompoundPrice;
      
      public var lineMC:Sprite;
      
      private var _itemData:BattleResultUnlockItemVO;
      
      public function BattleResultUnlockItem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.price.actionState = CompoundPrice.ACTION_STATE_SHOW_VALUE;
         this.price.itemsDirection = CompoundPrice.DIRECTION_LEFT;
      }
      
      override protected function onDispose() : void
      {
         this._itemData.dispose();
         this._itemData = null;
         this.newSkill.dispose();
         this.newSkill = null;
         this.newFreeSkill.dispose();
         this.newFreeSkill = null;
         this.newUnlock.dispose();
         this.newUnlock = null;
         this.fittingIcon.dispose();
         this.fittingIcon = null;
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this.tankmenIcon.dispose();
         this.tankmenIcon = null;
         this.lvlIcon.dispose();
         this.lvlIcon = null;
         this.description = null;
         this.prediction = null;
         this.price.dispose();
         this.price = null;
         this.lineMC = null;
         super.onDispose();
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void
      {
      }
      
      public function setData(param1:Object) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         this._itemData = new BattleResultUnlockItemVO(param1);
         this.fittingIcon.visible = this._itemData.fittingType.length > 0;
         if(this.fittingIcon.visible)
         {
            this.fittingIcon.setModuleTypeIcon(this._itemData.fittingType);
         }
         this.initIcon(this.vehicleIcon,this._itemData.vehicleIcon);
         this.initIcon(this.tankmenIcon,this._itemData.tankmenIcon);
         this.initIcon(this.lvlIcon,this._itemData.lvlIcon);
         var _loc2_:Boolean = this._itemData.freeSkillsLinkEvent.length > 0;
         var _loc3_:Boolean = this._itemData.linkEvent.length > 0;
         _loc4_ = _loc3_ && this._itemData.linkEvent == SKILL_LINK_TYPE;
         _loc5_ = _loc3_ && this._itemData.linkEvent != SKILL_LINK_TYPE;
         if(_loc2_)
         {
            this.newFreeSkill.setData(this._itemData,true);
         }
         if(_loc4_)
         {
            this.newSkill.setData(this._itemData);
            if(_loc2_)
            {
               this.newSkill.y = SKILLS_Y_INITIAL + SKILLS_Y_SHIFT;
               this.description.y = this.prediction.y = this.newSkill.y + TEXTS_Y_SHIFT;
               this.lineMC.y = this.newSkill.y + LINE_Y_SHIFT;
               this.height = DOUBLE_SKILLS_HEIGHT;
            }
         }
         if(_loc5_)
         {
            this.newUnlock.setData(this._itemData);
         }
         this.newFreeSkill.visible = _loc2_;
         this.newSkill.visible = _loc4_;
         this.newUnlock.visible = _loc5_;
         this.description.htmlText = this._itemData.description;
         this.prediction.text = this._itemData.prediction;
         if(this._itemData.price)
         {
            this.price.setData(new ItemPriceVO(this._itemData.price[0]));
         }
      }
      
      private function initIcon(param1:UILoaderAlt, param2:String) : void
      {
         if(param2.length > 0)
         {
            param1.visible = true;
            param1.source = param2;
         }
         else
         {
            param1.visible = false;
         }
      }
   }
}
