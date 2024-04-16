package net.wg.gui.lobby.sessionStats.settings
{
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsHeaderVO;
   import net.wg.gui.lobby.sessionStats.helpers.SessionStatsHelper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class SessionStatsSettingsHeader extends SessionStatsSettingsBaseBlock
   {
      
      public static const RESET_CLICK:String = "on_reset";
       
      
      public var resetBtn:IButtonIconLoader = null;
      
      private const RESET_BUTTON_GAP:Number = 5;
      
      private var _data:SessionStatsSettingsHeaderVO = null;
      
      public function SessionStatsSettingsHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         title.autoSize = TextFieldAutoSize.LEFT;
         this.resetBtn.addEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.resetBtn.removeEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
         this.resetBtn.dispose();
         this.resetBtn = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            title.htmlText = this._data.title;
            this.resetBtn.iconSource = this._data.resetBtnIcon;
            this.resetBtn.tooltip = this._data.resetBtnTooltip;
            this.resetBtn.enabled = this._data.resetBtnEnabled;
            this.resetBtn.mouseEnabledOnDisabled = true;
            this.updateLayout();
         }
      }
      
      private function updateLayout() : void
      {
         var _loc1_:Number = SessionStatsHelper.TOTAL_WIDTH - title.width >> 1;
         var _loc2_:Number = this.resetBtn.width + this.RESET_BUTTON_GAP >> 1;
         title.x = _loc1_ - _loc2_;
         this.resetBtn.x = int(title.x + title.width + this.RESET_BUTTON_GAP);
      }
      
      private function onResetBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new Event(RESET_CLICK,true));
      }
      
      public function setData(param1:SessionStatsSettingsHeaderVO) : void
      {
         this._data = param1;
         invalidateData();
      }
   }
}
