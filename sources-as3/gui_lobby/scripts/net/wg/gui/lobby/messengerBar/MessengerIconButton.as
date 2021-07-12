package net.wg.gui.lobby.messengerBar
{
   import net.wg.gui.components.controls.SoundButtonEx;
   
   public class MessengerIconButton extends SoundButtonEx
   {
       
      
      private var _htmlIconStr:String = "";
      
      public function MessengerIconButton()
      {
         super();
      }
      
      override public function set label(param1:String) : void
      {
         super.label = param1;
      }
      
      override protected function updateText() : void
      {
         textField.htmlText = this.htmlIconStr + _label;
      }
      
      public function get htmlIconStr() : String
      {
         return this._htmlIconStr;
      }
      
      public function set htmlIconStr(param1:String) : void
      {
         this._htmlIconStr = param1;
         invalidateData();
      }
   }
}
