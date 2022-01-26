package net.wg.gui.lobby.reservesPanel.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ReserveTypesUIWithFill;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.events.DeviceEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.modulesPanel.data.ModuleVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ReserveFittingItemRenderer extends TableRenderer
   {
       
      
      public var moduleType:ReserveTypesUIWithFill;
      
      public var removeButton:ISoundButtonEx;
      
      public var levelIcon:MovieClip;
      
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
         this.paramValuesField.htmlText = this._moduleData.paramValues;
         this.paramNamesField.htmlText = this._moduleData.paramNames;
         this.countField.htmlText = this._moduleData.count;
         App.utils.commons.updateTextFieldSize(this.paramValuesField,false,true);
         App.utils.commons.updateTextFieldSize(this.paramNamesField,false,true);
         this.removeButton.visible = this.setField.visible = this._moduleData.isSelected;
         if(this._moduleData.isSelected)
         {
            this.removeButton.label = MENU.FORTIFICATION_UNLOADNAME;
            this.removeButton.validateNow();
            this.setField.htmlText = MENU.FORTIFICATION_INSTALLNAME;
         }
         this.enabled = !this._moduleData.disabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseEnabled = true;
         mouseChildren = true;
         buttonMode = enabled;
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
