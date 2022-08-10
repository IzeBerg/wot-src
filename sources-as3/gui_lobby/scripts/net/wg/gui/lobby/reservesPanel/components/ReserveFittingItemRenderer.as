package net.wg.gui.lobby.reservesPanel.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.gui.components.advanced.ReserveTypesUIWithFill;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.events.DeviceEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.modulesPanel.data.ModuleVO;
   import net.wg.gui.lobby.modulesPanel.data.ParamsItemVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ReserveFittingItemRenderer extends TableRenderer
   {
      
      private static const PARAMS_VERTICAL_GAP:int = 3;
       
      
      public var moduleType:ReserveTypesUIWithFill;
      
      public var removeButton:ISoundButtonEx;
      
      public var levelIcon:MovieClip;
      
      public var paramsContainer:MovieClip;
      
      public var paramValuesField:TextField;
      
      public var paramNamesField:TextField;
      
      public var setField:TextField;
      
      public var countField:TextField;
      
      private var _moduleData:ModuleVO;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function ReserveFittingItemRenderer()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._moduleData = ModuleVO(param1);
         invalidateData();
         this._tooltipMgr.hide();
      }
      
      override protected function onDispose() : void
      {
         this.moduleType.dispose();
         this.moduleType = null;
         this.removeButton.dispose();
         this.removeButton = null;
         this.levelIcon = null;
         this.paramsContainer = null;
         this.paramValuesField = null;
         this.paramNamesField = null;
         this.setField = null;
         this.countField = null;
         this._moduleData = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.removeButton.removeEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         preventAutoSizingBg = true;
         rendererBg.mouseEnabled = rendererBg.mouseChildren = false;
         this.moduleType.mouseEnabled = this.moduleType.mouseChildren = false;
         this.removeButton.focusTarget = this;
         this.removeButton.addEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.levelIcon.mouseEnabled = this.levelIcon.mouseChildren = false;
         this.paramsContainer.mouseEnabled = this.paramsContainer.mouseChildren = false;
         this.paramValuesField.mouseEnabled = false;
         this.paramNamesField.mouseEnabled = false;
         this.setField.mouseEnabled = false;
         this.countField.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            this.setup();
         }
         super.draw();
      }
      
      protected function setup() : void
      {
         if(this._moduleData == null)
         {
            return;
         }
         var _loc1_:int = this._moduleData.level;
         var _loc2_:String = this._moduleData.moduleLabel + (_loc1_ > ReserveTypesUIWithFill.LEVELS_WITHOUT_GLOW ? ReserveTypesUIWithFill.GLOW_BIG_ENDING : ReserveTypesUIWithFill.NO_GLOW_BIG_ENDING);
         this.moduleType.setModuleTypeIcon(_loc2_);
         this.levelIcon.gotoAndStop(_loc1_);
         this.countField.htmlText = this._moduleData.count;
         this.removeButton.visible = this.setField.visible = this._moduleData.isSelected;
         if(this._moduleData.isSelected)
         {
            this.removeButton.label = MENU.FORTIFICATION_UNLOADNAME;
            this.removeButton.validateNow();
            this.setField.htmlText = MENU.FORTIFICATION_INSTALLNAME;
         }
         this.setParamsItems();
         this.enabled = !this._moduleData.disabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseEnabled = true;
         mouseChildren = true;
         buttonMode = enabled;
      }
      
      private function setParamsItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ReserveParamsItemRenderer = null;
         var _loc3_:ParamsItemVO = null;
         if(this._moduleData.showExtendedParams)
         {
            _loc1_ = 0;
            while(this.paramsContainer.numChildren)
            {
               this.paramsContainer.removeChildAt(0);
            }
            for each(_loc3_ in this._moduleData.paramsItems)
            {
               _loc2_ = App.utils.classFactory.getComponent(FITTING_TYPES.RESERVE_PARAMS_ITEM_RENDERER,ReserveParamsItemRenderer);
               _loc2_.setData(_loc3_.paramValue,_loc3_.paramName);
               _loc2_.y = _loc1_;
               this.paramsContainer.addChild(_loc2_);
               _loc1_ += Math.round(_loc2_.height - PARAMS_VERTICAL_GAP);
               this.paramsContainer.y = Math.round(rendererBg.height / 2 - this.paramsContainer.height / 2);
            }
         }
         else
         {
            if(this._moduleData.paramsItems.length > 0)
            {
               this.paramValuesField.htmlText = this._moduleData.paramsItems[0].paramValue;
               this.paramNamesField.htmlText = this._moduleData.paramsItems[0].paramName;
            }
            App.utils.commons.updateTextFieldSize(this.paramValuesField,false,true);
            App.utils.commons.updateTextFieldSize(this.paramNamesField,false,true);
         }
         this.paramsContainer.visible = this._moduleData.showExtendedParams;
         this.paramValuesField.visible = this.paramNamesField.visible = !this._moduleData.showExtendedParams;
      }
      
      private function onRemoveButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_REMOVE,this._moduleData.id));
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(this._moduleData.tooltipType,null,this._moduleData.id,this._moduleData.slotIndex);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
