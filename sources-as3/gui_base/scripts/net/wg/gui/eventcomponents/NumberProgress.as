package net.wg.gui.eventcomponents
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NumberProgress extends MovieClip implements IDisposable
   {
      
      private static const TEXT_FIELD_PADDING:int = 2;
      
      private static const POINTS_STR:String = "..";
       
      
      public var txtField:TextField = null;
      
      public function NumberProgress()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.txtField = null;
      }
      
      public function setColor(param1:int) : void
      {
         gotoAndStop(param1);
      }
      
      public function setText(param1:String) : void
      {
         this.txtField.text = param1;
      }
      
      public function setValue(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = this.txtField.width - TEXT_FIELD_PADDING;
         var _loc3_:String = param1;
         this.txtField.text = _loc3_;
         if(_loc2_ < this.txtField.textWidth)
         {
            _loc3_ = param1 + POINTS_STR;
            this.txtField.text = _loc3_;
            _loc4_ = param1.length - 1;
            while(_loc2_ < this.txtField.textWidth && _loc4_ > 0)
            {
               _loc3_ = param1.slice(0,_loc4_) + POINTS_STR;
               this.txtField.text = _loc3_;
               _loc4_--;
            }
         }
      }
      
      public function setTextFieldWidth(param1:int) : void
      {
         this.txtField.width = param1;
      }
      
      public function getTextWidth() : Number
      {
         App.utils.commons.updateTextFieldSize(this.txtField);
         return this.txtField.textWidth;
      }
   }
}
