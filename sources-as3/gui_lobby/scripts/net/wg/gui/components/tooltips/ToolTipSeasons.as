package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.ToolTipSeasonsVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.events.UILoaderEvent;
   
   public class ToolTipSeasons extends ToolTipSpecial
   {
      
      public static const _NEWLINE:String = "<br/>";
      
      public static const _TITLE_FONT:String = "$TitleFont";
      
      public static const _FIELD_FONT:String = "$FieldFont";
       
      
      public var headerTF:TextField = null;
      
      public var seasonsIco:UILoaderAlt = null;
      
      public var whiteBg:Sprite = null;
      
      private var _dataVO:ToolTipSeasonsVO = null;
      
      private var _TOOLTIP_WIDTH:Number = 320;
      
      public function ToolTipSeasons()
      {
         super();
         this.headerTF = content.headerTF;
         this.seasonsIco = content.seasonsIco;
         this.whiteBg = content.whiteBg;
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         super.build(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.seasonsIco.hasEventListener(UILoaderEvent.COMPLETE))
         {
            this.seasonsIco.removeEventListener(UILoaderEvent.COMPLETE,this.onIcoLoadedCompleteHandler);
         }
         this.headerTF = null;
         this.seasonsIco.dispose();
         this.seasonsIco = null;
         this.whiteBg = null;
         if(this._dataVO)
         {
            this._dataVO.dispose();
            this._dataVO = null;
         }
         super.onDispose();
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipSeasons]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function redraw() : void
      {
         this._dataVO = new ToolTipSeasonsVO(_data);
         this.seasonsIco.autoSize = false;
         this.seasonsIco.maintainAspectRatio = false;
         this.seasonsIco.addEventListener(UILoaderEvent.COMPLETE,this.onIcoLoadedCompleteHandler);
         this.seasonsIco.source = this._dataVO.seasonImage;
         var _loc1_:String = App.utils.locale.makeString(this._dataVO.header);
         var _loc2_:String = App.utils.locale.makeString(this._dataVO.body);
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc1_,Utils.instance.COLOR_HEADER,18,_TITLE_FONT) + _NEWLINE + Utils.instance.htmlWrapper(_loc2_,Utils.instance.COLOR_NORMAL,12,_FIELD_FONT);
         this.seasonsIco.x = 0;
         this.seasonsIco.y = 0;
         this.headerTF.x = 0;
         this.headerTF.y = 0;
         this.whiteBg.x = 0;
         this.whiteBg.y = 0;
         this._dataVO = null;
         updatePositions();
         super.updatePositions();
         super.redraw();
      }
      
      private function onIcoLoadedCompleteHandler(param1:UILoaderEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this.seasonsIco.hasEventListener(UILoaderEvent.COMPLETE))
         {
            this.seasonsIco.removeEventListener(UILoaderEvent.COMPLETE,this.onIcoLoadedCompleteHandler);
         }
         _loc2_ = contentMargin.left;
         this.seasonsIco.x = contentMargin.left + bgShadowMargin.left;
         this.seasonsIco.y = contentMargin.top + bgShadowMargin.top;
         this.headerTF.x = this.seasonsIco.x + this.seasonsIco.width + _loc2_;
         this.headerTF.y = this.seasonsIco.y;
         this.headerTF.width = this._TOOLTIP_WIDTH - this.headerTF.x - contentMargin.right;
         background.width = this._TOOLTIP_WIDTH;
         background.height = Math.max(this.headerTF.textHeight,this.seasonsIco.height) + contentMargin.top + bgShadowMargin.top + contentMargin.bottom + bgShadowMargin.bottom;
         var _loc3_:Number = 1;
         this.whiteBg.x = bgShadowMargin.left + _loc3_;
         this.whiteBg.y = bgShadowMargin.top;
         this.whiteBg.width = this._TOOLTIP_WIDTH - bgShadowMargin.horizontal - _loc3_ * 2;
         this.whiteBg.height = background.height - bgShadowMargin.vertical - _loc3_ * 2;
      }
   }
}
