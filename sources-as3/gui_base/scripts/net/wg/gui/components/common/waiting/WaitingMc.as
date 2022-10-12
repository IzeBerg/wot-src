package net.wg.gui.components.common.waiting
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class WaitingMc extends UIComponentEx
   {
      
      public static var id:int = 0;
      
      public static const TEXT_INVALID:String = "textInv";
       
      
      public var textField:TextField;
      
      public var waitingLogo:Sprite;
      
      public var uid:int = 0;
      
      private var _text:String = "";
      
      public function WaitingMc()
      {
         super();
         ++id;
         this.uid = id;
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this.waitingLogo = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(TEXT_INVALID))
         {
            this.textField.text = this._text;
         }
      }
      
      public function setMessage(param1:String) : void
      {
         this._text = param1;
         invalidate(TEXT_INVALID);
      }
   }
}
