package net.wg.gui.battle.eventBattle.views.minimap.entries
{
   import flash.display.CapsStyle;
   import flash.display.Graphics;
   import flash.display.JointStyle;
   import flash.display.LineScaleMode;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class CustomDeathZoneMinimapEntry extends BattleUIComponent
   {
      
      private static const FILL_COLOR:int = 13369344;
      
      private static const FILL_ALPHA:Number = 0.8;
      
      private static const COORD_STEP:int = 2;
      
      private static const LINE_COLOR:int = 16766720;
      
      private static const ARGS:String = "Args";
      
      private static const MITER_LIMIT:int = 10;
       
      
      public var placeholderShape:Sprite = null;
      
      public var placeholderBorder:Sprite = null;
      
      private var _fillColor:int = 13369344;
      
      private var _fillAlpha:Number = 0.8;
      
      private var _lineColor:int = 16766720;
      
      private var _lineAlpha:Number = 1.0;
      
      private var _lineThickness:Number = 1.0;
      
      public function CustomDeathZoneMinimapEntry()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.placeholderShape = null;
         this.placeholderBorder = null;
         super.onDispose();
      }
      
      public function setProperties(param1:int, param2:Number, param3:int, param4:Number, param5:Number = 1, param6:String = "normal", param7:String = "normal") : void
      {
         this._fillColor = param1;
         this._fillAlpha = param2;
         this._lineColor = param3;
         this._lineAlpha = param4;
         this._lineThickness = param5;
         this.placeholderShape.blendMode = param6;
         this.placeholderBorder.blendMode = param7;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         visible = param1;
      }
      
      public function setZoneData(... rest) : void
      {
         App.utils.asserter.assertNotNull(rest,ARGS + Errors.CANT_NULL);
         var _loc2_:Graphics = this.placeholderShape.graphics;
         var _loc3_:Graphics = this.placeholderBorder.graphics;
         _loc2_.clear();
         _loc3_.clear();
         _loc3_.lineStyle(this._lineThickness,this._lineColor,this._lineAlpha,false,LineScaleMode.VERTICAL,CapsStyle.NONE,JointStyle.MITER,MITER_LIMIT);
         _loc2_.beginFill(this._fillColor,this._fillAlpha);
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
