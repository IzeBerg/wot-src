package net.wg.gui.messenger.controls
{
   import flash.display.Graphics;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class MainGroupItem extends UIComponentEx implements IUpdatable
   {
      
      private static const DEF_PADDING:uint = 10;
      
      private static const SIDE_PADDING:uint = 3;
       
      
      public var title:TextField;
      
      private var _titleStr:String = "";
      
      public function MainGroupItem()
      {
         super();
      }
      
      public function update(param1:Object) : void
      {
         this._titleStr = param1.title;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         var _loc4_:Graphics = null;
         var _loc5_:uint = 0;
         super.draw();
         var _loc1_:Boolean = isInvalid(InvalidationType.DATA);
         if(_loc1_)
         {
            this.title.htmlText = this._titleStr;
         }
         if(_loc1_ || isInvalid(InvalidationType.SIZE))
         {
            this.title.width = _width;
            _loc2_ = this.title.textWidth;
            _loc3_ = (_width - _loc2_ >> 1) - DEF_PADDING;
            _loc4_ = this.graphics;
            _loc4_.clear();
            _loc4_.lineStyle(1,this.title.textColor);
            _loc5_ = _height >> 1;
            _loc4_.moveTo(SIDE_PADDING,_loc5_);
            _loc4_.lineTo(_loc3_,_loc5_);
            _loc4_.moveTo(Math.round(_loc3_ + _loc2_) + 2 * DEF_PADDING,_loc5_);
            _loc4_.lineTo(_width - 1 - SIDE_PADDING,_loc5_);
         }
      }
   }
}
