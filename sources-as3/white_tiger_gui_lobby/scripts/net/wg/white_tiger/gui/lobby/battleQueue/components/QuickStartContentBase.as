package net.wg.white_tiger.gui.lobby.battleQueue.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.QuickStartPanelVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.events.QuickStartEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class QuickStartContentBase extends UIComponentEx
   {
      
      private static const CLOCK_BORDER_LEFT_OFFSET:int = 7;
      
      private static const CLOCK_BORDER_RIGHT_OFFSET:int = 10;
      
      private static const AVERAGE_TIME_LABEL_OFFSET_Y_BIG:int = -41;
      
      private static const CLOCK_OFFSET_Y_BIG:int = -56;
      
      private static const AVERAGE_TIME_TEXT_OFFSET_Y_BIG:int = -45;
      
      private static const AVERAGE_TIME_LABEL_OFFSET_Y_SMALL:int = -35;
      
      private static const CLOCK_OFFSET_Y_SMALL:int = -50;
      
      private static const AVERAGE_TIME_TEXT_OFFSET_Y_SMALL:int = -39;
       
      
      public var averageTimeLabel:TextField;
      
      public var clockIcon:Sprite;
      
      public var averageTimeText:TextField;
      
      public var rect:Sprite;
      
      public var infoText:TextField;
      
      public var quickStartBtn:ISoundButtonEx;
      
      private var _isSmall:Boolean = false;
      
      public function QuickStartContentBase()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.quickStartBtn.removeEventListener(ButtonEvent.CLICK,this.onQuickStartButtonClickHandler);
         this.quickStartBtn.dispose();
         this.quickStartBtn = null;
         this.averageTimeLabel = null;
         this.clockIcon = null;
         this.averageTimeText = null;
         this.rect = null;
         this.infoText = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.quickStartBtn.addEventListener(ButtonEvent.CLICK,this.onQuickStartButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this.averageTimeLabel.textWidth + this.clockIcon.width + this.averageTimeText.textWidth;
            _loc1_ -= CLOCK_BORDER_LEFT_OFFSET + CLOCK_BORDER_RIGHT_OFFSET;
            this.averageTimeLabel.x = _width - _loc1_ >> 1;
            this.clockIcon.x = this.averageTimeLabel.x + this.averageTimeLabel.textWidth - CLOCK_BORDER_LEFT_OFFSET | 0;
            this.averageTimeText.x = this.clockIcon.x + this.clockIcon.width - CLOCK_BORDER_RIGHT_OFFSET;
            this.averageTimeLabel.y = !!this.isSmall ? Number(AVERAGE_TIME_LABEL_OFFSET_Y_SMALL) : Number(AVERAGE_TIME_LABEL_OFFSET_Y_BIG);
            this.clockIcon.y = !!this.isSmall ? Number(CLOCK_OFFSET_Y_SMALL) : Number(CLOCK_OFFSET_Y_BIG);
            this.averageTimeText.y = !!this.isSmall ? Number(AVERAGE_TIME_TEXT_OFFSET_Y_SMALL) : Number(AVERAGE_TIME_TEXT_OFFSET_Y_BIG);
         }
      }
      
      public function setAverageTime(param1:String, param2:String) : void
      {
         this.averageTimeLabel.text = param1;
         this.averageTimeText.text = param2;
         invalidateSize();
      }
      
      public function setData(param1:QuickStartPanelVO) : void
      {
      }
      
      public function setInfoText(param1:String) : void
      {
         this.infoText.text = param1;
         invalidateSize();
      }
      
      protected function updateSize() : void
      {
         invalidateSize();
      }
      
      public function get selectedVehId() : int
      {
         throw new AbstractException();
      }
      
      public function get isVehicleSelected() : Boolean
      {
         return this.selectedVehId != Values.DEFAULT_INT;
      }
      
      public function get isSmall() : Boolean
      {
         return this._isSmall;
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(param1 != this._isSmall)
         {
            this._isSmall = param1;
            this.updateSize();
         }
      }
      
      private function onQuickStartButtonClickHandler(param1:ButtonEvent) : void
      {
         if(this.isVehicleSelected)
         {
            dispatchEvent(new QuickStartEvent(QuickStartEvent.QUICK_START,this.selectedVehId));
         }
      }
   }
}
