package net.wg.gui.battle.historicalBattles.consumablesPanel
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import net.wg.infrastructure.base.meta.IHBConsumablesPanelMeta;
   import net.wg.infrastructure.base.meta.impl.HBConsumablesPanelMeta;
   import net.wg.utils.IClassFactory;
   
   public class HBConsumablesPanel extends HBConsumablesPanelMeta implements IHBConsumablesPanelMeta
   {
      
      private static const DIVIDER_OFFSET:int = 12;
      
      private static const SLOT_TYPE_AMMO:int = 0;
      
      private static const SLOT_TYPE_ABILITY:int = 1;
      
      private static const SLOT_TYPE_EQUIPMENT:int = 2;
      
      private static const SLOT_TYPE_PASSIVE_ABILITY:int = 3;
      
      private static const SLOT_TYPE_ROLE_ABILITY:int = 4;
       
      
      private var _factory:IClassFactory;
      
      private var _passiveAbilities:Dictionary;
      
      public function HBConsumablesPanel()
      {
         this._factory = App.utils.classFactory;
         this._passiveAbilities = new Dictionary();
         super();
      }
      
      private static function getSlotType(param1:DisplayObject) : int
      {
         if(param1 is HBEquipmentButton)
         {
            return SLOT_TYPE_EQUIPMENT;
         }
         if(param1 is HBShellButton)
         {
            return SLOT_TYPE_AMMO;
         }
         if(param1 is HBPassiveAbility)
         {
            return SLOT_TYPE_PASSIVE_ABILITY;
         }
         if(param1 is HBRoleAbilityButton)
         {
            return SLOT_TYPE_ROLE_ABILITY;
         }
         return SLOT_TYPE_ABILITY;
      }
      
      override protected function onDispose() : void
      {
         this._factory = null;
         App.instance.utils.data.cleanupDynamicObject(this._passiveAbilities);
         this._passiveAbilities = null;
         super.onDispose();
      }
      
      override protected function createEquipmentButton() : IConsumablesButton
      {
         return this._factory.getComponent(Linkages.HB_EQUIPMENT_BUTTON,HBEquipmentButton);
      }
      
      override protected function createShellButton() : IBattleShellButton
      {
         return this._factory.getComponent(Linkages.HB_SHELL_BUTTON_BATTLE,HBShellButton);
      }
      
      override protected function drawLayout() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc10_:* = null;
         var _loc1_:int = this.renderers.length;
         var _loc2_:int = 0;
         var _loc4_:int = itemsPadding;
         var _loc5_:int = Values.DEFAULT_INT;
         var _loc6_:int = Values.DEFAULT_INT;
         var _loc7_:uint = Values.ZERO;
         var _loc8_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         _loc7_ = 0;
         while(_loc7_ < _loc1_)
         {
            _loc3_ = getRendererBySlotIdx(_loc7_) as DisplayObject;
            if(_loc3_)
            {
               _loc8_.push(_loc3_);
            }
            _loc7_++;
         }
         var _loc9_:Vector.<int> = new Vector.<int>(0);
         for(_loc10_ in this._passiveAbilities)
         {
            _loc9_.push(_loc10_);
         }
         _loc9_.sort(Array.NUMERIC);
         for each(_loc7_ in _loc9_)
         {
            _loc8_.push(this._passiveAbilities[_loc7_]);
         }
         for each(_loc3_ in _loc8_)
         {
            _loc6_ = getSlotType(_loc3_);
            if(_loc3_.visible)
            {
               if(_loc5_ != _loc6_)
               {
                  if(_loc5_ != Values.DEFAULT_INT)
                  {
                     _loc2_ += DIVIDER_OFFSET;
                  }
               }
               _loc3_.x = _loc2_;
               _loc2_ += _loc4_;
            }
            _loc5_ = _loc6_;
         }
         basePanelWidth = _loc2_;
      }
      
      override protected function resetPassiveAbilities(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:HBPassiveAbility = null;
         if(!param1)
         {
            param1 = [];
         }
         if(param1.length == 0)
         {
            for(_loc3_ in this._passiveAbilities)
            {
               param1.push(int(_loc3_));
            }
         }
         for each(_loc2_ in param1)
         {
            _loc4_ = this._passiveAbilities[_loc2_] as HBPassiveAbility;
            if(_loc4_)
            {
               removeChild(_loc4_);
               _loc4_.dispose();
               delete this._passiveAbilities[_loc2_];
            }
         }
      }
      
      public function as_addAbilitySlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:String) : void
      {
         var _loc10_:int = 0;
         var _loc9_:IConsumablesButton = renderers[param1];
         if(_loc9_ != null)
         {
            if(!(_loc9_ is HBAbilityButton))
            {
               _loc10_ = renderers.indexOf(_loc9_);
               if(_loc10_ != -1)
               {
                  renderers.splice(_loc10_,1);
                  removeChild(DisplayObject(_loc9_));
                  this.createAbilitySlot(param1);
               }
            }
         }
         else
         {
            this.createAbilitySlot(param1);
         }
         super.as_addEquipmentSlot(param1,param2,param3,param4,param5,param6,param7,param8,0);
      }
      
      public function as_addRoleAbilitySlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:String) : void
      {
         var _loc10_:int = 0;
         var _loc9_:IConsumablesButton = renderers[param1];
         if(_loc9_ != null)
         {
            if(!(_loc9_ is HBRoleAbilityButton))
            {
               _loc10_ = renderers.indexOf(_loc9_);
               if(_loc10_ != -1)
               {
                  renderers.splice(_loc10_,1);
                  removeChild(DisplayObject(_loc9_));
                  this.createRoleAbilitySlot(param1);
               }
            }
         }
         else
         {
            this.createRoleAbilitySlot(param1);
         }
         super.as_addEquipmentSlot(param1,param2,param3,param4,param5,param6,param7,param8,0);
      }
      
      public function as_addPassiveAbilitySlot(param1:int, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:HBPassiveAbility = this._passiveAbilities[param1] as HBPassiveAbility;
         if(!_loc5_)
         {
            _loc5_ = this._factory.getComponent(Linkages.HB_PASSIVE_ABILITY,HBPassiveAbility);
            this._passiveAbilities[param1] = _loc5_;
            addChild(DisplayObject(_loc5_));
         }
         _loc5_.setTooltip(param4);
         _loc5_.setIcon(param2);
         _loc5_.setState(param3);
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      public function as_setShellInfinity(param1:int, param2:Boolean) : void
      {
         var _loc3_:HBShellButton = getRendererBySlotIdx(param1) as HBShellButton;
         if(_loc3_)
         {
            _loc3_.setInfinity(param2);
         }
      }
      
      public function as_updateAbility(param1:int, param2:int, param3:Number, param4:Number) : void
      {
         var _loc5_:HBAbilityButton = getRendererBySlotIdx(param1) as HBAbilityButton;
         if(_loc5_)
         {
            _loc5_.setStage(param2);
            _loc5_.setCoolDownTime(param3,param4,param4 - param3);
         }
      }
      
      public function as_updatePassiveAbility(param1:int, param2:String, param3:String) : void
      {
         var _loc4_:HBPassiveAbility = this._passiveAbilities[param1] as HBPassiveAbility;
         if(_loc4_)
         {
            _loc4_.setTooltip(param3);
            _loc4_.setState(param2);
         }
      }
      
      public function as_setRoleAbilityProgress(param1:int, param2:Number) : void
      {
         var _loc3_:HBRoleAbilityButton = HBRoleAbilityButton(renderers[param1]);
         if(_loc3_ != null)
         {
            _loc3_.setProgress(param2);
         }
      }
      
      public function as_setRoleAbilityTooltip(param1:int, param2:String) : void
      {
         var _loc3_:HBRoleAbilityButton = HBRoleAbilityButton(renderers[param1]);
         if(_loc3_ != null)
         {
            _loc3_.tooltipStr = param2;
         }
      }
      
      private function createAbilitySlot(param1:int) : void
      {
         var _loc2_:HBAbilityButton = this._factory.getComponent(Linkages.HB_ABILITY_BUTTON,HBAbilityButton);
         renderers[param1] = _loc2_;
         addChild(_loc2_);
      }
      
      private function createRoleAbilitySlot(param1:int) : void
      {
         var _loc2_:HBRoleAbilityButton = this._factory.getComponent(Linkages.HB_ROLE_ABILITY_BUTTON,HBRoleAbilityButton);
         renderers[param1] = _loc2_;
         addChild(_loc2_);
      }
   }
}
