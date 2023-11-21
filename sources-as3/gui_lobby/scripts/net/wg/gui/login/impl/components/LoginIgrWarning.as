package net.wg.gui.login.impl.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class LoginIgrWarning extends UIComponentEx
   {
      
      private static const DEF_BG_HEIGHT:uint = 60;
      
      private static const DEF_TEXT_HEIGHT:uint = 16;
       
      
      public var textField:TextField = null;
      
      public var bg:Sprite = null;
      
      private var _warning:String = "";
      
      public function LoginIgrWarning()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.warning = MENU.LOGIN_REMEMBERPASSWORDIGRWARNING;
         this.textField.multiline = true;
         this.textField.wordWrap = true;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.textField.text = this._warning;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = 0;
            if(this.textField.textHeight > DEF_TEXT_HEIGHT)
            {
               _loc1_ = this.textField.textHeight - DEF_TEXT_HEIGHT | 0;
            }
            this.bg.height = DEF_BG_HEIGHT + _loc1_;
         }
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.textField = null;
         this._warning = null;
         super.onDispose();
      }
      
      public function set warning(param1:String) : void
      {
         if(param1 == this._warning)
         {
            return;
         }
         this._warning = param1;
         invalidateData();
      }
   }
}
