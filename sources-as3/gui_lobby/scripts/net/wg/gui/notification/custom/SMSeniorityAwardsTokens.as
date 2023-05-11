package net.wg.gui.notification.custom
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.ICON_TEXT_FRAMES;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.custom.vo.SMCustomSeniorityAwardsTokensVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class SMSeniorityAwardsTokens extends ServiceMessageContent
   {
      
      private static const TIME_TOP_PADDING:uint = 7;
      
      private static const TIME_ICON_TEXT_DISTANCE_SHIFT:int = -16;
      
      private static const TIME_ICON_TEXT_Y_OFFSET:int = -2;
      
      private static const TEXT_Y_SHIFT:uint = 14;
      
      private static const CONTENT_TOP_OFFSET:int = 7;
      
      private static const CONTENT_BOTTOM_OFFSET:int = 35;
      
      private static const MESSAGE_BOTTOM_OFFSET:int = 35;
      
      private static const MESSAGE_WIDTH:uint = 289;
       
      
      public var countTF:TextField = null;
      
      private var _timeLeft:IconText = null;
      
      private var _hasTimer:Boolean = false;
      
      private var _defTextYPos:int = 0;
      
      public function SMSeniorityAwardsTokens()
      {
         super();
         contentTopOffset = CONTENT_TOP_OFFSET;
         contentBottomOffset = CONTENT_BOTTOM_OFFSET;
         messageTopOffset = 0;
         messageBottomOffset = MESSAGE_BOTTOM_OFFSET;
         buttonsAlign = TextFormatAlign.CENTER;
         this._defTextYPos = textField.y;
      }
      
      override protected function onDispose() : void
      {
         this.countTF = null;
         if(this._timeLeft)
         {
            this._timeLeft.dispose();
            this.removeChild(this._timeLeft);
            this._timeLeft = null;
         }
         super.onDispose();
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         var _loc1_:SMCustomSeniorityAwardsTokensVO = new SMCustomSeniorityAwardsTokensVO(data.messageVO.linkageData);
         this.countTF.text = _loc1_.count;
         bgIcon.source = RES_ICONS.MAPS_ICONS_SENIORITYAWARDS_MESSENGER_POPUP_NOTIFICATION_TOKENS_BG;
         if(StringUtils.isNotEmpty(_loc1_.finishTime) && this._timeLeft == null)
         {
            this._timeLeft = App.utils.classFactory.getComponent(Linkages.ICON_TEXT,IconText);
            this._timeLeft.iconPosition = IconTextPosition.LEFT;
            this._timeLeft.xCorrect = TIME_ICON_TEXT_DISTANCE_SHIFT;
            this._timeLeft.textFieldYOffset = TIME_ICON_TEXT_Y_OFFSET;
            this._timeLeft.icon = ICON_TEXT_FRAMES.RENTALS;
            this._timeLeft.text = _loc1_.finishTime;
            this._timeLeft.useHtmlText = true;
            this._timeLeft.validateNow();
            this._hasTimer = true;
            this.addChild(this._timeLeft);
            this.updateTimerPosition();
         }
      }
      
      override protected function updateLayout() : void
      {
         textField.y = !!this._hasTimer ? Number(this._defTextYPos) : Number(this._defTextYPos + TEXT_Y_SHIFT);
         this.updateTimerPosition();
         super.updateLayout();
      }
      
      override protected function get buttonsAnchorVertical() : DisplayObject
      {
         return !!this._hasTimer ? this._timeLeft : textField;
      }
      
      override public function get width() : Number
      {
         return MESSAGE_WIDTH;
      }
      
      private function updateTimerPosition() : void
      {
         if(this._hasTimer)
         {
            this._timeLeft.x = textField.x + (textField.width - this._timeLeft.actualWidth - TIME_ICON_TEXT_DISTANCE_SHIFT >> 1);
            this._timeLeft.y = textField.y + textField.height + TIME_TOP_PADDING;
         }
      }
   }
}
