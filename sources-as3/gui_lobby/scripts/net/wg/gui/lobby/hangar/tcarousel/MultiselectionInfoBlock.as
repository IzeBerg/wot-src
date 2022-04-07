package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.advanced.IndicationOfStatus;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class MultiselectionInfoBlock extends UIComponentEx
   {
      
      private static const POSITION_INVALID:String = "positionInvalid";
      
      private static const INDICATOR_OFFSET_X:int = 13;
      
      private static const STATUS_TEXT_OFFSET_X:int = 7;
       
      
      public var vehicleTypesTF:TextField = null;
      
      public var shortStatusTxt:TextField = null;
      
      public var indicator:IndicationOfStatus = null;
      
      public function MultiselectionInfoBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleTypesTF.autoSize = TextFieldAutoSize.LEFT;
         this.shortStatusTxt.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(POSITION_INVALID))
         {
            this.indicator.x = this.vehicleTypesTF.textWidth - this.indicator.width + INDICATOR_OFFSET_X;
            this.shortStatusTxt.x = this.indicator.x - this.shortStatusTxt.width + STATUS_TEXT_OFFSET_X;
            setSize(Math.max(this.vehicleTypesTF.textWidth,this.shortStatusTxt.textWidth) ^ 0,height);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.vehicleTypesTF = null;
         this.shortStatusTxt = null;
         this.indicator.dispose();
         this.indicator = null;
         super.onDispose();
      }
      
      public function setData(param1:String, param2:String, param3:Boolean) : void
      {
         this.vehicleTypesTF.htmlText = param1;
         this.shortStatusTxt.htmlText = param2;
         this.indicator.status = !!param3 ? IndicationOfStatus.STATUS_READY : IndicationOfStatus.STATUS_CANCELED;
         invalidate(POSITION_INVALID);
      }
   }
}
