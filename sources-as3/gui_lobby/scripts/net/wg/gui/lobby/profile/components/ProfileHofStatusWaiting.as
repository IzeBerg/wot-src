package net.wg.gui.lobby.profile.components
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProfileHofStatusWaiting extends UIComponentEx
   {
       
      
      public var waitInfo:TextField = null;
      
      public var waitIcon:InviteIndicator = null;
      
      private var _info:String = "";
      
      public function ProfileHofStatusWaiting()
      {
         super();
      }
      
      public function setInfo(param1:String) : void
      {
         if(this._info != param1)
         {
            this._info = param1;
            invalidateData();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.waitInfo.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.waitInfo.text = this._info;
         }
      }
      
      override protected function onDispose() : void
      {
         this.waitInfo = null;
         this.waitIcon.dispose();
         this.waitIcon = null;
         super.onDispose();
      }
   }
}
