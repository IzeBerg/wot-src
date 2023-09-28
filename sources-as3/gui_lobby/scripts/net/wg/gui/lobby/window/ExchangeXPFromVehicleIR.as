package net.wg.gui.lobby.window
{
   import avmplus.getQualifiedClassName;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Constraints;
   import scaleform.gfx.MouseEventEx;
   
   public class ExchangeXPFromVehicleIR extends SoundListItemRenderer
   {
      
      public static const SELECTION_CHANGED:String = "IrSelectionChanged";
      
      private static const SELECTION_INVALIDATE:String = "selInv";
      
      private static const DATA_INVALIDATE:String = "dataInv";
      
      private static const MY_STATE_PREFIXES:Vector.<String> = Vector.<String>(["cbselection_",""]);
       
      
      public var vehicleIcon:UILoaderAlt;
      
      public var vehicleTypeIcon:UILoaderAlt;
      
      public var checkboxVehicle:CheckBox;
      
      public var xpLabel:IconText;
      
      public var vehicleName:TextField;
      
      public var vehicleNation:UILoaderAlt;
      
      public var background:MovieClip;
      
      public var mcGreyAssets:MovieClip;
      
      private var _vehicleData:ExchangeXPVehicleVO;
      
      public function ExchangeXPFromVehicleIR()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._vehicleData = ExchangeXPVehicleVO(param1);
         invalidate(DATA_INVALIDATE);
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
         _toggle = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.xpLabel.textColor = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_XP);
         if(focusIndicator)
         {
            constraints.addElement(focusIndicator.name,focusIndicator,Constraints.ALL);
         }
         constraints.addElement(this.background.name,this.background,Constraints.ALL);
         constraints.addElement(this.mcGreyAssets.name,this.mcGreyAssets,Constraints.LEFT);
         constraints.addElement(this.checkboxVehicle.name,this.checkboxVehicle,Constraints.LEFT);
         this.checkboxVehicle.showLabel = false;
         this.vehicleNation.addEventListener(UILoaderEvent.IOERROR,this.onVehicleNationIOErrorHandler,false,0,true);
         setState(ComponentState.UP);
      }
      
      override protected function onDispose() : void
      {
         this.vehicleNation.removeEventListener(UILoaderEvent.IOERROR,this.onVehicleNationIOErrorHandler);
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this.vehicleTypeIcon.dispose();
         this.vehicleTypeIcon = null;
         this.checkboxVehicle.dispose();
         this.checkboxVehicle = null;
         this.xpLabel.dispose();
         this.xpLabel = null;
         this.vehicleNation.dispose();
         this.vehicleNation = null;
         this._vehicleData = null;
         this.vehicleName = null;
         this.background = null;
         this.mcGreyAssets = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(DATA_INVALIDATE))
         {
            if(this._vehicleData != null)
            {
               this.xpLabel.text = this._vehicleData.xpStrValue;
               this.xpLabel.visible = true;
               this.checkboxVehicle.visible = true;
               this.checkboxVehicle.tabEnabled = false;
               this.vehicleName.visible = true;
               this.vehicleName.htmlText = this._vehicleData.vehicleName;
               this.mcGreyAssets.visible = true;
               this.vehicleIcon.visible = true;
               this.vehicleIcon.source = this._vehicleData.vehicleIco;
               this.vehicleTypeIcon.source = this._vehicleData.vehicleType;
               this.vehicleNation.source = this._vehicleData.nationIco;
               buttonMode = true;
               invalidate(SELECTION_INVALIDATE);
            }
            else
            {
               buttonMode = false;
               this.xpLabel.visible = false;
               this.mcGreyAssets.visible = false;
               this.checkboxVehicle.visible = false;
               this.vehicleName.visible = false;
               this.vehicleIcon.visible = false;
               this.vehicleTypeIcon.source = null;
               this.vehicleNation.source = null;
            }
         }
         if(isInvalid(SELECTION_INVALIDATE))
         {
            if(this._vehicleData != null)
            {
               this.checkboxVehicle.selected = this._vehicleData.isSelectCandidate;
               setState(state);
            }
         }
         super.draw();
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         return this._vehicleData && this._vehicleData.isSelectCandidate ? MY_STATE_PREFIXES : statesDefault;
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         if(focusIndicator)
         {
            constraints.updateElement(focusIndicator.name,focusIndicator);
         }
         constraints.updateElement(this.background.name,this.background);
         constraints.updateElement(this.mcGreyAssets.name,this.mcGreyAssets);
         constraints.updateElement(this.checkboxVehicle.name,this.checkboxVehicle);
      }
      
      private function toggleSelection() : void
      {
         this._vehicleData.isSelectCandidate = !this._vehicleData.isSelectCandidate;
         invalidate(SELECTION_INVALIDATE);
         dispatchEvent(new Event(SELECTION_CHANGED,true));
      }
      
      [Inspectable(defaultValue="",type="string")]
      override public function get data() : Object
      {
         return this._vehicleData;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value == InputValue.KEY_UP)
         {
            if(_loc2_.code == Keyboard.ENTER || _loc2_.code == Keyboard.SPACE)
            {
               this.toggleSelection();
            }
            param1.handled = true;
         }
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         super.handleMouseRelease(param1);
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc3_ == MouseEventEx.LEFT_BUTTON)
         {
            if(App.utils)
            {
               App.utils.asserter.assertNotNull("_vehicleData in ExchangeXPFromVehicleIR" + Errors.CANT_NULL,this.toString());
            }
            this.toggleSelection();
         }
      }
      
      private function onVehicleNationIOErrorHandler(param1:UILoaderEvent) : void
      {
         var _loc2_:String = "Flash :: Couldn\'t Load Nations Icon, " + getQualifiedClassName(this) + ", Row Number = " + index;
         DebugUtils.LOG_ERROR(_loc2_);
      }
   }
}
