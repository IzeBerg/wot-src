package net.wg.gui.components.tooltips
{
   import flash.display.DisplayObject;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   
   public class ExtraModuleInfo extends SimpleLoader
   {
       
      
      private var _textField:TextField;
      
      public function ExtraModuleInfo(param1:TextFormat, param2:StyleSheet = null)
      {
         super();
         this._textField = App.textMgr.createTextField();
         this._textField.autoSize = TextFieldAutoSize.LEFT;
         this._textField.setTextFormat(param1);
         if(param2)
         {
            this._textField.styleSheet = param2;
         }
         addChild(this._textField);
      }
      
      override protected function startLoading(param1:String) : void
      {
         super.startLoading(param1);
         if(loader)
         {
            loader.parent.setChildIndex(loader,0);
         }
      }
      
      override protected function onLoadingComplete() : void
      {
         super.onLoadingComplete();
         this.layoutComponents();
      }
      
      public function setData(param1:String, param2:String) : void
      {
         disposeLoader();
         this._textField.htmlText = param2;
         this.startLoading(param1);
      }
      
      private function layoutComponents() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc4_:DisplayObject = null;
         _loc1_ = 0;
         _loc2_ = 5;
         var _loc3_:int = 0;
         while(_loc3_ < numChildren)
         {
            _loc4_ = getChildAt(_loc3_);
            _loc4_.y = Math.round((height - _loc4_.height) / 2);
            _loc4_.x = _loc1_;
            _loc1_ += Math.round(_loc2_ + _loc4_.width);
            _loc3_++;
         }
      }
   }
}
