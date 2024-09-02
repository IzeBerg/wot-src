package net.wg.gui.notification.custom
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flashx.textLayout.formats.TextAlign;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PERSONAL_EXCHANGE_RATES;
   import net.wg.gui.interfaces.ISoundButton;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.constants.MessageMetrics;
   import net.wg.gui.notification.custom.vo.SMExchangeRatePersonalDiscountVO;
   import net.wg.utils.IScheduler;
   
   public class ExchangeRatePersonalDiscount extends ServiceMessageContent
   {
      
      private static const MESSAGE_BOTTOM_OFFSET:int = 222;
      
      private static const MESSAGE_BOTTOM_SHORT_OFFSET:int = 30;
      
      private static const TF_SHORT_Y:int = 146;
      
      private static const CHAR_PLUS:String = "+";
      
      private static const CHAR_PERCENT:String = "%";
      
      private static const SUBMIT_BTN_NAME:String = "submit";
      
      private static const SUBMIT_BTN_SOUND_TYPE:String = "simpleControl";
      
      private static const COUNT_TF_DEFAULT_X:uint = 18;
      
      private static const COUNT_TF_MAX_SYMBOLS:uint = 15;
      
      private static const COUNT_TF_DEFAULT_WIDTH:uint = 261;
      
      private static const COUNT_TF_X:Array = [17,26,26,26,26,26,26,70];
       
      
      public var countTF:TextField = null;
      
      private var _timeRemainingSeconds:int = 0;
      
      private var _scheduler:IScheduler;
      
      private var _textFieldOriginY:int = 0;
      
      public function ExchangeRatePersonalDiscount()
      {
         this._scheduler = App.utils.scheduler;
         super();
         messageTopOffset = 0;
         messageBottomOffset = MESSAGE_BOTTOM_OFFSET;
         buttonsAlign = TextFormatAlign.CENTER;
         this._textFieldOriginY = textField.y;
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.updateTimer);
         this.countTF = null;
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function updateData() : void
      {
         var _loc3_:int = 0;
         if(!data)
         {
            return;
         }
         super.updateData();
         var _loc1_:SMExchangeRatePersonalDiscountVO = new SMExchangeRatePersonalDiscountVO(data.messageVO.linkageData);
         this.countTF.selectable = false;
         this.countTF.x = COUNT_TF_DEFAULT_X;
         this.countTF.width = COUNT_TF_DEFAULT_WIDTH;
         this.countTF.defaultTextFormat = new TextFormat(null,null,null,null,null,null,null,null,TextAlign.CENTER);
         switch(_loc1_.type)
         {
            case PERSONAL_EXCHANGE_RATES.EXCHANGE_TYPE_EXP:
               bgIcon.source = RES_ICONS.MAPS_ICONS_PERSONALEXCHANGERATES_MESSENGER_EXPERIENCE_TRANSLATION;
               break;
            case PERSONAL_EXCHANGE_RATES.EXCHANGE_TYPE_GOLD:
               bgIcon.source = RES_ICONS.MAPS_ICONS_PERSONALEXCHANGERATES_MESSENGER_GOLD_EXCHANGE;
               break;
            default:
               bgIcon.source = Values.EMPTY_STR;
         }
         this._scheduler.cancelTask(this.updateTimer);
         textField.y = this._textFieldOriginY;
         switch(_loc1_.format)
         {
            case PERSONAL_EXCHANGE_RATES.NOTIFICATION_TYPE_INT:
               this.countTF.text = CHAR_PLUS + _loc1_.discountPercent + CHAR_PERCENT;
               break;
            case PERSONAL_EXCHANGE_RATES.NOTIFICATION_TYPE_TEMP:
               _loc3_ = new Date().getTime() / Time.MILLISECOND_IN_SECOND;
               this._timeRemainingSeconds = _loc1_.endTime - _loc3_;
               this._scheduler.scheduleRepeatableTask(this.updateTimer,Time.SECOND,this._timeRemainingSeconds);
               this.countTF.defaultTextFormat = new TextFormat(null,null,null,null,null,null,null,null,TextAlign.LEFT);
               this.updateTimer();
               break;
            case PERSONAL_EXCHANGE_RATES.NOTIFICATION_TYPE_FACTOR:
               this.countTF.text = Values.EMPTY_STR;
               messageBottomOffset = MESSAGE_BOTTOM_SHORT_OFFSET;
               textField.y = TF_SHORT_Y;
               break;
            default:
               this.countTF.text = Values.EMPTY_STR;
               messageBottomOffset = MessageMetrics.SIDES_BOTTOM_PADDING;
         }
         this.countTF.setTextFormat(this.countTF.defaultTextFormat);
         var _loc2_:ISoundButton = buttonsGroup.getChildByName(SUBMIT_BTN_NAME) as ISoundButton;
         if(_loc2_)
         {
            _loc2_.soundType = SUBMIT_BTN_SOUND_TYPE;
         }
      }
      
      private function updateTimer() : void
      {
         --this._timeRemainingSeconds;
         if(this._timeRemainingSeconds > Values.DEFAULT_INT)
         {
            this.countTF.text = App.utils.dateTime.formatSecondsToDDHHMMSS(this._timeRemainingSeconds);
         }
         App.utils.commons.updateTextFieldSize(this.countTF,true,false);
         this.countTF.x = COUNT_TF_X[COUNT_TF_MAX_SYMBOLS - this.countTF.length];
      }
      
      override public function get height() : Number
      {
         return background.y + background.height;
      }
   }
}
