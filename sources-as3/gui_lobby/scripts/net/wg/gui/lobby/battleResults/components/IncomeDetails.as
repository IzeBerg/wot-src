package net.wg.gui.lobby.battleResults.components
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
   import net.wg.infrastructure.interfaces.IImage;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class IncomeDetails extends IncomeDetailsBase
   {
      
      private static var INFO_OFFSET_X:int = 6;
      
      private static var INFO_OFFSET_Y:int = -14;
       
      
      public var col1:TextField;
      
      public var col2:TextField;
      
      public var col3:TextField;
      
      public var col4:TextField;
      
      private var _utilityTF:TextField = null;
      
      private var _infoList:Vector.<IImage>;
      
      private var _tooltipList:Vector.<String>;
      
      public function IncomeDetails()
      {
         this._infoList = new Vector.<IImage>();
         this._tooltipList = new Vector.<String>();
         super();
      }
      
      override public function setColumnsAlpha(param1:Number, param2:Number) : void
      {
         this.col1.alpha = param1;
         this.col2.alpha = param1;
         this.col3.alpha = param2;
         this.col4.alpha = param2;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setVerticalAlign(this.col1,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(this.col2,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(this.col3,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(this.col4,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(label,TextFieldEx.VALIGN_TOP);
      }
      
      override protected function onDispose() : void
      {
         this.col1 = null;
         this.col2 = null;
         this.col3 = null;
         this.col4 = null;
         this.clearInfo();
         this._infoList = null;
         this._tooltipList = null;
         this._utilityTF = null;
         super.onDispose();
      }
      
      override protected function initColumns() : Vector.<TextField>
      {
         return new <TextField>[this.col1,this.col2,this.col3,this.col4];
      }
      
      override public function setData(param1:Vector.<DetailedStatsItemVO>) : void
      {
         this.clearInfo();
         super.setData(param1);
      }
      
      override protected function setColumnsData(param1:DetailedStatsItemVO) : void
      {
         this.col1.htmlText += param1.col1;
         this.col2.htmlText += param1.col2;
         this.col3.htmlText += param1.col3;
         this.col4.htmlText += param1.col4;
         this.addTooltipInfo(param1);
      }
      
      private function addTooltipInfo(param1:DetailedStatsItemVO) : void
      {
         var _loc2_:Image = null;
         if(!StringUtils.isEmpty(param1.tooltip))
         {
            if(this._utilityTF == null)
            {
               this._utilityTF = new TextField();
               this._utilityTF.autoSize = TextFieldAutoSize.LEFT;
            }
            _loc2_ = new Image();
            _loc2_.source = RES_ICONS.MAPS_ICONS_LIBRARY_NOTIF_FILTERS_INFORMATION_16X16;
            _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onInfoMouseOverHandler);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.onInfoMouseOutHandler);
            addChild(_loc2_);
            this._infoList.push(_loc2_);
            this._tooltipList.push(param1.tooltip);
            this._utilityTF.htmlText = param1.label;
            this._utilityTF.setTextFormat(label.getTextFormat());
            _loc2_.x = label.x + this._utilityTF.textWidth + INFO_OFFSET_X | 0;
            _loc2_.y = label.y + label.textHeight + INFO_OFFSET_Y | 0;
         }
      }
      
      private function clearInfo() : void
      {
         var _loc1_:IImage = null;
         for each(_loc1_ in this._infoList)
         {
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onInfoMouseOverHandler);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onInfoMouseOutHandler);
            _loc1_.dispose();
            removeChild(_loc1_ as DisplayObject);
         }
         this._infoList.length = 0;
         this._tooltipList.length = 0;
      }
      
      private function onInfoMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc2_:IImage = param1.target as IImage;
         if(_loc2_)
         {
            _loc3_ = this._infoList.indexOf(_loc2_);
            if(_loc3_ >= 0)
            {
               _loc4_ = this._tooltipList[_loc3_];
               App.toolTipMgr.show(_loc4_);
            }
         }
      }
      
      private function onInfoMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
