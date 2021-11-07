package net.wg.gui.lobby.settings
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.interfaces.ISettingsBase;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SettingsViewData;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   
   public class SettingsBaseView extends SettingsNewCountersForm implements IViewStackContent, ISettingsBase
   {
      
      private static const MAX_TOOLTIP_WIDTH:int = 270;
      
      private static const OPTION_DATA_KEY:String = "data";
       
      
      private var _data:SettingsDataVo = null;
      
      private var _viewId:String = "";
      
      private var _headDependedControls:Vector.<String> = null;
      
      private var _toolTipMapping:Dictionary = null;
      
      public function SettingsBaseView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this._data)
         {
            this.setData(this._data);
         }
         this._toolTipMapping = new Dictionary(true);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:DisplayObject = null;
         for(_loc1_ in this._toolTipMapping)
         {
            _loc2_ = DisplayObject(_loc1_);
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onControlClickHandler);
            delete this._toolTipMapping[_loc1_];
         }
         this._toolTipMapping = null;
         this._headDependedControls.splice(0,this._headDependedControls.length);
         this._headDependedControls = null;
         this._data = null;
         this._viewId = null;
         super.onDispose();
      }
      
      override protected function getControlPropsByKey(param1:String) : SettingsControlProp
      {
         if(this._data && this._data[param1])
         {
            return this._data[param1];
         }
         return super.getControlPropsByKey(param1);
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function needDataWithChanges() : Boolean
      {
         return false;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:SettingsViewData = SettingsViewData(param1);
         this._viewId = _loc2_.id;
         this._data = _loc2_.data;
         _loc2_.dispose();
         if(this.initialized)
         {
            this._headDependedControls = new Vector.<String>();
            this.setData(this._data);
         }
      }
      
      public function updateDependentData() : void
      {
      }
      
      protected function registerToolTip(param1:DisplayObject, param2:String) : void
      {
         if(this._toolTipMapping[param1] == undefined)
         {
            param1.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            param1.addEventListener(MouseEvent.CLICK,this.onControlClickHandler);
         }
         this._toolTipMapping[param1] = this.getTooltipID(param2);
      }
      
      protected function getTooltipID(param1:String) : String
      {
         return param1;
      }
      
      protected function getControlIdForToolTipMapping(param1:DisplayObject) : String
      {
         return this._toolTipMapping[param1];
      }
      
      protected function trySetLabel(param1:String, param2:String = "", param3:String = "") : void
      {
         var _loc4_:String = null;
         var _loc5_:LabelControl = null;
         var _loc6_:TextField = null;
         var _loc7_:CheckBox = null;
         if(this._data[param1])
         {
            _loc4_ = Values.EMPTY_STR;
            if(this._data[param1].current != null)
            {
               _loc4_ = SettingsConfigHelper.LOCALIZATION + param2 + param1 + param3;
            }
            if(this._data[param1].hasLabel && this[param1 + SettingsConfigHelper.TYPE_LABEL])
            {
               if(this[param1 + SettingsConfigHelper.TYPE_LABEL] is LabelControl)
               {
                  _loc5_ = this[param1 + SettingsConfigHelper.TYPE_LABEL];
                  _loc5_.text = _loc4_;
                  _loc5_.visible = true;
               }
               else
               {
                  _loc6_ = this[param1 + SettingsConfigHelper.TYPE_LABEL];
                  _loc6_.text = _loc4_;
               }
            }
            else if(this[param1 + SettingsConfigHelper.TYPE_CHECKBOX] && this[param1 + SettingsConfigHelper.TYPE_CHECKBOX].label == Values.EMPTY_STR)
            {
               _loc7_ = this[param1 + SettingsConfigHelper.TYPE_CHECKBOX];
               _loc7_.label = _loc4_;
            }
         }
      }
      
      protected function setData(param1:SettingsDataVo) : void
      {
      }
      
      protected function updateDependedControl(param1:String) : void
      {
      }
      
      protected final function findSelectedIndexForDD(param1:Number, param2:Array) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(param2[_loc5_].hasOwnProperty(OPTION_DATA_KEY) && param1 == param2[_loc5_].data)
            {
               _loc3_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      override public function get viewId() : String
      {
         return this._viewId;
      }
      
      public function get data() : SettingsDataVo
      {
         return this._data;
      }
      
      public function get headDependedControls() : Vector.<String>
      {
         return this._headDependedControls;
      }
      
      private function onControlRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onControlClickHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onControlRollOverHandler(param1:MouseEvent) : void
      {
         var _loc4_:ITooltipProps = null;
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         App.utils.asserter.assertNotNull(_loc2_,"currentTarget" + Errors.CANT_NULL);
         var _loc3_:String = this.getControlIdForToolTipMapping(_loc2_);
         if(_loc3_)
         {
            _loc4_ = App.toolTipMgr.getDefaultTooltipProps();
            _loc4_ = ITooltipProps(_loc4_.clone());
            _loc4_.maxWidth = MAX_TOOLTIP_WIDTH;
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SETTINGS_CONTROL,_loc4_,_loc3_);
         }
      }
   }
}
