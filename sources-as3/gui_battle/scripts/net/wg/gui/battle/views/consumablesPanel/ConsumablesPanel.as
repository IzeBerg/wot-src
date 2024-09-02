package net.wg.gui.battle.views.consumablesPanel
{
   import fl.motion.easing.Circular;
   import flash.display.DisplayObject;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
   import net.wg.gui.battle.battleRoyale.views.components.RespawnButton.BattleRoyaleRespawnButton;
   import net.wg.gui.battle.comp7.views.consumablesPanel.Comp7ConsumableButton;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
   import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleOptionalDeviceButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesPanel;
   import net.wg.infrastructure.base.meta.impl.ConsumablesPanelMeta;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.motion.Tween;
   
   public class ConsumablesPanel extends ConsumablesPanelMeta implements IConsumablesPanel, IStageSizeDependComponent
   {
      
      private static const CONSUMABLES_PANEL_Y_OFFSET:int = 58;
      
      private static const ITEM_WIDTH_PADDING:int = 57;
      
      private static const ITEM_WIDTH_SHORT_PADDING:int = 49;
      
      private static const DATA_SLOT_IDX:int = 0;
      
      private static const KEYCODE_IDX:int = 1;
      
      private static const KEY_IDX:int = 2;
      
      private static const BATTLE_ROYALE_GROUP_GAP:int = 13;
      
      private static const BATTLE_ROYALE_GROUP_INDEXES:Vector.<uint> = new <uint>[2,6];
      
      private static const EPIC_BATTLE_GROUP_GAP:int = 10;
      
      private static const EPIC_BATTLE_GROUP_INDEXES:Vector.<uint> = new <uint>[6,9];
      
      private static const SHOW_TWEEN_DURATION:int = 300;
      
      private static const HIDE_OFFSET:int = 15;
      
      protected static const INVALIDATE_DRAW_LAYOUT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      protected static const INVALIDATE_POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const OPTIONAL_DEVICE_BUTTON_EMPTY_MSG:String = "BattleOptionalDeviceButton empty at idx: ";
       
      
      private var _stageWidth:int = 0;
      
      private var _stageHeight:int = 0;
      
      private var _renderers:Vector.<IConsumablesButton>;
      
      private var _shellCurrentIdx:int = -1;
      
      private var _shellNextIdx:int = -1;
      
      private var _isReplay:Boolean = false;
      
      private var _isObserver:Boolean = false;
      
      private var _settings:Vector.<ConsumablesPanelSettings>;
      
      private var _bottomPadding:int = 0;
      
      private var _itemsPadding:int = 0;
      
      private var _groupsGap:int = 0;
      
      private var _customIndexGap:Vector.<uint>;
      
      private var _settingsId:int = -1;
      
      private var _equipmentButtonLinkage:String = "";
      
      private var _basePanelWidth:int = 0;
      
      private var _shellButtonLinkage:String = "";
      
      private var _tween:Tween = null;
      
      private var _classFactory:IClassFactory;
      
      public function ConsumablesPanel()
      {
         this._renderers = new <IConsumablesButton>[null,null,null,null,null,null,null,null,null,null,null,null];
         this._settings = new Vector.<ConsumablesPanelSettings>();
         this._customIndexGap = new Vector.<uint>(0);
         this._classFactory = App.utils.classFactory;
         super();
         App.stageSizeMgr.register(this);
         var _loc1_:int = getItemWidthPadding(App.appWidth);
         this._settings[CONSUMABLES_PANEL_SETTINGS.DEFAULT_SETTINGS_ID] = new ConsumablesPanelSettings(CONSUMABLES_PANEL_Y_OFFSET,_loc1_,Linkages.EQUIPMENT_BUTTON,Linkages.SHELL_BUTTON_BATTLE,0,null);
         this._settings[CONSUMABLES_PANEL_SETTINGS.BATTLE_ROYALE_SETTINGS_ID] = new ConsumablesPanelSettings(CONSUMABLES_PANEL_Y_OFFSET,ITEM_WIDTH_PADDING,Linkages.BATTLE_ROYALE_CONSUMABLE_BUTTON,Linkages.SHELL_BUTTON_BATTLE,BATTLE_ROYALE_GROUP_GAP,BATTLE_ROYALE_GROUP_INDEXES);
         this._settings[CONSUMABLES_PANEL_SETTINGS.MAPS_TRAINING_SETTINGS_ID] = new ConsumablesPanelSettings(CONSUMABLES_PANEL_Y_OFFSET,_loc1_,Linkages.EQUIPMENT_BUTTON,Linkages.MAPS_TRAINING_SHELL_BUTTON,0,null);
         this._settings[CONSUMABLES_PANEL_SETTINGS.EPIC_BATTLE_SETTINGS_ID] = new ConsumablesPanelSettings(CONSUMABLES_PANEL_Y_OFFSET,_loc1_,Linkages.EPIC_BATTLE_CONSUMABLE_BUTTON,Linkages.SHELL_BUTTON_BATTLE,EPIC_BATTLE_GROUP_GAP,EPIC_BATTLE_GROUP_INDEXES);
      }
      
      private static function getItemWidthPadding(param1:int) : int
      {
         return param1 < StageSizeBoundaries.WIDTH_1280 ? int(ITEM_WIDTH_SHORT_PADDING) : int(ITEM_WIDTH_PADDING);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BattleButton = null;
         var _loc2_:ConsumablesPanelSettings = null;
         for each(_loc1_ in this._renderers)
         {
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
         }
         this._renderers.splice(0,this._renderers.length);
         this._renderers = null;
         for each(_loc2_ in this._settings)
         {
            _loc2_.dispose();
         }
         this._settings.splice(0,this._settings.length);
         this._settings = null;
         this._customIndexGap.splice(0,this._customIndexGap.length);
         this._customIndexGap = null;
         this._classFactory = null;
         this.clearTween();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_DRAW_LAYOUT))
         {
            this.drawLayout();
            invalidate(INVALIDATE_POSITION);
         }
         if(isInvalid(INVALIDATE_POSITION))
         {
            this.updatePosition();
         }
      }
      
      override protected function setKeysToSlots(param1:Array) : void
      {
         var _loc2_:IConsumablesButton = null;
         var _loc3_:Array = null;
         for each(_loc3_ in param1)
         {
            _loc2_ = this.getRendererBySlotIdx(_loc3_[DATA_SLOT_IDX]);
            if(_loc2_)
            {
               _loc2_.key = _loc3_[KEY_IDX];
               _loc2_.consumablesVO.keyCode = _loc3_[KEYCODE_IDX];
            }
         }
      }
      
      override protected function reset(param1:Array) : void
      {
         var _loc3_:IConsumablesButton = null;
         var _loc4_:int = 0;
         var _loc5_:IConsumablesButton = null;
         var _loc6_:int = 0;
         this._shellCurrentIdx = -1;
         this._shellNextIdx = -1;
         var _loc2_:int = Boolean(param1) ? int(param1.length) : int(0);
         if(_loc2_ == 0)
         {
            for each(_loc3_ in this._renderers)
            {
               if(_loc3_ != null)
               {
                  removeChild(DisplayObject(_loc3_));
                  _loc3_.dispose();
               }
            }
            this._renderers.splice(0,this._renderers.length);
            this._renderers = new <IConsumablesButton>[null,null,null,null,null,null,null,null,null,null,null,null];
         }
         else
         {
            _loc4_ = 0;
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc4_ = param1[_loc6_];
               _loc5_ = this.getRendererBySlotIdx(_loc4_);
               if(_loc5_ != null)
               {
                  removeChild(DisplayObject(_loc5_));
                  _loc5_.dispose();
                  this._renderers[_loc4_] = null;
               }
               _loc6_++;
            }
         }
      }
      
      override protected function updateVisibility() : void
      {
         super.updateVisibility();
         if(visible)
         {
            onPanelShownS();
         }
         else
         {
            onPanelHiddenS();
         }
      }
      
      public function as_addEquipmentSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:String, param9:int) : void
      {
         this._equipmentButtonLinkage = this._settings[this._settingsId].equipmentButtonLinkage;
         this.addEquipmentSlot(param1,param2,param3,param4,param5,param6,param7,param8,param9);
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      public function as_addOptionalDeviceSlot(param1:int, param2:Number, param3:String, param4:String, param5:Boolean, param6:int, param7:Boolean) : void
      {
         var _loc8_:IBattleOptionalDeviceButton = null;
         if(this._renderers[param1] == null)
         {
            _loc8_ = this._classFactory.getComponent(Linkages.OPTIONAL_DEVICE_BUTTON,IBattleOptionalDeviceButton);
            this._renderers[param1] = _loc8_;
            addChild(DisplayObject(_loc8_));
         }
         else
         {
            _loc8_ = IBattleOptionalDeviceButton(this.getRendererBySlotIdx(param1));
         }
         _loc8_.icon = param3;
         _loc8_.tooltipStr = param4;
         _loc8_.isTooltipSpecial = param5;
         _loc8_.setUsed(param7,true);
         _loc8_.intCD = param6;
         _loc8_.setCoolDownTime(param2,param2,0);
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      public function as_addRespawnSlot(param1:int, param2:Number, param3:Number, param4:int, param5:String, param6:Boolean, param7:Boolean) : void
      {
         var _loc8_:BattleRoyaleRespawnButton = null;
         var _loc9_:ConsumablesVO = null;
         if(this._renderers[param1] == null)
         {
            _loc8_ = this._classFactory.getComponent("BattleRoyaleRespawnButtonUI",BattleRoyaleRespawnButton);
            this._renderers[param1] = _loc8_;
            addChild(_loc8_);
         }
         else
         {
            _loc8_ = this.getRendererBySlotIdx(param1) as BattleRoyaleRespawnButton;
         }
         if(_loc8_)
         {
            _loc9_ = _loc8_.consumablesVO;
            _loc9_.keyCode = param2;
            _loc9_.idx = param1;
            _loc8_.isReplay = this._isReplay;
            _loc8_.tooltipStr = param5;
            _loc8_.isTooltipSpecial = param6;
            _loc8_.key = param3;
            _loc8_.quantity = param4;
            _loc8_.isAvailable = param7;
            _loc8_.addClickCallBack(this);
            invalidate(INVALIDATE_DRAW_LAYOUT);
         }
      }
      
      public function as_addRoleSkillSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:String, param9:int) : void
      {
         this._equipmentButtonLinkage = Linkages.COMP7_CONSUMABLE_BUTTON;
         this.addEquipmentSlot(param1,param2,param3,param4,param5,param6,param7,param8,param9);
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      public function as_addShellSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:String, param7:String, param8:String, param9:Boolean) : void
      {
         var _loc10_:IBattleShellButton = null;
         var _loc11_:ConsumablesVO = null;
         if(this._renderers[param1] == null)
         {
            _loc10_ = this.createShellButton();
            this._renderers[param1] = _loc10_;
            addChild(DisplayObject(_loc10_));
         }
         else
         {
            _loc10_ = this.getRendererBySlotIdx(param1) as IBattleShellButton;
         }
         if(_loc10_)
         {
            _loc11_ = _loc10_.consumablesVO;
            _loc11_.shellIconPath = param6;
            _loc11_.noShellIconPath = param7;
            _loc11_.keyCode = param2;
            _loc11_.idx = param1;
            _loc10_.tooltipStr = param8;
            _loc10_.setInfinity(param9);
            _loc10_.setQuantity(param4,true);
            _loc10_.key = param3;
            _loc10_.addClickCallBack(this);
         }
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      public function as_handleAsObserver() : void
      {
         this._isObserver = true;
      }
      
      public function as_handleAsReplay() : void
      {
         this._isReplay = true;
      }
      
      public function as_hideGlow(param1:int) : void
      {
         var _loc2_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc2_)
         {
            _loc2_.hideGlow();
         }
      }
      
      public function as_isVisible() : Boolean
      {
         return visible;
      }
      
      public function as_setCoolDownPosAsPercent(param1:int, param2:Number) : void
      {
         var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc3_)
         {
            if(this.getRenderer(param1) !== Linkages.SHELL_BUTTON_BATTLE || this._shellCurrentIdx >= 0 && this._shellCurrentIdx == param1)
            {
               _loc3_.setCoolDownPosAsPercent(param2);
            }
         }
      }
      
      public function as_setCoolDownTime(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc5_)
         {
            _loc5_.setCoolDownTime(param2,param3,param4);
         }
      }
      
      public function as_setCoolDownTimeSnapshot(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc5_)
         {
            _loc5_.setTimerSnapshot(param2,param3);
         }
      }
      
      public function as_setCurrentShell(param1:int) : void
      {
         var _loc2_:IBattleShellButton = null;
         if(this._shellNextIdx == param1)
         {
            _loc2_ = this.getRendererBySlotIdx(this._shellNextIdx) as BattleShellButton;
            if(_loc2_)
            {
               _loc2_.setNext(false,true);
            }
            this._shellNextIdx = -1;
         }
         if(this._shellCurrentIdx >= 0)
         {
            _loc2_ = this.getRendererBySlotIdx(this._shellCurrentIdx) as BattleShellButton;
            if(_loc2_)
            {
               _loc2_.clearCoolDownTime();
               _loc2_.setCurrent(false,true);
            }
         }
         _loc2_ = this.getRendererBySlotIdx(param1) as BattleShellButton;
         if(_loc2_ && _loc2_.enabled && !_loc2_.empty)
         {
            this._shellCurrentIdx = param1;
            _loc2_.setCurrent(true);
         }
      }
      
      public function as_setEquipmentActivated(param1:int, param2:Boolean) : void
      {
         var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc3_)
         {
            _loc3_.activated = param2;
         }
      }
      
      public function as_setIdleEnabledGlow(param1:int, param2:Boolean) : void
      {
         var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc3_)
         {
            _loc3_.setIdleEnabledGlow(param2);
         }
      }
      
      public function as_setGlow(param1:int, param2:int) : void
      {
         var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc3_)
         {
            _loc3_.showGlow(param2);
         }
      }
      
      public function as_setItemQuantityInSlot(param1:int, param2:int) : void
      {
         var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc3_)
         {
            _loc3_.quantity = param2;
         }
      }
      
      public function as_setItemTimeQuantityInSlot(param1:int, param2:int, param3:Number, param4:Number, param5:int) : void
      {
         var _loc6_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc6_)
         {
            _loc6_.quantity = param2;
            _loc6_.setCoolDownTime(param3,param4,param4 - param3,param5);
         }
      }
      
      public function as_setNextShell(param1:int) : void
      {
         var _loc2_:IBattleShellButton = null;
         if(param1 == this._shellNextIdx)
         {
            return;
         }
         if(this._shellNextIdx >= 0)
         {
            _loc2_ = this.getRendererBySlotIdx(this._shellNextIdx) as BattleShellButton;
            if(_loc2_)
            {
               _loc2_.setNext(false,true);
            }
         }
         _loc2_ = this.getRendererBySlotIdx(param1) as BattleShellButton;
         if(_loc2_ && _loc2_.enabled && !_loc2_.empty)
         {
            this._shellNextIdx = param1;
            _loc2_.setNext(true);
         }
      }
      
      public function as_setOptionalDeviceUsed(param1:int, param2:Boolean) : void
      {
         var _loc3_:BattleOptionalDeviceButton = this.getRendererBySlotIdx(param1) as BattleOptionalDeviceButton;
         if(_loc3_)
         {
            _loc3_.setUsed(param2);
         }
         else
         {
            DebugUtils.LOG_ERROR(OPTIONAL_DEVICE_BUTTON_EMPTY_MSG + param1);
         }
      }
      
      public function as_setPanelSettings(param1:int) : void
      {
         if(this._settingsId == param1)
         {
            return;
         }
         this._settingsId = param1;
         var _loc2_:ConsumablesPanelSettings = this._settings[this._settingsId];
         this._bottomPadding = _loc2_.bottomPadding;
         this._itemsPadding = _loc2_.itemPadding;
         this._groupsGap = _loc2_.groupGap;
         this._customIndexGap.splice(0,this._customIndexGap.length);
         this._customIndexGap = _loc2_.customIndexGap;
         this._shellButtonLinkage = _loc2_.shellButtonLinkage;
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      public function as_setRespawnSlotQuantity(param1:int, param2:int) : void
      {
         var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc3_)
         {
            _loc3_.quantity = param2;
         }
      }
      
      public function as_setRespawnSlotState(param1:int, param2:Boolean) : void
      {
         var _loc3_:BattleRoyaleRespawnButton = this.getRendererBySlotIdx(param1) as BattleRoyaleRespawnButton;
         if(_loc3_)
         {
            _loc3_.isAvailable = param2;
         }
      }
      
      public function as_setRoleSkillSlotCounter(param1:int, param2:int) : void
      {
         var _loc3_:Comp7ConsumableButton = Comp7ConsumableButton(this.getRendererBySlotIdx(param1));
         _loc3_.setCounter(param2);
      }
      
      public function as_setRoleSkillSlotProgress(param1:int, param2:int, param3:Number) : void
      {
         var _loc4_:Comp7ConsumableButton = Comp7ConsumableButton(this.getRendererBySlotIdx(param1));
         _loc4_.setProgress(param2,param3);
      }
      
      public function as_setSPGShotResult(param1:int, param2:int) : void
      {
         var _loc3_:IBattleShellButton = IBattleShellButton(this.getRendererBySlotIdx(param1));
         if(_loc3_)
         {
            _loc3_.setSpgShotResult(param2);
         }
      }
      
      public function as_showEquipmentSlots(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         var _loc4_:IConsumablesButton = null;
         var _loc3_:int = this._renderers.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = this.getRenderer(_loc5_);
            if(_loc4_ is BattleEquipmentButton)
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
      
      public function as_updateTooltip(param1:int, param2:String) : void
      {
         var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
         if(_loc3_)
         {
            _loc3_.tooltipStr = param2;
         }
      }
      
      public function getRendererBySlotIdx(param1:int) : IConsumablesButton
      {
         return this._renderers[param1];
      }
      
      public function hide(param1:Boolean) : void
      {
         var _loc2_:Number = NaN;
         this.clearTween();
         if(param1)
         {
            this.updatePosition();
            _loc2_ = y - HIDE_OFFSET;
            this._tween = new Tween(SHOW_TWEEN_DURATION,this,{
               "alpha":0,
               "y":_loc2_
            },{
               "ease":Circular.easeIn,
               "onComplete":this.onHideTweenCompleted
            });
         }
         else
         {
            visible = false;
            alpha = 0;
         }
         onPanelHiddenS();
      }
      
      public function onButtonClick(param1:Object) : void
      {
         if(!this._isObserver)
         {
            onClickedToSlotS(param1.consumablesVO.keyCode,param1.consumablesVO.idx);
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         if(this._settingsId !== Values.DEFAULT_INT)
         {
            this._itemsPadding = getItemWidthPadding(param1);
            this._settings[this._settingsId].itemPadding = this._itemsPadding;
            invalidate(INVALIDATE_DRAW_LAYOUT);
         }
      }
      
      public function show(param1:Boolean) : void
      {
         var _loc2_:Number = NaN;
         this.clearTween();
         visible = true;
         if(param1)
         {
            this.updatePosition();
            _loc2_ = y;
            y += HIDE_OFFSET;
            this._tween = new Tween(SHOW_TWEEN_DURATION,this,{
               "alpha":1,
               "y":_loc2_
            },{
               "ease":Circular.easeOut,
               "onComplete":this.onShowTweenCompleted
            });
         }
         else
         {
            alpha = 1;
         }
         onPanelShownS();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         invalidate(INVALIDATE_POSITION);
      }
      
      protected function createEquipmentButton() : IConsumablesButton
      {
         return this._classFactory.getComponent(this._equipmentButtonLinkage,IConsumablesButton);
      }
      
      protected function createShellButton() : IBattleShellButton
      {
         return this._classFactory.getComponent(this._shellButtonLinkage,IBattleShellButton);
      }
      
      protected function drawLayout() : void
      {
         var _loc3_:IConsumablesButton = null;
         var _loc1_:int = this._renderers.length;
         var _loc2_:int = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_)
         {
            if(this._customIndexGap.indexOf(_loc4_) != -1)
            {
               _loc2_ += this._groupsGap;
            }
            if(this._renderers[_loc4_] != null)
            {
               _loc3_ = this.getRendererBySlotIdx(_loc4_);
               if(_loc3_ && _loc3_.visible)
               {
                  _loc3_.x = _loc2_;
                  _loc2_ += this._itemsPadding;
               }
            }
            _loc4_++;
         }
         this._basePanelWidth = _loc2_;
      }
      
      protected function getRenderer(param1:int) : IConsumablesButton
      {
         return IConsumablesButton(this._renderers[param1]);
      }
      
      protected function updatePosition() : void
      {
         if(this._tween)
         {
            this._tween.onComplete(this._tween);
         }
         x = this._stageWidth - this._basePanelWidth >> 1;
         y = this._stageHeight - this._bottomPadding;
         dispatchEvent(new ConsumablesPanelEvent(ConsumablesPanelEvent.UPDATE_POSITION));
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function onShowTweenCompleted(param1:Tween = null) : void
      {
         this.clearTween();
         alpha = 1;
      }
      
      private function onHideTweenCompleted(param1:Tween = null) : void
      {
         this.clearTween();
         visible = false;
         alpha = 0;
      }
      
      private function addEquipmentSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:String, param9:int) : void
      {
         var _loc10_:IConsumablesButton = null;
         if(this._renderers[param1] == null)
         {
            _loc10_ = this.createEquipmentButton();
            this._renderers[param1] = _loc10_;
            addChild(DisplayObject(_loc10_));
         }
         else
         {
            _loc10_ = this.getRendererBySlotIdx(param1);
         }
         var _loc11_:ConsumablesVO = _loc10_.consumablesVO;
         _loc11_.keyCode = param2;
         _loc11_.idx = param1;
         _loc10_.isReplay = this._isReplay;
         _loc10_.icon = param7;
         _loc10_.tooltipStr = param8;
         _loc10_.key = param3;
         _loc10_.addClickCallBack(this);
         _loc10_.setCoolDownTime(param5,param6,param6 - param5,param9);
         _loc10_.quantity = param4;
      }
      
      public function get isReplay() : Boolean
      {
         return this._isReplay;
      }
      
      public function get panelWidth() : Number
      {
         return this.x + this._basePanelWidth;
      }
   }
}

