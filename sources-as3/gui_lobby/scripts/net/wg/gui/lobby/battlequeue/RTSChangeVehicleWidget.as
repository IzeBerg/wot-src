package net.wg.gui.lobby.battlequeue
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RTSChangeVehicleWidget extends MovieClip implements IDisposable
   {
      
      private static const TIMER_ICON_OFFSET:int = -10;
      
      private static const BUTTON_POSITION:int = 40;
      
      private static const TEXT_OFFSET:int = -30;
       
      
      public var changeBtn:ISoundButtonEx;
      
      public var changeDescription:TextField;
      
      public var changeText:TextField;
      
      public var timeValue:TextField;
      
      public var timeText:TextField;
      
      public var timeIcon:Sprite;
      
      public var widgetHitArea:Sprite;
      
      public var bonusLabel:MovieClip;
      
      private var _bonusTF:TextField = null;
      
      private var _vehicleName:String = "";
      
      private var _isDisposed:Boolean = false;
      
      public function RTSChangeVehicleWidget()
      {
         super();
         this._bonusTF = this.bonusLabel.bonusTF;
         this.hitArea = this.widgetHitArea;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._isDisposed = true;
      }
      
      public function setData(param1:RTSChangeVehicleWidgetVO) : void
      {
         this._vehicleName = param1.vehicleName;
         this.bonusLabel.visible = StringUtils.isNotEmpty(param1.bonusLabel);
         if(this.bonusLabel.visible)
         {
            this._bonusTF.htmlText = param1.bonusLabel;
         }
         this.changeText.htmlText = param1.changeTitle;
         this.changeBtn.label = param1.btnLabel;
         this.timeText.htmlText = param1.calculatedText;
         App.utils.commons.updateTextFieldSize(this.timeText,true,true);
         this.changeDescription.visible = StringUtils.isNotEmpty(param1.changeDescr);
         if(this.changeDescription.visible)
         {
            this.changeDescription.htmlText = param1.changeDescr;
            App.utils.commons.updateTextFieldSize(this.changeDescription,true,true);
         }
         this.timeValue.htmlText = param1.waitingTime;
         App.utils.commons.updateTextFieldSize(this.timeValue,true,true);
         this.updateLayout();
      }
      
      protected function onDispose() : void
      {
         this._bonusTF = null;
         this.bonusLabel = null;
         this.changeDescription = null;
         this.changeText = null;
         this.timeValue = null;
         this.timeText = null;
         this.changeBtn.dispose();
         this.changeBtn = null;
         this.widgetHitArea = null;
         this.timeIcon = null;
      }
      
      private function updateLayout() : void
      {
         this.timeText.x = this.width - this.timeText.width - this.timeIcon.width - this.timeValue.width - 2 * TIMER_ICON_OFFSET >> 1;
         this.timeIcon.x = this.timeText.x + this.timeText.width + TIMER_ICON_OFFSET >> 0;
         this.timeValue.x = this.timeIcon.x + this.timeIcon.width + TIMER_ICON_OFFSET >> 0;
         this.changeBtn.y = !!this.changeDescription.visible ? Number(BUTTON_POSITION) : Number((this.height >> 1) - (this.changeBtn.height >> 1));
         this.changeText.y = this.changeBtn.y + TEXT_OFFSET >> 0;
         if(this.changeDescription.visible)
         {
            this.changeDescription.x = this.width - this.changeDescription.width >> 1;
         }
      }
      
      override public function get width() : Number
      {
         return this.widgetHitArea.width;
      }
      
      override public function get height() : Number
      {
         return this.widgetHitArea.height;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
