package net.wg.gui.battle.halloween.consumablesPanel
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import net.wg.infrastructure.base.meta.IHWConsumablesPanelMeta;
   import net.wg.infrastructure.base.meta.impl.HWConsumablesPanelMeta;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.StageSizeBoundaries;
   
   public class HWConsumablesPanel extends HWConsumablesPanelMeta implements IHWConsumablesPanelMeta
   {
      
      private static const DIVIDER_OFFSET:int = 10;
      
      private static const DIVIDER_OFFSET_SMALL:int = 6;
      
      private static const SLOT_TYPE_AMMO:int = 0;
      
      private static const SLOT_TYPE_ABILITY:int = 1;
      
      private static const SLOT_TYPE_EQUIPMENT:int = 2;
       
      
      private var _factory:IClassFactory;
      
      private var _passiveAbilities:Dictionary;
      
      private var _isSmall:Boolean = false;
      
      public function HWConsumablesPanel()
      {
         this._factory = App.utils.classFactory;
         this._passiveAbilities = new Dictionary();
         super();
      }
      
      private static function getSlotType(param1:DisplayObject) : int
      {
         if(param1 is HWEquipmentButton)
         {
            return SLOT_TYPE_EQUIPMENT;
         }
         if(param1 is HWShellButton)
         {
            return SLOT_TYPE_AMMO;
         }
         return SLOT_TYPE_ABILITY;
      }
      
      override public function as_showEquipmentSlots(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         var _loc4_:IConsumablesButton = null;
         var _loc3_:int = _renderers.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = getRenderer(_loc5_);
            if(_loc4_ is HWEquipmentButton)
            {
               _loc4_.visible = param1;
               _loc2_ = true;
            }
            _loc5_++;
         }
         if(_loc2_)
         {
            invalidate();
         }
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         var _loc3_:Boolean = param1 == StageSizeBoundaries.WIDTH_1024;
         if(this._isSmall != _loc3_)
         {
            this._isSmall = _loc3_;
            invalidate(INVALIDATE_DRAW_LAYOUT);
         }
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
         return this._factory.getComponent(Linkages.HW_EQUIPMENT_BUTTON,HWEquipmentButton);
      }
      
      override protected function createShellButton() : IBattleShellButton
      {
         return this._factory.getComponent(Linkages.HW_SHELL_BUTTON_BATTLE,HWShellButton);
      }
      
      override protected function drawLayout() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc1_:int = _renderers.length;
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
            _loc3_ = this._passiveAbilities[_loc7_] as DisplayObject;
            if(_loc3_)
            {
               _loc8_.push(_loc3_);
            }
            _loc7_++;
         }
         var _loc9_:int = !!this._isSmall ? int(DIVIDER_OFFSET_SMALL) : int(DIVIDER_OFFSET);
         for each(_loc3_ in _loc8_)
         {
            _loc6_ = getSlotType(_loc3_);
            if(_loc3_.visible)
            {
               if(_loc5_ != _loc6_)
               {
                  if(_loc5_ != Values.DEFAULT_INT)
                  {
                     _loc2_ += _loc9_;
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
         var _loc4_:HWPassiveAbility = null;
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
            _loc4_ = this._passiveAbilities[_loc2_] as HWPassiveAbility;
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
         var _loc9_:IConsumablesButton = _renderers[param1];
         if(_loc9_ != null)
         {
            if(!(_loc9_ is HWAbilityButton))
            {
               _loc10_ = _renderers.indexOf(_loc9_);
               if(_loc10_ != -1)
               {
                  _renderers.splice(_loc10_,1);
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
      
      public function as_addPassiveAbilitySlot(param1:int, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:HWPassiveAbility = this._passiveAbilities[param1] as HWPassiveAbility;
         if(!_loc5_)
         {
            _loc5_ = this._factory.getComponent(Linkages.HW_PASSIVE_ABILITY,HWPassiveAbility);
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
         var _loc3_:HWShellButton = getRendererBySlotIdx(param1) as HWShellButton;
         if(_loc3_)
         {
            _loc3_.setInfinity(param2);
         }
      }
      
      public function as_updateAbility(param1:int, param2:int, param3:int, param4:Number, param5:Number) : void
      {
         var _loc6_:HWAbilityButton = getRendererBySlotIdx(param1) as HWAbilityButton;
         if(_loc6_)
         {
            _loc6_.setStage(param2);
            _loc6_.quantity = param3;
            _loc6_.setCoolDownTime(param4,param5,param5 - param4);
         }
      }
      
      public function as_updatePassiveAbility(param1:int, param2:String, param3:String) : void
      {
         var _loc4_:HWPassiveAbility = this._passiveAbilities[param1] as HWPassiveAbility;
         if(_loc4_)
         {
            _loc4_.setTooltip(param3);
            _loc4_.setState(param2);
         }
      }
      
      private function createAbilitySlot(param1:int) : void
      {
         var _loc2_:HWAbilityButton = this._factory.getComponent(Linkages.HW_ABILITY_BUTTON,HWAbilityButton);
         _renderers[param1] = _loc2_;
         addChild(DisplayObject(_loc2_));
      }
   }
}
