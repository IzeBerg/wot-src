package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.tooltips.inblocks.data.SpriteTextBlockVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class SpriteTextBlockInBlocks extends BaseTooltipBlock
   {
       
      
      public var background:Sprite;
      
      public var titleTF:TextField;
      
      public var descriptionTF:TextField;
      
      public var content:Sprite;
      
      private var _blockWidth:int = 0;
      
      private var _data:SpriteTextBlockVO;
      
      private var _isDataApplied:Boolean = false;
      
      private var _originImageWidth:Number = 0;
      
      private var _originImageHeight:Number = 0;
      
      private var _originTitleWidth:Number = 0;
      
      private var _originTitleHeight:Number = 0;
      
      private var _originDescriptionWidth:Number = 0;
      
      private var _originDescriptionHeight:Number = 0;
      
      public function SpriteTextBlockInBlocks()
      {
         super();
         this.init();
      }
      
      protected function init() : void
      {
         this._originImageWidth = this.getContentWidth();
         this._originImageHeight = this.content.height;
         this._originTitleWidth = this.titleTF.width;
         this._originTitleHeight = this.titleTF.height;
         this._originDescriptionWidth = this.descriptionTF.width;
         this._originDescriptionHeight = this.descriptionTF.height;
      }
      
      override public function cleanUp() : void
      {
         this.cleanData();
         this.content.width = this._originImageWidth;
         this.content.height = this._originImageHeight;
         this.content.x = this.content.y = 0;
         this.titleTF.text = this.titleTF.htmlText = this.descriptionTF.text = this.descriptionTF.htmlText = null;
         this.titleTF.width = this._originTitleWidth;
         this.titleTF.height = this._originTitleHeight;
         this.descriptionTF.width = this._originDescriptionWidth;
         this.descriptionTF.height = this._originDescriptionHeight;
         this.descriptionTF.x = this.descriptionTF.y = 0;
         this._blockWidth = 0;
      }
      
      override public function getBg() : DisplayObject
      {
         return this.background;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.cleanData();
         this._data = SpriteTextBlockVO(this.getBlockVO(param1));
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
      }
      
      override protected function onDispose() : void
      {
         this.cleanUp();
         this.titleTF = null;
         this.descriptionTF = null;
         this.content = null;
         this.background = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         this.layout();
         return false;
      }
      
      protected function getBlockVO(param1:Object) : DAAPIDataClass
      {
         return new SpriteTextBlockVO(param1);
      }
      
      protected function getData() : DAAPIDataClass
      {
         return this._data;
      }
      
      protected function onLayoutText(param1:TextField, param2:int, param3:int, param4:PaddingVO, param5:Number) : void
      {
         var _loc6_:int = param4 != null ? int(param4.left - param4.right) : int(0);
         param1.x = param2 + _loc6_;
         param1.y = param3 + (param4 != null ? param4.top - param4.bottom : 0);
         if(this._blockWidth > 0)
         {
            param1.width = this._blockWidth - param1.x;
            if(!this._data.spriteAtLeft)
            {
               param1.width -= this.getImageWidth() - _loc6_;
            }
         }
         else
         {
            param1.width = param5;
         }
         App.utils.commons.updateTextFieldSize(param1,true,true);
      }
      
      override public function getWidth() : Number
      {
         return this._blockWidth > 0 ? Number(this._blockWidth) : Number(super.getWidth());
      }
      
      protected function onLayoutImage() : void
      {
         var _loc1_:PaddingVO = null;
         if(!this._data.spriteAtLeft && !this._data.snapImage)
         {
            if(this._blockWidth > 0 && this.content != null && this.content.visible)
            {
               _loc1_ = this._data.spritePadding;
               this.content.x = this._blockWidth - this.getContentWidth() - (_loc1_ != null ? _loc1_.right : 0) | 0;
            }
         }
      }
      
      protected function applyData() : void
      {
         this.applyTextData(this.titleTF,this._data.title);
         this.applyTextData(this.descriptionTF,this._data.description);
         this._isDataApplied = true;
      }
      
      protected function getContentWidth() : int
      {
         var _loc1_:int = 0;
         if(this.content != null && this.content.visible)
         {
            _loc1_ = this.content.width;
         }
         return _loc1_;
      }
      
      private function layout() : void
      {
         var _loc15_:TextFormat = null;
         var _loc1_:int = 0;
         var _loc2_:int = _loc1_;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = this._data.spriteAtLeft;
         var _loc7_:PaddingVO = this._data.spritePadding;
         var _loc8_:String = this._data.textsAlign;
         var _loc9_:int = this._data.textsOffset;
         var _loc10_:PaddingVO = this._data.descPadding;
         var _loc11_:PaddingVO = this._data.textsPadding;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Boolean = this._data.titleAtMiddle;
         if(_loc9_ >= 0)
         {
            _loc3_ = _loc4_ = _loc9_;
         }
         else if(_loc6_)
         {
            if(_loc8_ == TextFormatAlign.LEFT)
            {
               _loc3_ = _loc4_ = this.getImageWidth();
            }
            else if(_loc8_ == TextFormatAlign.RIGHT)
            {
               _loc3_ = this._blockWidth - this.titleTF.width;
               _loc4_ = this._blockWidth - this.descriptionTF.width;
            }
         }
         else if(_loc8_ == TextFormatAlign.LEFT)
         {
            _loc3_ = _loc4_ = 0;
         }
         else if(_loc8_ == TextFormatAlign.RIGHT)
         {
            _loc5_ = this._blockWidth - this.getImageWidth();
            _loc3_ = this.content.x - this.titleTF.width;
            _loc4_ = this.content.x - this.descriptionTF.width;
         }
         if(this.titleTF != null)
         {
            if(this.titleTF.visible)
            {
               this.onLayoutText(this.titleTF,_loc3_,_loc2_,_loc11_,this._originTitleWidth);
               _loc2_ += this.titleTF.height + this._data.textsGap;
               _loc12_ = this.titleTF.x + this.titleTF.width;
            }
            else
            {
               this.titleTF.x = this.titleTF.y = this.titleTF.width = this.titleTF.height = 0;
            }
         }
         if(this.descriptionTF != null && this.descriptionTF.text != Values.EMPTY_STR)
         {
            if(this.descriptionTF.visible)
            {
               _loc15_ = this.descriptionTF.getTextFormat();
               _loc15_.leading = this._data.descLeading;
               this.descriptionTF.setTextFormat(_loc15_);
               this.onLayoutText(this.descriptionTF,_loc4_,_loc2_,Boolean(_loc10_) ? _loc10_ : _loc11_,this._originDescriptionWidth);
               _loc13_ = this.descriptionTF.x + this.descriptionTF.width;
            }
            else
            {
               this.descriptionTF.x = this.descriptionTF.y = this.descriptionTF.width = this.descriptionTF.height = 0;
            }
         }
         if(this.content != null)
         {
            if(this.content.visible)
            {
               _loc5_ += _loc7_ != null ? _loc7_.left : 0;
               if(!_loc6_)
               {
                  _loc5_ += Math.max(_loc12_,_loc13_);
               }
               this.layoutImage(_loc5_,_loc1_,_loc7_);
            }
            else
            {
               this.content.x = this.content.y = this.content.width = this.content.height = 0;
            }
         }
         if(_loc14_ && this.titleTF != null && this.titleTF.visible)
         {
            this.titleTF.y = this.content.y + (this.content.height >> 1) - (this.titleTF.height >> 1);
         }
      }
      
      private function applyTextData(param1:TextField, param2:String) : void
      {
         if(param1 != null)
         {
            param1.visible = StringUtils.isNotEmpty(param2);
            if(param1.visible)
            {
               param1.htmlText = param2;
            }
         }
      }
      
      private function cleanData() : void
      {
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      private function getImageWidth() : int
      {
         var _loc2_:PaddingVO = null;
         var _loc1_:int = 0;
         if(this.content != null && this.content.visible)
         {
            _loc1_ = this.getContentWidth();
            _loc2_ = this._data.spritePadding;
            if(_loc2_ != null)
            {
               _loc1_ += _loc2_.left + _loc2_.right;
            }
         }
         return _loc1_;
      }
      
      private function layoutImage(param1:int, param2:int, param3:PaddingVO) : void
      {
         this.content.x = param1;
         this.content.y = param2 + (param3 != null ? param3.top : 0);
         this.onLayoutImage();
      }
   }
}
