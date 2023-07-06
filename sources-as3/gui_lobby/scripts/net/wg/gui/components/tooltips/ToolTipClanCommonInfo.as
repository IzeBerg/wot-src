package net.wg.gui.components.tooltips
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.VO.FortClanCommonInfoVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.utils.ICommons;
   import scaleform.clik.utils.Padding;
   
   public class ToolTipClanCommonInfo extends ToolTipSpecial
   {
      
      private static const SEPARATOR_OFFSET:int = 19;
      
      private static const SEPARATOR_HEIGHT:int = 6;
      
      private static const BOTTOM_TEXTS_OFFSET:int = 19;
      
      private static const MARGIN_BETWEEN_INFO_AND_DESCRIPTION:int = 12;
      
      private static const RIGHT_STAT_POS:int = 60;
      
      private static const MAX_WIDTH:int = 340;
      
      private static const ACTIVITY_BG_X_OFFSET:int = 6;
      
      private static const ACTIVITY_BG_Y_OFFSET:int = 4;
      
      private static const TOOLTIP_MARGIN:int = 20;
      
      private static const TOOLTIP_TOP_MARGIN:int = 17;
      
      private static const TOOLTIP_LEFT_MARGIN:int = 21;
       
      
      public var titleTF:TextField = null;
      
      public var sloganTF:TextField = null;
      
      public var statValuesTF:TextField = null;
      
      public var statDescriptionTF:TextField = null;
      
      public var bottomInfoTF:TextField = null;
      
      public var activityBg:DisplayObject = null;
      
      private var _nextComponentPosition:int = 0;
      
      private var _commons:ICommons = null;
      
      private var _utils:Utils = null;
      
      public function ToolTipClanCommonInfo()
      {
         super();
         contentMargin = new Padding(TOOLTIP_TOP_MARGIN,TOOLTIP_MARGIN,TOOLTIP_MARGIN,TOOLTIP_LEFT_MARGIN);
         this._utils = Utils.instance;
         this._commons = App.utils.commons;
         this.titleTF = content.titleTF;
         this.sloganTF = content.sloganTF;
         this.statValuesTF = content.statValuesTF;
         this.statDescriptionTF = content.statDescriptionTF;
         this.bottomInfoTF = content.bottomInfoTF;
         this.activityBg = content.activityBg;
         separators = new Vector.<Separator>();
      }
      
      override protected function redraw() : void
      {
         this.applyData();
         this.updatePositions();
         super.redraw();
      }
      
      override protected function updatePositions() : void
      {
         this._nextComponentPosition = contentMargin.top;
         this.activityBg.x = ACTIVITY_BG_X_OFFSET;
         this.activityBg.y = ACTIVITY_BG_Y_OFFSET;
         this.layoutNextTextField(this.titleTF,true);
         this.layoutNextTextField(this.sloganTF,true);
         this.layoutNextTextField(this.statValuesTF,true);
         this._commons.updateTextFieldSize(this.statDescriptionTF);
         this.statValuesTF.x += RIGHT_STAT_POS - this.statValuesTF.width >> 0;
         this.statDescriptionTF.x = this.statValuesTF.x + this.statValuesTF.width + MARGIN_BETWEEN_INFO_AND_DESCRIPTION >> 0;
         this.statDescriptionTF.y = this.statValuesTF.y >> 0;
         this.layoutNextTextField(this.bottomInfoTF,true,BOTTOM_TEXTS_OFFSET);
         super.updatePositions();
      }
      
      override protected function updateSize() : void
      {
         background.width = MAX_WIDTH;
         background.height = this.bottomInfoTF.y + this.bottomInfoTF.height + contentMargin.bottom;
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.sloganTF = null;
         this.statValuesTF = null;
         this.statDescriptionTF = null;
         this.bottomInfoTF = null;
         this.activityBg = null;
         this._commons = null;
         this._utils = null;
         super.onDispose();
      }
      
      private function applyData() : void
      {
         var _loc1_:FortClanCommonInfoVO = new FortClanCommonInfoVO(_data);
         App.utils.commons.truncateTextFieldText(this.titleTF,_loc1_.clanName);
         this.sloganTF.htmlText = _loc1_.slogan;
         this.statValuesTF.htmlText = _loc1_.statValues;
         this.statDescriptionTF.htmlText = _loc1_.statDescriptions;
         this.bottomInfoTF.htmlText = _loc1_.bottomInfoText;
         this.activityBg.visible = _loc1_.isClanActive;
         _loc1_.dispose();
      }
      
      private function layoutNextTextField(param1:TextField, param2:Boolean = false, param3:int = 19) : void
      {
         var _loc4_:Separator = null;
         this._commons.updateTextFieldSize(param1);
         param1.x = contentMargin.left >> 0;
         param1.y = this._nextComponentPosition >> 0;
         this._nextComponentPosition += param1.textHeight + param3;
         if(param2)
         {
            _loc4_ = this._utils.createSeparate(content);
            _loc4_.y = this._nextComponentPosition >> 0;
            separators.push(_loc4_);
            this._nextComponentPosition += param3 - SEPARATOR_HEIGHT;
         }
      }
   }
}
