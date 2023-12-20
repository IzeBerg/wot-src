package net.wg.gui.cyberSport.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class CandidateHeaderItemRender extends UIComponentEx
   {
      
      private static const LINE_PADDING:uint = 5;
      
      private static const LEFT_LINE_PADDING:uint = 1;
       
      
      public var headerName:TextField;
      
      public var leftLine:MovieClip;
      
      public var rightLine:MovieClip;
      
      private var _headerToolTip:String = "";
      
      public function CandidateHeaderItemRender()
      {
         super();
         buttonMode = false;
         useHandCursor = false;
         scaleX = scaleY = 1;
         TextFieldEx.setVerticalAlign(this.headerName,TextFieldEx.VALIGN_CENTER);
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this.headerName.autoSize = TextFieldAutoSize.CENTER;
         this.headerName.htmlText = param1;
         if(param2 != Values.EMPTY_STR)
         {
            this._headerToolTip = param2;
            this.headerName.addEventListener(MouseEvent.ROLL_OUT,this.onHeaderRollOutHandler);
            this.headerName.addEventListener(MouseEvent.ROLL_OVER,this.onHeaderRollOverHandler);
         }
         else
         {
            this.headerName.removeEventListener(MouseEvent.ROLL_OUT,this.onHeaderRollOutHandler);
            this.headerName.removeEventListener(MouseEvent.ROLL_OVER,this.onHeaderRollOverHandler);
         }
      }
      
      public function invalidationElements() : void
      {
         this.headerName.x = Math.round((this._width - this.headerName.width) / 2);
         this.leftLine.x = LEFT_LINE_PADDING;
         this.leftLine.width = Math.round(this.headerName.x - LINE_PADDING);
         this.rightLine.x = Math.round(this.headerName.x + this.headerName.width + LINE_PADDING);
         this.rightLine.width = Math.round(this._width - this.rightLine.x);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.invalidationElements();
         }
      }
      
      override protected function onDispose() : void
      {
         this.headerName.removeEventListener(MouseEvent.ROLL_OUT,this.onHeaderRollOutHandler);
         this.headerName.removeEventListener(MouseEvent.ROLL_OVER,this.onHeaderRollOverHandler);
         this.headerName = null;
         this._headerToolTip = null;
         this.leftLine = null;
         this.rightLine = null;
         super.onDispose();
      }
      
      private function onHeaderRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onHeaderRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._headerToolTip);
      }
   }
}
