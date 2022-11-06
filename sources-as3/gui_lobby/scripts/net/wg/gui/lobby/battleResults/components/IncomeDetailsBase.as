package net.wg.gui.lobby.battleResults.components
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.ICommons;
   import net.wg.utils.IUtils;
   
   public class IncomeDetailsBase extends UIComponentEx
   {
      
      private static const DOTS_OFFSET:int = 3;
      
      private static const LINE_OFFSET:int = 5;
       
      
      public var label:TextField = null;
      
      public var dots:DisplayObjectContainer = null;
      
      private var _columns:Vector.<TextField>;
      
      public function IncomeDetailsBase()
      {
         var _loc1_:TextField = null;
         super();
         this.label.mouseWheelEnabled = false;
         this._columns = this.initColumns();
         for each(_loc1_ in this._columns)
         {
            _loc1_.mouseWheelEnabled = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this.label = null;
         this.dots = null;
         this._columns.splice(0,this._columns.length);
         this._columns = null;
         super.onDispose();
      }
      
      public function setColumnsAlpha(param1:Number, param2:Number) : void
      {
      }
      
      public function setData(param1:Vector.<DetailedStatsItemVO>) : void
      {
         var _loc2_:TextField = null;
         var _loc5_:DetailedStatsItemVO = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         this.label.htmlText = "";
         for each(_loc2_ in this._columns)
         {
            _loc2_.htmlText = "";
         }
         while(this.dots.numChildren > 0)
         {
            this.dots.removeChildAt(0);
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = param1.length;
         var _loc6_:IUtils = App.utils;
         var _loc7_:ICommons = _loc6_.commons;
         var _loc8_:IClassFactory = _loc6_.classFactory;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1[_loc3_];
            _loc7_.addBlankLines(_loc5_.labelStripped,this.label,this._columns);
            this.label.htmlText += _loc5_.label;
            this.setColumnsData(_loc5_);
            if(_loc5_.lineType)
            {
               _loc9_ = this.label.x + DOTS_OFFSET;
               _loc10_ = Math.floor(this.label.y + this.label.textHeight) + DOTS_OFFSET - this.dots.y;
               this.dots.addChild(_loc8_.getComponent(_loc5_.lineType,Sprite,{
                  "x":_loc9_,
                  "y":_loc10_
               }));
            }
            _loc3_++;
         }
         this.label.height = this.label.textHeight + LINE_OFFSET;
         for each(_loc2_ in this._columns)
         {
            _loc2_.height = _loc2_.textHeight + LINE_OFFSET;
         }
         height = this.label.height;
      }
      
      protected function initColumns() : Vector.<TextField>
      {
         return new Vector.<TextField>();
      }
      
      protected function setColumnsData(param1:DetailedStatsItemVO) : void
      {
      }
   }
}
