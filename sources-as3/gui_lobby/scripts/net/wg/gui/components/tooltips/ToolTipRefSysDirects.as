package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.minimap.MinimapPresentation;
   import net.wg.gui.components.tooltips.VO.ToolTipRefSysDirectsVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.utils.ILocale;
   
   public class ToolTipRefSysDirects extends ToolTipSpecial
   {
      
      private static const BG_WIDTH:int = 300;
      
      private static const BG_HEIGHT:int = 348;
      
      private static const MAP_HEIGHT:int = 260;
      
      private static const ICON_OFFSET:int = 5;
      
      private static const DIR_OFFSET:int = 20;
      
      private static const TEXT_OFFSET:int = 42;
      
      private static const SEPARATE1_POS_Y:int = 69;
      
      private static const SEPARATE2_POS_Y:int = 559;
       
      
      private var _minimap:MinimapPresentation = null;
      
      private var _infoTitleTF:TextField = null;
      
      private var _infoDirectionTF:TextField = null;
      
      private var _infoMapNameTF:TextField = null;
      
      private var _infoTotalValueTF:TextField = null;
      
      private var _infoDescription1TF:TextField = null;
      
      private var _infoValue1TF:TextField = null;
      
      private var _infoDescription2TF:TextField = null;
      
      private var _infoValue2TF:TextField = null;
      
      private var _infoDescription3TF:TextField = null;
      
      private var _infoValue3TF:TextField = null;
      
      private var _infoTotalDescriptionTF:TextField = null;
      
      private var _infoBack:Sprite = null;
      
      private var _infoIconTotalValue:Sprite = null;
      
      private var _infoIconValue1:Sprite = null;
      
      private var _infoIconValue2:Sprite = null;
      
      private var _infoIconValue3:Sprite = null;
      
      private var _model:ToolTipRefSysDirectsVO = null;
      
      public function ToolTipRefSysDirects()
      {
         super();
         separators = new Vector.<Separator>();
         this._minimap = content.minimap;
         this._infoTitleTF = content.infoTitleTF;
         this._infoDirectionTF = content.infoDirectionTF;
         this._infoMapNameTF = content.infoMapNameTF;
         this._infoTotalValueTF = content.infoTotalValueTF;
         this._infoDescription1TF = content.infoDescription1TF;
         this._infoValue1TF = content.infoValue1TF;
         this._infoDescription2TF = content.infoDescription2TF;
         this._infoValue2TF = content.infoValue2TF;
         this._infoDescription3TF = content.infoDescription3TF;
         this._infoValue3TF = content.infoValue3TF;
         this._infoTotalDescriptionTF = content.infoTotalDescriptionTF;
         this._infoBack = content.infoBack;
         this._infoIconTotalValue = content.infoIconTotalValue;
         this._infoIconValue1 = content.infoIconValue1;
         this._infoIconValue2 = content.infoIconValue2;
         this._infoIconValue3 = content.infoIconValue3;
      }
      
      override protected function onDispose() : void
      {
         this._minimap = null;
         this._infoTitleTF = null;
         this._infoDirectionTF = null;
         this._infoMapNameTF = null;
         this._infoTotalValueTF = null;
         this._infoDescription1TF = null;
         this._infoValue1TF = null;
         this._infoDescription2TF = null;
         this._infoValue2TF = null;
         this._infoDescription3TF = null;
         this._infoValue3TF = null;
         this._infoTotalDescriptionTF = null;
         this._infoBack = null;
         this._infoIconTotalValue = null;
         this._infoIconValue1 = null;
         this._infoIconValue2 = null;
         this._infoIconValue3 = null;
         this.tryDisposeModel();
         super.onDispose();
      }
      
      override protected function redraw() : void
      {
         this.setData();
         this.updatePositions();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         background.width = BG_WIDTH;
         background.height = BG_HEIGHT + (!!this._model.isMapEnabled ? MAP_HEIGHT : 0) + this._infoMapNameTF.textHeight;
         if(!this._model.infoDirection.length)
         {
            background.height -= DIR_OFFSET;
         }
         if(!this._model.infoValue1.length)
         {
            background.height -= TEXT_OFFSET;
         }
         if(!this._model.infoValue2.length)
         {
            background.height -= TEXT_OFFSET;
         }
         if(!this._model.infoValue3.length)
         {
            background.height -= TEXT_OFFSET;
         }
      }
      
      private function offsetDescription1(param1:int) : void
      {
         this._infoDescription1TF.y -= param1;
         this._infoValue1TF.y -= param1;
         this._infoIconValue1.y -= param1;
      }
      
      private function offsetDescription2(param1:int) : void
      {
         this._infoDescription2TF.y -= param1;
         this._infoValue2TF.y -= param1;
         this._infoIconValue2.y -= param1;
      }
      
      private function offsetDescription3(param1:int) : void
      {
         this._infoDescription3TF.y -= param1;
         this._infoValue3TF.y -= param1;
         this._infoIconValue3.y -= param1;
      }
      
      override protected function updatePositions() : void
      {
         var _loc3_:Separator = null;
         var _loc1_:int = !this._model.infoDirection.length ? int(DIR_OFFSET) : int(0);
         this._infoMapNameTF.y -= _loc1_;
         this._minimap.y += this._infoMapNameTF.textHeight - _loc1_;
         var _loc2_:int = (!this._model.isMapEnabled ? MAP_HEIGHT : 0) - this._infoMapNameTF.textHeight + _loc1_;
         this._infoBack.y -= _loc2_;
         this._infoTotalValueTF.y -= _loc2_;
         this._infoIconTotalValue.x = this._infoTotalValueTF.x + (this._infoTotalValueTF.width - this._infoTotalValueTF.textWidth) / 2 - this._infoIconTotalValue.width - ICON_OFFSET;
         this._infoIconTotalValue.y -= _loc2_;
         this.offsetDescription1(_loc2_);
         this.offsetDescription2(_loc2_);
         this.offsetDescription3(_loc2_);
         this._infoTotalDescriptionTF.y -= _loc2_;
         _loc3_ = Utils.instance.createSeparate(content);
         _loc3_.x = 0;
         _loc3_.y = SEPARATE1_POS_Y - _loc1_;
         _loc3_.width = BG_WIDTH;
         separators.push(_loc3_);
         _loc3_ = Utils.instance.createSeparate(content);
         _loc3_.x = 0;
         _loc3_.y = SEPARATE2_POS_Y - _loc2_;
         _loc3_.width = BG_WIDTH;
         separators.push(_loc3_);
         if(!this._model.infoValue1.length)
         {
            this._infoIconValue1.visible = false;
            this.offsetDescription2(TEXT_OFFSET);
            this.offsetDescription3(TEXT_OFFSET);
            this._infoTotalDescriptionTF.y -= TEXT_OFFSET;
            _loc3_.y -= TEXT_OFFSET;
         }
         if(!this._model.infoValue2.length)
         {
            this._infoIconValue2.visible = false;
            this.offsetDescription3(TEXT_OFFSET);
            this._infoTotalDescriptionTF.y -= TEXT_OFFSET;
            _loc3_.y -= TEXT_OFFSET;
         }
         if(!this._model.infoValue3.length)
         {
            this._infoIconValue3.visible = false;
            this._infoTotalDescriptionTF.y -= TEXT_OFFSET;
            _loc3_.y -= TEXT_OFFSET;
         }
         super.updatePositions();
      }
      
      private function tryDisposeModel() : void
      {
         if(this._model != null)
         {
            this._model.dispose();
            this._model = null;
         }
      }
      
      private function setData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         this.tryDisposeModel();
         var _loc1_:ILocale = App.utils.locale;
         this._model = new ToolTipRefSysDirectsVO(_data);
         this._infoTitleTF.htmlText = this._model.infoTitle;
         this._infoDirectionTF.htmlText = this._model.infoDirection;
         this._infoMapNameTF.htmlText = this._model.infoMapName;
         this._infoTotalValueTF.htmlText = Boolean(this._model.infoTotalValue) ? _loc1_.integer(this._model.infoTotalValue) : this._model.infoTotalValue;
         this._infoDescription1TF.htmlText = this._model.infoDescription1;
         this._infoValue1TF.htmlText = Boolean(this._model.infoValue1) ? _loc1_.integer(this._model.infoValue1) : this._model.infoValue1;
         this._infoDescription2TF.htmlText = this._model.infoDescription2;
         this._infoValue2TF.htmlText = Boolean(this._model.infoValue2) ? _loc1_.integer(this._model.infoValue2) : this._model.infoValue2;
         this._infoDescription3TF.htmlText = this._model.infoDescription3;
         this._infoValue3TF.htmlText = Boolean(this._model.infoValue3) ? _loc1_.integer(this._model.infoValue3) : this._model.infoValue3;
         this._infoTotalDescriptionTF.htmlText = this._model.infoTotalDescription;
         if(this._model.isMapEnabled)
         {
            this._minimap.as_changeMap(this._model.mapTexture);
            _loc2_ = this._model.mapPoints.length;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = this._model.mapPoints[_loc4_];
               this._minimap.as_addPoint(_loc3_.x,_loc3_.y,_loc3_.pointType,_loc3_.color,_loc3_.id);
               _loc4_++;
            }
         }
         else
         {
            this._minimap.visible = false;
         }
      }
   }
}
