package net.wg.gui.lobby.settings.config
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   
   public class ControlsFactory
   {
      
      public static var TYPE_CHECKBOX:String = "Checkbox";
      
      public static var TYPE_SLIDER:String = "Slider";
      
      public static var TYPE_STEP_SLIDER:String = "StepSlider";
      
      public static var TYPE_RANGE_SLIDER:String = "RangeSlider";
      
      public static var TYPE_DROPDOWN:String = "DropDown";
      
      public static var TYPE_BUTTON_BAR:String = "ButtonBar";
      
      public static var TYPE_LABEL:String = "Label";
      
      public static var TYPE_VALUE:String = "Value";
      
      public static var TYPE_KEYINPUT:String = "KeyInput";
      
      public static var TYPE_BUTTON:String = "Button";
      
      private static var _instance:ControlsFactory = null;
       
      
      private var _currentVal:Object = null;
      
      private var _optionsVal:Array = null;
      
      private var _typeVal:String = "";
      
      private var _hasLabelVal:Boolean = false;
      
      private var _hasValueVal:Boolean = false;
      
      private var _isDependOnVal:String = null;
      
      private var _readOnlyVal:Boolean = false;
      
      private var _advancedVal:Boolean = false;
      
      private var _prevValVal:Object = null;
      
      private var _isDataAsSelectedIndexVal:Boolean = false;
      
      private var _defaultVal:Object = null;
      
      private var _isDisposed:Boolean = false;
      
      public function ControlsFactory()
      {
         super();
         App.utils.asserter.assert(!_instance,"Instantiation failed: Use ControlsFactory.getInstance() instead of new.");
      }
      
      public static function get instance() : ControlsFactory
      {
         if(_instance == null)
         {
            _instance = new ControlsFactory();
         }
         return _instance;
      }
      
      public function advanced(param1:Boolean) : ControlsFactory
      {
         this._advancedVal = param1;
         return this;
      }
      
      public function build() : SettingsControlProp
      {
         App.utils.asserter.assert(this._typeVal != Values.EMPTY_STR,"ControlFactory: type of new control is empty.");
         var _loc1_:SettingsControlProp = new SettingsControlProp(this._currentVal,this._optionsVal,this._typeVal,this._hasLabelVal,this._hasValueVal,this._isDependOnVal,this._readOnlyVal,this._advancedVal,this._prevValVal,this._isDataAsSelectedIndexVal,this._defaultVal);
         this.refresh();
         return _loc1_;
      }
      
      public function createControl(param1:String) : ControlsFactory
      {
         this._typeVal = param1;
         return this;
      }
      
      public function current(param1:Object) : ControlsFactory
      {
         this._currentVal = param1;
         return this;
      }
      
      public function hasLabel(param1:Boolean) : ControlsFactory
      {
         this._hasLabelVal = param1;
         return this;
      }
      
      public function hasValue(param1:Boolean) : ControlsFactory
      {
         this._hasValueVal = param1;
         return this;
      }
      
      public function isDataAsSelectedIndex(param1:Boolean) : ControlsFactory
      {
         this._isDataAsSelectedIndexVal = param1;
         return this;
      }
      
      public function isDependOn(param1:String) : ControlsFactory
      {
         this._isDependOnVal = param1;
         return this;
      }
      
      public function options(param1:Array) : ControlsFactory
      {
         this._optionsVal = param1;
         return this;
      }
      
      public function readOnly(param1:Boolean) : ControlsFactory
      {
         this._readOnlyVal = param1;
         return this;
      }
      
      public function type(param1:String) : ControlsFactory
      {
         this._typeVal = param1;
         return this;
      }
      
      private function refresh() : void
      {
         this._currentVal = null;
         App.utils.data.cleanupDynamicObject(this._optionsVal);
         this._optionsVal = null;
         this._typeVal = Values.EMPTY_STR;
         this._hasLabelVal = false;
         this._hasValueVal = false;
         this._isDependOnVal = null;
         this._readOnlyVal = false;
         this._advancedVal = false;
         this._prevValVal = null;
         this._isDataAsSelectedIndexVal = false;
         this._defaultVal = null;
      }
      
      private function verifyIsDisposed() : void
      {
         App.utils.asserter.assert(!this._isDisposed,"ControlsFactory " + Errors.ALREADY_DISPOSED);
      }
      
      public final function dispose() : void
      {
         this.verifyIsDisposed();
         this._isDisposed = true;
         if(this._optionsVal)
         {
            this._optionsVal.splice(0,this._optionsVal.length);
            this._optionsVal = null;
         }
         this._currentVal = null;
         this._prevValVal = null;
         this._defaultVal = null;
         _instance = null;
      }
   }
}
