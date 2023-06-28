package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.VO.FortClanInfoVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ToolTipClanInfo extends ToolTipSpecial
   {
      
      private static const MARGIN_BETWEEN_INFO_AND_DESCRIPTION:int = 12;
      
      private static const MARGIN_BETWEEN_SLOGAN_AND_INFO:int = 20;
      
      private static const SEPARATOR_PADDING:int = 20;
      
      private static const SEPARATORS_COUNT:int = 3;
      
      private static const FORT_CREATION_DATE_PADDING:int = 30;
      
      private static const PROTECTION_BLOCK_PADDING:int = 24;
      
      private static const INFO_BLOCK_TOP_SEPARATOR:int = 0;
      
      private static const INFO_BLOCK_BOTTOM_SEPARATOR:int = 1;
      
      private static const DEFENSE_INFO_SEPARATOR:int = 2;
       
      
      private var _headerTF:TextField;
      
      private var _fullClanNameTF:TextField;
      
      private var _sloganTF:TextField;
      
      private var _infoTopTF:TextField;
      
      private var _infoDescriptionTopTF:TextField;
      
      private var _protectionHeaderTF:TextField;
      
      private var _infoTF:TextField;
      
      private var _fortCreationDateFT:TextField;
      
      private var _icon:UILoaderAlt;
      
      private var _whiteBg:Sprite;
      
      private var _isDefenseSeparatorVisible:Boolean = false;
      
      public function ToolTipClanInfo()
      {
         super();
         separators = new Vector.<Separator>();
         this._icon = content.icon;
         this._whiteBg = content.whiteBg;
         this.initTextFields();
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         this.configTextFields();
         this.createSeparators();
         super.build(param1,param2);
      }
      
      override protected function redraw() : void
      {
         this.applyData();
         this.updatePositions();
         super.redraw();
      }
      
      override protected function updatePositions() : void
      {
         this.alignBlocks();
         this.updateSeparators();
         this.updateWhiteBg();
         super.updatePositions();
      }
      
      override protected function onDispose() : void
      {
         this._icon.dispose();
         this._icon = null;
         this._whiteBg = null;
         this._headerTF = null;
         this._fullClanNameTF = null;
         this._sloganTF = null;
         this._infoTopTF = null;
         this._infoDescriptionTopTF = null;
         this._protectionHeaderTF = null;
         this._infoTF = null;
         this._fortCreationDateFT = null;
         super.onDispose();
      }
      
      protected function applyData() : void
      {
         var _loc1_:FortClanInfoVO = new FortClanInfoVO(_data);
         this._headerTF.htmlText = _loc1_.headerText;
         this._fullClanNameTF.htmlText = _loc1_.fullClanName;
         this._sloganTF.htmlText = _loc1_.sloganText;
         this._infoTopTF.htmlText = _loc1_.infoTopText;
         this._infoDescriptionTopTF.htmlText = _loc1_.infoDescriptionTopText;
         this._protectionHeaderTF.htmlText = _loc1_.protectionHeaderText;
         this._infoTF.htmlText = _loc1_.infoText;
         this._fortCreationDateFT.htmlText = _loc1_.fortCreationDate;
         _loc1_.dispose();
      }
      
      private function initTextFields() : void
      {
         this._headerTF = content.headerTF;
         this._fullClanNameTF = content.fullClanNameTF;
         this._sloganTF = content.sloganTF;
         this._infoTopTF = content.infoTopTF;
         this._infoDescriptionTopTF = content.infoDescriptionTopTF;
         this._protectionHeaderTF = content.protectionHeaderTF;
         this._infoTF = content.infoTF;
         this._fortCreationDateFT = content.fortCreationDateFT;
      }
      
      private function updateWhiteBg() : void
      {
         this._whiteBg.y = this._infoTopTF.y - Utils.instance.MARGIN_AFTER_SEPARATE;
         this._whiteBg.width = background.width;
         this._whiteBg.height = separators[INFO_BLOCK_BOTTOM_SEPARATOR].y - this._whiteBg.y;
      }
      
      private function createSeparators() : void
      {
         var _loc1_:Separator = null;
         var _loc2_:int = 0;
         while(_loc2_ < SEPARATORS_COUNT)
         {
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.visible = true;
            separators.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function configTextFields() : void
      {
         this._headerTF.autoSize = TextFieldAutoSize.LEFT;
         this._fullClanNameTF.autoSize = TextFieldAutoSize.LEFT;
         this._sloganTF.autoSize = TextFieldAutoSize.LEFT;
         this._infoTopTF.autoSize = TextFieldAutoSize.RIGHT;
         this._infoDescriptionTopTF.autoSize = TextFieldAutoSize.LEFT;
         this._protectionHeaderTF.autoSize = TextFieldAutoSize.LEFT;
         this._infoTF.autoSize = TextFieldAutoSize.LEFT;
         this._fortCreationDateFT.autoSize = TextFieldAutoSize.LEFT;
      }
      
      private function updateSeparators() : void
      {
         var _loc2_:Separator = null;
         var _loc1_:int = 0;
         while(_loc1_ < SEPARATORS_COUNT)
         {
            _loc2_ = separators[_loc1_];
            switch(_loc1_)
            {
               case INFO_BLOCK_TOP_SEPARATOR:
                  _loc2_.y = this._infoTopTF.y - Utils.instance.MARGIN_AFTER_SEPARATE;
                  break;
               case INFO_BLOCK_BOTTOM_SEPARATOR:
                  _loc2_.y = this._infoTopTF.y + this._infoTopTF.height + Utils.instance.MARGIN_AFTER_SEPARATE;
                  break;
               case DEFENSE_INFO_SEPARATOR:
                  if(this._isDefenseSeparatorVisible)
                  {
                     _loc2_.y = this._infoTF.y + this._infoTF.height + SEPARATOR_PADDING;
                  }
                  _loc2_.visible = this._isDefenseSeparatorVisible;
                  break;
            }
            _loc1_++;
         }
      }
      
      private function alignBlocks() : void
      {
         var _loc1_:int = 0;
         App.utils.commons.updateTextFieldSize(this._fullClanNameTF,false,true);
         App.utils.commons.updateTextFieldSize(this._sloganTF,false,true);
         App.utils.commons.updateTextFieldSize(this._infoTopTF,false,true);
         App.utils.commons.updateTextFieldSize(this._infoDescriptionTopTF,false,true);
         if(this._infoTopTF.x < this._headerTF.x)
         {
            _loc1_ = this._infoTopTF.width;
            this._infoTopTF.x = this._headerTF.x + _loc1_ - this._infoTopTF.width;
            this._infoDescriptionTopTF.x = this._infoTopTF.x + this._infoTopTF.width + MARGIN_BETWEEN_INFO_AND_DESCRIPTION;
         }
         this._sloganTF.y = this._fullClanNameTF.y + this._fullClanNameTF.height;
         this._infoTopTF.y = this._infoDescriptionTopTF.y = this._sloganTF.y + this._sloganTF.height + MARGIN_BETWEEN_SLOGAN_AND_INFO;
         this.alignDefenseBlocks();
      }
      
      private function alignDefenseBlocks() : void
      {
         this._isDefenseSeparatorVisible = true;
         if(StringUtils.isEmpty(this._infoTF.htmlText) && StringUtils.isEmpty(this._protectionHeaderTF.htmlText))
         {
            this._infoTF.visible = false;
            this._protectionHeaderTF.visible = false;
            this._protectionHeaderTF.y = this._protectionHeaderTF.height = 0;
            this._infoTF.y = this._infoTF.height = 0;
            if(StringUtils.isNotEmpty(this._fortCreationDateFT.htmlText))
            {
               this._fortCreationDateFT.y = this._infoDescriptionTopTF.y + this._infoDescriptionTopTF.height + FORT_CREATION_DATE_PADDING;
            }
            else
            {
               this._fortCreationDateFT.y = this._fortCreationDateFT.height = 0;
            }
            this._isDefenseSeparatorVisible = false;
         }
         else
         {
            App.utils.commons.updateTextFieldSize(this._infoTF,false,true);
            this._protectionHeaderTF.y = this._infoDescriptionTopTF.y + this._infoDescriptionTopTF.height + PROTECTION_BLOCK_PADDING;
            this._infoTF.y = this._protectionHeaderTF.y + this._protectionHeaderTF.height;
            if(StringUtils.isNotEmpty(this._fortCreationDateFT.htmlText))
            {
               this._fortCreationDateFT.y = this._infoTF.y + this._infoTF.height + FORT_CREATION_DATE_PADDING;
            }
            else
            {
               this._isDefenseSeparatorVisible = false;
               this._fortCreationDateFT.y = this._fortCreationDateFT.height = 0;
            }
            this._infoTF.visible = true;
            this._protectionHeaderTF.visible = true;
         }
      }
   }
}
