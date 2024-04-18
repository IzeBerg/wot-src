package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Directions;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IDynamicContent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   
   [InspectableList("visible")]
   public class HelpLayoutControl extends UIComponentEx implements IDynamicContent, IDisposable
   {
      
      private static var _SHADOW_PADDING_OUTSIDE:Padding = new Padding(22,22,22,22);
      
      private static const ALIGN_TOP:String = "T";
      
      private static const ALIGN_LEFT:String = "L";
      
      private static const ALIGN_RIGHT:String = "R";
      
      private static const ALIGN_BOTTOM:String = "B";
      
      private static const INSIDE_PADDING:Number = 6;
       
      
      public var textField:TextField;
      
      public var border:MovieClip;
      
      private var _vo:HelpLayoutVO;
      
      public function HelpLayoutControl()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this.border = null;
         this._vo = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(this._vo != null && isInvalid(InvalidationType.DATA))
         {
            this.parseData();
         }
         super.draw();
      }
      
      public function setData(param1:HelpLayoutVO) : void
      {
         this._vo = param1;
         App.utils.asserter.assert(Directions.LAYOUT_DIRECTIONS.indexOf(param1.extensibilityDirection) != -1,"invalid direction: " + param1.extensibilityDirection);
         invalidateData();
      }
      
      private function parseData() : void
      {
         this.textField.wordWrap = true;
         this.textField.autoSize = TextFieldAutoSize.CENTER;
         this.textField.text = this._vo.message;
         var _loc1_:Number = this.textField.textWidth + INSIDE_PADDING * 2;
         var _loc2_:Number = this.textField.textHeight + INSIDE_PADDING * 2;
         var _loc3_:int = Math.max(this._vo.width,_loc1_);
         var _loc4_:int = Math.max(this._vo.height,_loc2_);
         this.border.width = _loc3_ + _SHADOW_PADDING_OUTSIDE.horizontal;
         this.border.height = _loc4_ + _SHADOW_PADDING_OUTSIDE.vertical;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         switch(this._vo.extensibilityDirection)
         {
            case ALIGN_TOP:
               if(_loc4_ > this._vo.height)
               {
                  _loc6_ = this._vo.height - _loc4_;
               }
               break;
            case ALIGN_RIGHT:
               break;
            case ALIGN_BOTTOM:
               break;
            case ALIGN_LEFT:
               if(_loc3_ > this._vo.width)
               {
                  _loc5_ = this._vo.width - _loc3_;
               }
         }
         this.border.x = _loc5_ - _SHADOW_PADDING_OUTSIDE.left;
         this.border.y = _loc6_ - _SHADOW_PADDING_OUTSIDE.top;
         this.textField.x = this.border.x + (this.border.width - this.textField.width >> 1);
         this.textField.y = this.border.y + (this.border.height - this.textField.height >> 1);
      }
   }
}
