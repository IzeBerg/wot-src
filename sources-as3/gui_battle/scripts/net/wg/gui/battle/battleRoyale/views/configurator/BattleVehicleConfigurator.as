package net.wg.gui.battle.battleRoyale.views.configurator
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.BattleVehicleConfiguratorVO;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.ChoiceInfoPanelVO;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.ModuleInfoVO;
   import net.wg.gui.battle.views.battleLevelPanel.BattleLevelPanel;
   import net.wg.gui.components.battleRoyale.ModuleConfiguratorEvent;
   import net.wg.gui.components.battleRoyale.VehModuleConfiguratorCmp;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.meta.IBattleVehicleConfiguratorMeta;
   import net.wg.infrastructure.base.meta.impl.BattleVehicleConfiguratorMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class BattleVehicleConfigurator extends BattleVehicleConfiguratorMeta implements IBattleVehicleConfiguratorMeta
   {
      
      private static const SHOW_PANEL_DELAY:int = 400;
      
      private static const ANIM_ALPHA_DURATION:int = 200;
      
      private static const VEHICLE_CONFIGURATOR_HEIGHT:int = 412;
      
      private static const SEPARATOR_OFFSET_Y:int = 29;
      
      private static const PROGRESS_BAR_WIDTH:uint = 790;
      
      private static const HEADER_OFFSET_Y:uint = 15;
      
      private static const MIN_SCREEN_HEIGHT:uint = 768;
      
      private static const LEVEL_PANEL_HEIGHT:uint = 100;
      
      private static const LEVEL_BOTTOM_OFFSET:int = -56 + LEVEL_PANEL_HEIGHT;
      
      private static const VEHTYPE_ICON_RIGHT_MARGIN:int = -24;
      
      private static const TF_BORDER_SIZE:uint = 2;
      
      private static const SEPARATOR_ALPHA:Number = 0.5;
      
      private static const VEH_TYPE_ICON_OFFSET_X:Number = -15;
      
      private static const VEHICLE_TYPE_ICON_HEIGHT:int = 74;
       
      
      public var vehModulesConfigurator:VehModuleConfiguratorCmp = null;
      
      public var vehNameTf:TextField = null;
      
      public var vehTypeIcon:Image = null;
      
      public var choiceInfoPanel:ChoiceInfoPanel = null;
      
      public var separator:MovieClip = null;
      
      public var moduleInfoPanel:ModuleInfoPanel = null;
      
      public var levelPanel:BattleLevelPanel = null;
      
      public var bg:Sprite = null;
      
      public var substrate:Sprite = null;
      
      private var _curOverModuleIntCD:uint = 0;
      
      private var _headerContainer:Sprite;
      
      private var _offsetDependsOnScreenHeight:int = 0;
      
      private var _moduleInfoPanelItem:ModuleInfo = null;
      
      private var _panelTween:Tween = null;
      
      private var _separatorTween:Tween = null;
      
      private var _delayTimer:Timer;
      
      public function BattleVehicleConfigurator()
      {
         this._headerContainer = new Sprite();
         this._delayTimer = new Timer(SHOW_PANEL_DELAY,1);
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         width = param1;
         height = param2;
         this.bg.width = width;
         this.bg.height = height;
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehTypeIcon.addEventListener(Event.CHANGE,this.onVehTypeIconChangeHandler,false,0,true);
         this.vehModulesConfigurator.addEventListener(ModuleConfiguratorEvent.MODULE_OVER,this.onRendererModuleOverHandler);
         this.vehModulesConfigurator.addEventListener(ModuleConfiguratorEvent.MODULE_OUT,this.onRendererModuleOutHandler);
         this.vehModulesConfigurator.addEventListener(Event.RESIZE,this.onModulesConfiguratorResizeHandler,false,0,true);
         this.vehModulesConfigurator.addEventListener(Event.CHANGE,this.onModulesConfiguratorChangeHandler,false,0,true);
         this.choiceInfoPanel.addEventListener(ModuleConfiguratorEvent.MODULE_OVER,this.onChoicePanelModuleOverHandler);
         this.choiceInfoPanel.addEventListener(ModuleConfiguratorEvent.MODULE_OUT,this.onChoicePanelModuleOutHandler);
         this.choiceInfoPanel.addEventListener(ModuleConfiguratorEvent.MODULE_CLICK,this.onChoicePanelModuleClickHandler);
         this._delayTimer.addEventListener(TimerEvent.TIMER,this.onDelayTimerHandler);
      }
      
      override protected function setData(param1:BattleVehicleConfiguratorVO) : void
      {
         this.vehNameTf.text = param1.vehName;
         this.vehTypeIcon.source = param1.vehTypeIcon;
         invalidateSize();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.levelPanel.setProgressBarWidth(PROGRESS_BAR_WIDTH);
         this.vehNameTf.autoSize = TextFieldAutoSize.LEFT;
         this._headerContainer.addChild(this.vehTypeIcon);
         this._headerContainer.addChild(this.vehNameTf);
         addChild(this._headerContainer);
         this.choiceInfoPanel.initSettings(true);
         this.choiceInfoPanel.visible = this.moduleInfoPanel.visible = false;
         this._moduleInfoPanelItem = this.moduleInfoPanel.module;
         this._moduleInfoPanelItem.initSettings(ModuleInfo.TEXT_ORIENTATION_RIGHT,true,0);
         this.separator.alpha = 0;
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.substrate = null;
         this.resetPanelTween();
         this.resetSeparatorTween();
         this._delayTimer.removeEventListener(TimerEvent.TIMER,this.onDelayTimerHandler);
         this._delayTimer.stop();
         this._delayTimer = null;
         this._moduleInfoPanelItem = null;
         this.choiceInfoPanel.removeEventListener(ModuleConfiguratorEvent.MODULE_OVER,this.onChoicePanelModuleOverHandler);
         this.choiceInfoPanel.removeEventListener(ModuleConfiguratorEvent.MODULE_OUT,this.onChoicePanelModuleOutHandler);
         this.choiceInfoPanel.removeEventListener(ModuleConfiguratorEvent.MODULE_CLICK,this.onChoicePanelModuleClickHandler);
         this.choiceInfoPanel.dispose();
         this.choiceInfoPanel = null;
         this.separator = null;
         this.moduleInfoPanel.dispose();
         this.moduleInfoPanel = null;
         this._headerContainer = null;
         this.levelPanel = null;
         this.vehNameTf = null;
         this.vehTypeIcon.removeEventListener(Event.CHANGE,this.onVehTypeIconChangeHandler);
         this.vehTypeIcon.dispose();
         this.vehTypeIcon = null;
         this.vehModulesConfigurator.removeEventListener(ModuleConfiguratorEvent.MODULE_OVER,this.onRendererModuleOverHandler);
         this.vehModulesConfigurator.removeEventListener(ModuleConfiguratorEvent.MODULE_OUT,this.onRendererModuleOutHandler);
         this.vehModulesConfigurator.removeEventListener(Event.RESIZE,this.onModulesConfiguratorResizeHandler);
         this.vehModulesConfigurator.removeEventListener(Event.CHANGE,this.onModulesConfiguratorChangeHandler);
         this.vehModulesConfigurator = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Rectangle = null;
         var _loc4_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._curOverModuleIntCD != 0)
            {
               onModuleMouseOverS(this._curOverModuleIntCD);
               if(this.choiceInfoPanel.isAvailableModule(this._curOverModuleIntCD))
               {
                  if(this.moduleInfoPanel.visible)
                  {
                     this.hidePanelWithCallback(this.moduleInfoPanel,this.showChoiceInfo);
                  }
                  else
                  {
                     this.showChoiceInfo();
                     this.showSeparator();
                  }
               }
               else if(this.choiceInfoPanel.visible)
               {
                  this.hidePanelWithCallback(this.choiceInfoPanel,this.showModuleInfo);
               }
               else
               {
                  this.showModuleInfo();
                  this.showSeparator();
               }
            }
            else if(this.vehModulesConfigurator.availableForSelection)
            {
               if(this.moduleInfoPanel.visible)
               {
                  this.hidePanelWithCallback(this.moduleInfoPanel,this.showChoiceInfo);
               }
               else
               {
                  this.showChoiceInfo();
                  this.showSeparator();
               }
            }
            else
            {
               if(this.moduleInfoPanel.visible)
               {
                  this.hideModuleInfo();
               }
               if(this.choiceInfoPanel.visible)
               {
                  this.hideChoiceInfo();
               }
               this.hideSeparator();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = 3;
            _loc2_ = width >> 1;
            _loc3_ = this.vehModulesConfigurator.getBounds(this.vehModulesConfigurator);
            this._offsetDependsOnScreenHeight = (height - MIN_SCREEN_HEIGHT) / _loc1_;
            this.vehTypeIcon.x = VEH_TYPE_ICON_OFFSET_X;
            this.vehNameTf.x = this.vehTypeIcon.x + this.vehTypeIcon.width + VEHTYPE_ICON_RIGHT_MARGIN | 0;
            this.vehTypeIcon.y = (this.vehNameTf.textHeight - this.vehTypeIcon.height >> 1) + TF_BORDER_SIZE;
            this._headerContainer.x = width - this._headerContainer.width >> 1;
            this._headerContainer.y = HEADER_OFFSET_Y + this._offsetDependsOnScreenHeight | 0;
            this.separator.x = this.choiceInfoPanel.x = this.moduleInfoPanel.x = this.levelPanel.x = _loc2_;
            _loc4_ = Math.min(0,height - 840) >> 1;
            this.levelPanel.y = this._headerContainer.y + VEHICLE_TYPE_ICON_HEIGHT + HEADER_OFFSET_Y + _loc4_;
            this.vehModulesConfigurator.x = (width - _loc3_.width >> 1) - _loc3_.x;
            this.vehModulesConfigurator.y = this.levelPanel.y + LEVEL_BOTTOM_OFFSET + this._offsetDependsOnScreenHeight - _loc4_;
            this.separator.y = this.vehModulesConfigurator.y + VEHICLE_CONFIGURATOR_HEIGHT;
            this.choiceInfoPanel.y = this.moduleInfoPanel.y = this.separator.y + SEPARATOR_OFFSET_Y;
            this.substrate.x = width - this.substrate.width >> 1;
            this.substrate.y = this.separator.y - this.substrate.height | 0;
         }
      }
      
      override protected function updateModuleInfoPanel(param1:ModuleInfoVO) : void
      {
         this._moduleInfoPanelItem.setData(param1);
      }
      
      override protected function updateChoiceInfoPanel(param1:ChoiceInfoPanelVO) : void
      {
         this.choiceInfoPanel.setData(param1);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.vehModulesConfigurator,BATTLE_VIEW_ALIASES.BATTLE_VEH_MODULES_CONFIGURATOR_CMP);
         registerFlashComponentS(this.levelPanel,BATTLE_VIEW_ALIASES.BATTLE_LEVEL_PANEL);
         this.levelPanel.useAnimatedTransitions = true;
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         visible = param1;
      }
      
      private function resetSeparatorTween() : void
      {
         if(this._separatorTween != null)
         {
            this._separatorTween.dispose();
            this._separatorTween = null;
         }
      }
      
      private function showModuleInfo() : void
      {
         this.showPanelWithCallback(this.moduleInfoPanel);
      }
      
      private function hideModuleInfo() : void
      {
         this.hidePanelWithCallback(this.moduleInfoPanel);
      }
      
      private function showChoiceInfo() : void
      {
         this.showPanelWithCallback(this.choiceInfoPanel);
      }
      
      private function hideChoiceInfo() : void
      {
         this.hidePanelWithCallback(this.choiceInfoPanel);
      }
      
      private function resetPanelTween() : void
      {
         if(this._panelTween != null)
         {
            this._panelTween.dispose();
            this._panelTween = null;
         }
      }
      
      private function hidePanelWithCallback(param1:DisplayObject, param2:Function = null) : void
      {
         var item:DisplayObject = param1;
         var callback:Function = param2;
         this.resetPanelTween();
         var duration:int = ANIM_ALPHA_DURATION * item.alpha;
         this._panelTween = new Tween(duration,item,{"alpha":0},{"onComplete":function():void
         {
            item.visible = false;
            if(callback != null)
            {
               callback();
            }
         }});
      }
      
      private function showPanelWithCallback(param1:DisplayObject, param2:Function = null) : void
      {
         this.resetPanelTween();
         var _loc3_:int = ANIM_ALPHA_DURATION * param1.alpha;
         param1.visible = true;
         this._panelTween = new Tween(_loc3_,param1,{"alpha":1},{"onComplete":param2});
      }
      
      private function hideSeparator() : void
      {
         var _loc1_:int = 0;
         this.resetSeparatorTween();
         if(this.separator.alpha > 0)
         {
            _loc1_ = ANIM_ALPHA_DURATION * this.separator.alpha;
            this._separatorTween = new Tween(_loc1_,this.separator,{"alpha":0});
         }
      }
      
      private function showSeparator() : void
      {
         var _loc1_:int = 0;
         this.resetSeparatorTween();
         if(this.separator.alpha < SEPARATOR_ALPHA)
         {
            _loc1_ = ANIM_ALPHA_DURATION * this.separator.alpha;
            this._separatorTween = new Tween(_loc1_,this.separator,{"alpha":SEPARATOR_ALPHA});
         }
      }
      
      private function onModulesConfiguratorChangeHandler(param1:Event) : void
      {
         if(!this.vehModulesConfigurator.availableForSelection)
         {
            this.choiceInfoPanel.resetAvailableItems();
         }
         invalidateState();
         invalidateSize();
      }
      
      private function onDelayTimerHandler(param1:TimerEvent) : void
      {
         invalidateState();
      }
      
      private function onVehTypeIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onModulesConfiguratorResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onRendererModuleOverHandler(param1:ModuleConfiguratorEvent) : void
      {
         this._delayTimer.reset();
         this._delayTimer.start();
         if(param1.columnIdx > ConfiguratorRenderer.START_COLUMN_INDEX)
         {
            this._curOverModuleIntCD = param1.moduleIntCD;
            if(this.choiceInfoPanel.isAvailableModule(this._curOverModuleIntCD))
            {
               this.choiceInfoPanel.makeOverStateModule(this._curOverModuleIntCD);
            }
            param1.stopPropagation();
         }
      }
      
      private function onRendererModuleOutHandler(param1:ModuleConfiguratorEvent) : void
      {
         this._delayTimer.reset();
         this._delayTimer.start();
         if(this.choiceInfoPanel.isAvailableModule(this._curOverModuleIntCD))
         {
            this.choiceInfoPanel.makeOutStateModule();
         }
         this._curOverModuleIntCD = 0;
         param1.stopPropagation();
      }
      
      private function onChoicePanelModuleOverHandler(param1:ModuleConfiguratorEvent) : void
      {
         this.vehModulesConfigurator.makeOverStateModule(param1.moduleIntCD);
      }
      
      private function onChoicePanelModuleOutHandler(param1:ModuleConfiguratorEvent) : void
      {
         this.vehModulesConfigurator.makeOutStateModule();
      }
      
      private function onChoicePanelModuleClickHandler(param1:ModuleConfiguratorEvent) : void
      {
         this.vehModulesConfigurator.selectItem(param1.moduleIntCD);
      }
   }
}