import net.wg.infrastructure.interfaces.entity.IDisposable;

class ConsumablesPanelSettings implements IDisposable
{
    
   
   public var bottomPadding:int = 0;
   
   public var itemPadding:int = 0;
   
   public var groupGap:int = 0;
   
   public var customIndexGap:Vector.<uint>;
   
   public var equipmentButtonLinkage:String = "";
   
   public var shellButtonLinkage:String = "";
   
   private var _disposed:Boolean = false;
   
   function ConsumablesPanelSettings(param1:int, param2:int, param3:String, param4:String, param5:int = 0, param6:Vector.<uint> = null)
   {
      this.customIndexGap = new Vector.<uint>(0);
      super();
      this.bottomPadding = param1;
      this.itemPadding = param2;
      this.groupGap = param5;
      if(param6 != null)
      {
         this.customIndexGap = param6;
      }
      this.equipmentButtonLinkage = param3;
      this.shellButtonLinkage = param4;
   }
   
   public final function dispose() : void
   {
      this._disposed = true;
      this.onDispose();
   }
   
   public function isDisposed() : Boolean
   {
      return this._disposed;
   }
   
   protected function onDispose() : void
   {
      this.customIndexGap.splice(0,this.customIndexGap.length);
      this.customIndexGap = null;
   }
}
