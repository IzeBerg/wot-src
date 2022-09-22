package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.VO.ToolTipLadderRegulationsVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ToolTipLadderRegulations extends ToolTipSpecial
   {
      
      private static const PADDING:int = 16;
      
      private static const SECTION_PADDING:int = 10;
      
      private static const BOTTOM_PADDING:int = 30;
       
      
      private var _hasRules:Boolean = false;
      
      private var _whiteBg:Sprite = null;
      
      private var _lblHeader:TextField = null;
      
      private var _lblThisRules:TextField = null;
      
      private var _lblRules:TextField = null;
      
      private var _lblAllRules:TextField = null;
      
      private var _lblInfo:TextField = null;
      
      private var _separatorTop:Separator = null;
      
      private var _separatorMiddle:Separator = null;
      
      private var _separatorBottom:Separator = null;
      
      public function ToolTipLadderRegulations()
      {
         super();
         this._lblInfo = content.lblInfo;
         this._lblAllRules = content.lblAllRules;
         this._lblRules = content.lblRules;
         this._lblHeader = content.lblHeader;
         this._lblThisRules = content.lblThisRules;
         this._whiteBg = content.whiteBg;
         this._separatorTop = Utils.instance.createSeparate(content);
         this._separatorMiddle = Utils.instance.createSeparate(content);
         this._separatorBottom = Utils.instance.createSeparate(content);
         separators = new <Separator>[this._separatorTop,this._separatorMiddle,this._separatorBottom];
      }
      
      override protected function redraw() : void
      {
         this.applyData();
         this.updatePositions();
         super.redraw();
         this.updateWhiteBg();
         background.height += BOTTOM_PADDING;
      }
      
      override protected function updatePositions() : void
      {
         var _loc1_:int = 0;
         this._separatorTop.y = this._lblHeader.y + this._lblHeader.height + PADDING;
         this._lblThisRules.y = this._separatorTop.y + PADDING;
         this._separatorMiddle.y = this._lblThisRules.y + this._lblThisRules.height + PADDING;
         if(this._hasRules)
         {
            this._lblRules.y = this._separatorMiddle.y + PADDING;
            this._lblAllRules.y = this._lblRules.y + this._lblRules.height + SECTION_PADDING;
            this._separatorBottom.y = this._lblAllRules.y + this._lblAllRules.height + PADDING;
            _loc1_ = this._separatorBottom.y;
         }
         else
         {
            this._separatorBottom.visible = false;
            _loc1_ = this._separatorMiddle.y;
         }
         _loc1_ += PADDING;
         this._lblInfo.y = _loc1_;
         super.updatePositions();
      }
      
      override protected function onDispose() : void
      {
         this._whiteBg = null;
         this._lblHeader = null;
         this._lblThisRules = null;
         this._lblRules = null;
         this._lblAllRules = null;
         this._lblInfo = null;
         this._separatorTop = null;
         this._separatorMiddle = null;
         this._separatorBottom = null;
         super.onDispose();
      }
      
      protected function applyData() : void
      {
         var _loc1_:ToolTipLadderRegulationsVO = new ToolTipLadderRegulationsVO(_data);
         this._lblHeader.htmlText = _loc1_.name;
         this._lblThisRules.htmlText = _loc1_.thisRules;
         App.utils.commons.updateTextFieldSize(this._lblThisRules);
         this._lblRules.htmlText = _loc1_.rulesName;
         this._lblAllRules.htmlText = _loc1_.allRules;
         App.utils.commons.updateTextFieldSize(this._lblAllRules);
         this._lblInfo.htmlText = _loc1_.info;
         App.utils.commons.updateTextFieldSize(this._lblInfo);
         this._hasRules = _loc1_.hasRules;
         _loc1_.dispose();
      }
      
      private function updateWhiteBg() : void
      {
         this._whiteBg.height = this._separatorMiddle.y - this._separatorTop.y;
         this._whiteBg.y = this._separatorTop.y;
         this._whiteBg.width = background.width;
      }
   }
}
