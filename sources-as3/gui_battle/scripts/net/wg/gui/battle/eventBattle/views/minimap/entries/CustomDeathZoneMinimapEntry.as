package net.wg.gui.battle.eventBattle.views.minimap.entries
{
   import flash.display.CapsStyle;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.JointStyle;
   import flash.display.LineScaleMode;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class CustomDeathZoneMinimapEntry extends BattleUIComponent
   {
      
      private static const FILL_COLOR:int = 13369344;
      
      private static const FILL_ALPHA:Number = 0.8;
      
      private static const COORD_STEP:int = 2;
      
      private static const LINE_COLOR:int = 16766720;
      
      private static const ARGS:String = "Args";
      
      private static const MITER_LIMIT:int = 10;
      
      private static const MAX_GRADIENT:int = 255;
       
      
      public var placeholderShape:Sprite = null;
      
      public var placeholderBorder:Sprite = null;
      
      private var _fillColor:int = 13369344;
      
      private var _fillAlpha:Number = 0.8;
      
      private var _lineColor:int = 16766720;
      
      private var _lineAlpha:Number = 1.0;
      
      private var _lineThickness:Number = 1.0;
      
      private var _gradientColor:int = 0;
      
      private var _gradientAlpha:Number = 1.0;
      
      private var _gradientSize:Number = 0;
      
      private var _useGradient:Boolean = true;
      
      private var _zones:Array;
      
      public function CustomDeathZoneMinimapEntry()
      {
         this._zones = [];
         super();
      }
      
      override protected function onDispose() : void
      {
         this.placeholderShape = null;
         this.placeholderBorder = null;
         this._zones.splice(0,this._zones.length);
         this._zones = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         var _loc2_:Graphics = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:Matrix = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this.placeholderShape.graphics;
            _loc2_ = this.placeholderBorder.graphics;
            _loc1_.clear();
            _loc2_.clear();
            _loc2_.lineStyle(this._lineThickness,this._lineColor,this._lineAlpha,false,LineScaleMode.VERTICAL,CapsStyle.NONE,JointStyle.MITER,MITER_LIMIT);
            if(this._useGradient)
            {
               _loc5_ = new Matrix();
               _loc6_ = -(this._gradientSize >> 1);
               _loc5_.createGradientBox(this._gradientSize,this._gradientSize,0,_loc6_,_loc6_);
               _loc1_.beginGradientFill(GradientType.RADIAL,[this._fillColor,this._gradientColor],[this._fillAlpha,this._gradientAlpha],[0,MAX_GRADIENT],_loc5_,SpreadMethod.PAD);
            }
            else
            {
               _loc1_.beginFill(this._fillColor,this._fillAlpha);
            }
            _loc3_ = this._zones.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc7_ = this._zones[_loc4_];
               _loc8_ = _loc7_.length;
               _loc1_.moveTo(_loc7_[0],_loc7_[1]);
               _loc2_.moveTo(_loc7_[0],_loc7_[1]);
               _loc9_ = COORD_STEP;
               while(_loc9_ < _loc8_)
               {
                  _loc1_.lineTo(_loc7_[_loc9_],_loc7_[_loc9_ + 1]);
                  _loc2_.lineTo(_loc7_[_loc9_],_loc7_[_loc9_ + 1]);
                  _loc9_ += COORD_STEP;
               }
               _loc2_.lineTo(_loc7_[0],_loc7_[1]);
               _loc4_ += 1;
            }
            _loc1_.endFill();
         }
      }
      
      public function addZoneData(... rest) : void
      {
         this._zones.push(rest);
         invalidateData();
      }
      
      public function clearZones() : void
      {
         this._zones.splice(0,this._zones.length);
         invalidateData();
      }
      
      public function setProperties(param1:int, param2:Number, param3:int, param4:Number, param5:Number = 1, param6:String = "normal", param7:String = "normal", param8:Boolean = false, param9:int = 0, param10:Number = 1.0, param11:int = 0) : void
      {
         this._fillColor = param1;
         this._fillAlpha = param2;
         this._lineColor = param3;
         this._lineAlpha = param4;
         this._lineThickness = param5;
         this.placeholderShape.blendMode = param6;
         this.placeholderBorder.blendMode = param7;
         this._useGradient = param8;
         this._gradientColor = param9;
         this._gradientAlpha = param10;
         this._gradientSize = param11;
         invalidateData();
      }
      
      public function setZoneData(... rest) : void
      {
         App.utils.asserter.assertNotNull(rest,ARGS + Errors.CANT_NULL);
         var _loc2_:Graphics = this.placeholderShape.graphics;
         var _loc3_:Graphics = this.placeholderBorder.graphics;
         _loc2_.clear();
         _loc3_.clear();
         _loc2_.beginFill(this._fillColor,this._fillAlpha);
         _loc3_.lineStyle(this._lineThickness,this._lineColor,this._lineAlpha,false,LineScaleMode.VERTICAL,CapsStyle.NONE,JointStyle.MITER,MITER_LIMIT);
         var _loc4_:int = rest.length;
         _loc2_.moveTo(rest[0],rest[1]);
         _loc3_.moveTo(rest[0],rest[1]);
         var _loc5_:uint = COORD_STEP;
         while(_loc5_ < _loc4_)
         {
            _loc2_.lineTo(rest[_loc5_],rest[_loc5_ + 1]);
            _loc3_.lineTo(rest[_loc5_],rest[_loc5_ + 1]);
            _loc5_ += COORD_STEP;
         }
         _loc3_.lineTo(rest[0],rest[1]);
         _loc2_.endFill();
      }
   }
}
