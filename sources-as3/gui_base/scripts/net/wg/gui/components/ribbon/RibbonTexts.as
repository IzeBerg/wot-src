package net.wg.gui.components.ribbon
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.ribbon.data.PaddingSettings;
   import net.wg.gui.components.ribbon.data.RibbonSettings;
   import net.wg.gui.components.ribbon.data.RibbonTextSettings;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RibbonTexts extends MovieClip implements IDisposable
   {
      
      private static const VEH_COUNTER_X_PADDING:Number = -17;
      
      private static const VALUE_DEFAULT_WIDTH:Number = 80;
      
      private static const VALUE_DEFAULT_LEFT:Number = 96;
      
      private static const UPDATE_FRAME_LBL:String = "update";
       
      
      public var countVehAnim:MovieClip = null;
      
      public var valueAnim:MovieClip = null;
      
      public var ribbonNameTF:TextField = null;
      
      public var vNameTF:TextField = null;
      
      private var _ribbonSettings:RibbonSettings = null;
      
      private var _countVehiclesTF:TextField = null;
      
      private var _valueTF:TextField = null;
      
      private var _vNameIsVisible:Boolean = false;
      
      private var _valueIsVisible:Boolean = false;
      
      private var _countVehiclesIsVisible:Boolean = false;
      
      private var _vNameValue:String = "";
      
      private var _value:String = "";
      
      private var _countVehicles:String = "";
      
      private var _common:ICommons = null;
      
      private var _isWithVehName:Boolean = false;
      
      private var _valuePadding:Number = 0;
      
      private var _vehicleNamePosX:Number = 0;
      
      private var _iconPaddings:Dictionary = null;
      
      private var _items:Vector.<TextField>;
      
      private var _countTotalFrames:int = 0;
      
      private var _valueTotalFrames:int = 0;
      
      public function RibbonTexts()
      {
         super();
         this._common = App.utils.commons;
         this.valueAnim.stop();
         this.countVehAnim.stop();
         this.valueAnim.visible = false;
         this.countVehAnim.visible = false;
         this._valueTF = this.valueAnim.wrapper.tf;
         this._countVehiclesTF = this.countVehAnim.wrapper.tf;
         this._countVehiclesTF.autoSize = TextFieldAutoSize.LEFT;
         this._valueTF.autoSize = TextFieldAutoSize.LEFT;
         this.ribbonNameTF.autoSize = TextFieldAutoSize.LEFT;
         this.vNameTF.autoSize = TextFieldAutoSize.LEFT;
         this._countVehiclesTF.autoSize = TextFieldAutoSize.LEFT;
         this._iconPaddings = RibbonSettings.ICON_X_PADDINGS;
         this._items = new <TextField>[this._valueTF,this._countVehiclesTF];
         this._countTotalFrames = this.countVehAnim.totalFrames;
         this._valueTotalFrames = this.valueAnim.totalFrames;
      }
      
      public final function dispose() : void
      {
         this._ribbonSettings = null;
         this._iconPaddings = null;
         this.ribbonNameTF = null;
         this.vNameTF = null;
         this._valueTF = null;
         this._countVehiclesTF = null;
         this.countVehAnim = null;
         this.valueAnim = null;
         this._common = null;
         this._items.splice(0,this._items.length);
         this._items = null;
      }
      
      public function init(param1:RibbonSettings) : void
      {
         this._ribbonSettings = param1;
         this.ribbonNameTF.text = param1.getRibbonText();
         this.updateTextFields();
         var _loc2_:int = this.ribbonNameTF.x + this.ribbonNameTF.textWidth;
         this.countVehAnim.x = _loc2_ + VEH_COUNTER_X_PADDING;
         this.countVehAnim.gotoAndStop(this._countTotalFrames - 1);
         this.valueAnim.gotoAndStop(this._valueTotalFrames - 1);
      }
      
      public function setData(param1:String, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         if(this._vNameValue != param1)
         {
            this._vNameValue = param1;
            if(this._isWithVehName)
            {
               _loc5_ = param1 != Values.EMPTY_STR;
               if(this._vNameIsVisible != _loc5_)
               {
                  this._vNameIsVisible = _loc5_;
                  this.vNameTF.visible = _loc5_;
               }
               if(_loc5_)
               {
                  this.vNameTF.text = param1;
                  this.vNameTF.x = this._vehicleNamePosX + (this._iconPaddings[param4] << 1);
               }
            }
         }
         if(this._value != param2)
         {
            this._value = param2;
            _loc6_ = param2 != Values.EMPTY_STR;
            if(this._valueIsVisible != _loc6_)
            {
               this._valueIsVisible = _loc6_;
               this.valueAnim.visible = _loc6_;
            }
            if(_loc6_)
            {
               this._valueTF.text = param2;
               this.valueAnim.x = VALUE_DEFAULT_WIDTH - this._valueTF.textWidth + this._valuePadding;
            }
         }
         if(this._countVehicles != param3)
         {
            this._countVehicles = param3;
            _loc7_ = param3 != Values.EMPTY_STR;
            if(this._countVehiclesIsVisible != _loc7_)
            {
               this._countVehiclesIsVisible = _loc7_;
               this.countVehAnim.visible = _loc7_;
            }
            if(_loc7_)
            {
               this._countVehiclesTF.text = param3;
            }
         }
      }
      
      public function setSettings(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:PaddingSettings = RibbonSettings.getPaddings(param2,param3);
         this._isWithVehName = param3;
         this._valuePadding = _loc4_.valuePaddingX;
         this._vNameIsVisible = this._isWithVehName;
         if(this._isWithVehName)
         {
            this._vNameIsVisible = this._vNameValue != Values.EMPTY_STR;
            this.vNameTF.text = this._vNameValue;
         }
         this.vNameTF.visible = this._vNameIsVisible;
         this.ribbonNameTF.visible = param2;
         if(param2)
         {
            _loc5_ = this.ribbonNameTF.x + this.ribbonNameTF.textWidth;
         }
         else
         {
            _loc5_ = this.ribbonNameTF.x;
         }
         _loc5_ += _loc4_.tankNamePaddingX;
         this._vehicleNamePosX = _loc5_;
         this.vNameTF.x = _loc5_;
         this.countVehAnim.x = _loc5_ + this.vNameTF.textWidth + VEH_COUNTER_X_PADDING;
         if(!param1)
         {
            this.countVehAnim.gotoAndStop(this._countTotalFrames - 1);
            this.valueAnim.gotoAndPlay(this._valueTotalFrames - 1);
         }
      }
      
      public function showUpdateAnim() : void
      {
         if(this._countVehiclesIsVisible)
         {
            this.countVehAnim.gotoAndPlay(1);
         }
         if(this._valueIsVisible)
         {
            this.valueAnim.gotoAndPlay(UPDATE_FRAME_LBL);
         }
      }
      
      public function updateTextFields() : void
      {
         var _loc1_:TextField = null;
         var _loc3_:RibbonTextSettings = null;
         var _loc2_:int = this._items.length;
         _loc3_ = this._ribbonSettings.getTextSettings();
         var _loc4_:uint = _loc3_.shadowColor;
         var _loc5_:uint = _loc3_.valueTextColor;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            _loc1_ = this._items[_loc6_];
            _loc1_.textColor = _loc5_;
            this._common.setShadowFilterWithParams(_loc1_,RibbonTextSettings.SHADOW_DISTANCE,RibbonTextSettings.SHADOW_DISTANCE,_loc4_,RibbonTextSettings.SHADOW_ALPHA,RibbonTextSettings.SHADOW_BLUR,RibbonTextSettings.SHADOW_BLUR,RibbonTextSettings.SHADOW_STRENGTH);
            _loc6_++;
         }
         this._common.setShadowFilterWithParams(this.ribbonNameTF,RibbonTextSettings.SHADOW_DISTANCE,RibbonTextSettings.SHADOW_DISTANCE,_loc4_,RibbonTextSettings.SHADOW_ALPHA,RibbonTextSettings.SHADOW_BLUR,RibbonTextSettings.SHADOW_BLUR,RibbonTextSettings.SHADOW_STRENGTH);
         this.ribbonNameTF.textColor = _loc3_.ribbonNameTextColor;
      }
      
      public function get left() : int
      {
         return this.valueAnim && StringUtils.isNotEmpty(this._value) ? int(this.valueAnim.x) : int(VALUE_DEFAULT_LEFT);
      }
   }
}
