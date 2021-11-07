package net.wg.gui.messenger.controls
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class InfoMessageView extends UIComponentEx
   {
      
      public static const STATE_NORMAL:String = "normal";
      
      public static const STATE_WARNING:String = "warning";
       
      
      public var titleTF:TextField;
      
      public var messageTF:TextField;
      
      public function InfoMessageView()
      {
         super();
      }
      
      public function showMessage(param1:String, param2:String, param3:Boolean = false) : void
      {
         gotoAndStop(!!param3 ? STATE_WARNING : STATE_NORMAL);
         this.titleTF.text = param1;
         this.messageTF.text = param2;
      }
   }
}
