package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UnitCommanderStats;
   import net.wg.gui.components.tooltips.VO.UnitCommandVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.utils.ILocale;
   
   public class TooltipUnitCommand extends ToolTipSpecial
   {
      
      private static const TANK_ICON_WIDTH:int = 29;
      
      private static const TANK_ICON_HEIGHT:int = 12;
      
      private static const TANK_ICON_VERTICAL_SPACE:int = 0;
      
      private static const NOT_ENOUGH_FONT_SIZE:int = 13;
      
      private static const DESCRIPTION_VERTICAL_SPACE:int = 10;
      
      private static const NOT_ENOUGH_VERTICAL_SPACE:int = 5;
      
      private static const HEADER_VERTICAL_SPACE:int = 5;
      
      private static const HEADER_FONT_SIZE:int = 18;
       
      
      public var headerTF:TextField = null;
      
      public var notEnoughTF:TextField = null;
      
      public var whiteBg:Sprite = null;
      
      public var alertSuitable:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var actionTF:TextField = null;
      
      public var commanderStats:UnitCommanderStats = null;
      
      public function TooltipUnitCommand()
      {
         super();
         this.headerTF = content.headerTF;
         this.notEnoughTF = content.notEnoughTF;
         this.whiteBg = content.whiteBg;
         this.alertSuitable = content.alertSuitable;
         this.commanderStats = content.commanderStats;
         this.descriptionTF = content.descriptionTF;
         this.actionTF = content.actionTF;
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipUnitCommand " + name + "]";
      }
      
      override protected function redraw() : void
      {
         var _loc4_:String = null;
         var _loc1_:ILocale = App.utils.locale;
         var _loc2_:UnitCommandVO = new UnitCommandVO(_data);
         separators = new Vector.<Separator>();
         topPosition += this.setHeader(_loc2_.commanderName);
         this.addSeparatorWithMargin();
         this.commanderStats.y = topPosition ^ 0;
         this.commanderStats.x = bgShadowMargin.left;
         this.commanderStats.update(_loc2_);
         topPosition += this.commanderStats.height + Utils.instance.MARGIN_AFTER_BLOCK;
         var _loc3_:Separator = this.addSeparatorWithMargin();
         if(_loc2_.unitComment)
         {
            this.whiteBg.y = _loc3_.y;
            this.whiteBg.visible = true;
            this.descriptionTF.y = topPosition ^ 0;
            this.descriptionTF.x = contentMargin.left + bgShadowMargin.left;
            this.descriptionTF.htmlText = _loc2_.unitComment;
            this.descriptionTF.height = this.descriptionTF.textHeight + DESCRIPTION_VERTICAL_SPACE;
            topPosition += this.descriptionTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
            this.addSeparatorWithMargin();
         }
         this.whiteBg.height = topPosition - this.whiteBg.y - Utils.instance.MARGIN_AFTER_SEPARATE;
         if(_loc2_.conditions && _loc2_.vehiclesList && _loc2_.vehiclesList.length > 0)
         {
            _loc4_ = App.utils.getHtmlIconTextS(App.utils.getImageUrlProperties(RES_ICONS.MAPS_ICONS_LIBRARY_CYBERSPORT_TANKICON,TANK_ICON_WIDTH,TANK_ICON_HEIGHT,TANK_ICON_VERTICAL_SPACE));
            this.notEnoughTF.htmlText = Utils.instance.htmlWrapper(_loc1_.makeString(TOOLTIPS.SUITABLEVEHICLE_MATCHES),Utils.instance.COLOR_NORMAL,NOT_ENOUGH_FONT_SIZE,"$FieldFont") + " " + Utils.instance.htmlWrapper((_loc2_.vehiclesList.length + _loc2_.leftCount).toString(),Utils.instance.COLOR_NUMBER,NOT_ENOUGH_FONT_SIZE,"$TitleFont") + " " + _loc4_;
            this.notEnoughTF.height = this.notEnoughTF.textHeight + NOT_ENOUGH_VERTICAL_SPACE;
            this.notEnoughTF.y = topPosition ^ 0;
            this.notEnoughTF.x = bgShadowMargin.left + contentMargin.left;
            this.notEnoughTF.visible = true;
            topPosition += this.notEnoughTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
            this.addSeparatorWithMargin();
         }
         if(_loc2_.isPeripheryAnother)
         {
            this.alertSuitable.multiline = true;
            this.alertSuitable.wordWrap = true;
            this.alertSuitable.autoSize = TextFieldAutoSize.CENTER;
            this.alertSuitable.text = TOOLTIPS.CYBERSPORT_ALERT_ONANOTHERSERVER;
            this.alertSuitable.visible = true;
            this.alertSuitable.x = contentMargin.left + bgShadowMargin.left;
            this.alertSuitable.y = topPosition ^ 0;
            topPosition += this.alertSuitable.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
            this.addSeparatorWithMargin();
         }
         this.actionTF.y = topPosition ^ 0;
         this.actionTF.x = contentMargin.left + bgShadowMargin.left;
         this.actionTF.text = TOOLTIPS.CYBERSPORT_UNITCOMMAND_ACTION;
         _loc2_.dispose();
         _loc2_ = null;
         updatePositions();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         if(this.whiteBg.visible)
         {
            this.whiteBg.width = contentWidth + bgShadowMargin.horizontal;
         }
      }
      
      override protected function onDispose() : void
      {
         this.headerTF = null;
         this.notEnoughTF = null;
         this.whiteBg = null;
         this.alertSuitable = null;
         this.descriptionTF = null;
         this.actionTF = null;
         this.commanderStats.dispose();
         this.commanderStats = null;
         super.onDispose();
      }
      
      private function setHeader(param1:String) : Number
      {
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.CYBERSPORT_UNIT_COMMAND) + " " + param1,Utils.instance.COLOR_HEADER,HEADER_FONT_SIZE,"$TitleFont");
         this.headerTF.width = this.headerTF.textWidth + HEADER_VERTICAL_SPACE;
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition ^ 0;
         return this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
      }
      
      private function addSeparatorWithMargin() : Separator
      {
         var _loc1_:Separator = Utils.instance.createSeparate(content);
         _loc1_.y = topPosition ^ 0;
         separators.push(_loc1_);
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         return _loc1_;
      }
   }
}
