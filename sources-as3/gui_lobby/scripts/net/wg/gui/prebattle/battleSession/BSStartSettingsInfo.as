package net.wg.gui.prebattle.battleSession
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BSStartSettingsInfo extends UIComponentEx
   {
      
      private static const CLAN_BATTLE_TYPE:uint = 5;
      
      private static const GAP_X_UNIT_INFO_START:uint = 3;
      
      private static const GAP_X_UNIT_INFO_END:uint = 6;
      
      private static const CHAR_COMMA:String = ", ";
       
      
      public var unitInfo:BSUnitInfo;
      
      public var timeFieldStart:TextField;
      
      public var timeFieldEnd:TextField;
      
      public var hitAreaMc:Sprite;
      
      private var _unitLetter:int = -1;
      
      private var _vehicleLevel:int = 0;
      
      private var _battleType:Number = -1;
      
      private var _timeInfo:String = "";
      
      private var _showUnit:Boolean = false;
      
      public function BSStartSettingsInfo()
      {
         super();
      }
      
      override public function getBounds(param1:DisplayObject) : Rectangle
      {
         return this.hitAreaMc.getBounds(param1);
      }
      
      override protected function onDispose() : void
      {
         this.hitAreaMc = null;
         this.unitInfo.dispose();
         this.unitInfo = null;
         this.timeFieldStart = null;
         this.timeFieldEnd = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this._showUnit = this._unitLetter > Values.DEFAULT_INT && this._vehicleLevel > Values.ZERO;
            _loc1_ = this._battleType == CLAN_BATTLE_TYPE;
            _loc2_ = !!_loc1_ ? App.utils.locale.makeString(PREBATTLE.TITLE_BATTLESESSION_HEADER_BATTLESETTINGS) : this._timeInfo;
            if(this._showUnit)
            {
               _loc2_ += Values.SPACE_STR + App.utils.locale.makeString(PREBATTLE.TITLE_BATTLESESSION_UNIT);
               this.unitInfo.updateData(this._unitLetter,this._vehicleLevel,true);
               this.timeFieldEnd.text = CHAR_COMMA + this._timeInfo;
            }
            else if(_loc1_)
            {
               _loc2_ += Values.SPACE_STR + this._timeInfo;
            }
            this.timeFieldStart.text = _loc2_;
            this.unitInfo.visible = this._showUnit;
            this.timeFieldEnd.visible = this._showUnit;
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            App.utils.commons.updateTextFieldSize(this.timeFieldStart,true,false);
            if(this._showUnit)
            {
               App.utils.commons.updateTextFieldSize(this.timeFieldEnd,true,false);
               this.unitInfo.x = this.timeFieldStart.x + this.timeFieldStart.textWidth + GAP_X_UNIT_INFO_START >> 0;
               this.timeFieldEnd.x = this.unitInfo.x + this.unitInfo.width + GAP_X_UNIT_INFO_END >> 0;
            }
         }
      }
      
      public function updateData(param1:Number, param2:String, param3:int, param4:int) : void
      {
         var _loc5_:Boolean = this._unitLetter != param3 || this._vehicleLevel != param4 || this._timeInfo != param2 || this._battleType != param1;
         this._battleType = param1;
         this._unitLetter = param3;
         this._vehicleLevel = param4;
         this._timeInfo = param2;
         if(_loc5_)
         {
            invalidateData();
            invalidateLayout();
         }
      }
      
      override public function get width() : Number
      {
         return this.hitAreaMc.width;
      }
      
      override public function get height() : Number
      {
         return this.hitAreaMc.height;
      }
   }
}
