package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.inblocks.data.OptDeviceSlotBlockVO;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import net.wg.gui.data.ImageRendererVO;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.questsWindow.data.PaddingsVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class OptDeviceSlotBlock extends BaseTooltipBlock
   {
       
      
      public var arrowUp:Sprite = null;
      
      public var plus:Sprite = null;
      
      public var overlay:UILoaderAlt = null;
      
      public var highlight:UILoaderAlt = null;
      
      public var imageLoader:UILoaderAlt = null;
      
      public var slotHighlight:Sprite = null;
      
      public var bgMc:MovieClip = null;
      
      public var slotShadow:Sprite = null;
      
      private var _slotCatsContainer:Sprite = null;
      
      private var _deviceCatsContainer:Sprite = null;
      
      private var _blockData:OptDeviceSlotBlockVO;
      
      private var _isDataApplied:Boolean = false;
      
      private var _blockWidth:int = 0;
      
      public function OptDeviceSlotBlock()
      {
         super();
         this._slotCatsContainer = new Sprite();
         addChild(this._slotCatsContainer);
         this._deviceCatsContainer = new Sprite();
         addChild(this._deviceCatsContainer);
         this.imageLoader.addEventListener(UILoaderEvent.COMPLETE,this.onImageLoaderCompleteHandler);
      }
      
      override public function cleanUp() : void
      {
         var _loc2_:Image = null;
         this.arrowUp.visible = false;
         this.plus.visible = true;
         this.slotHighlight.visible = false;
         this.slotShadow.visible = false;
         this.bgMc.gotoAndStop(1);
         this.imageLoader.unload();
         this.imageLoader.setSourceSize(this.imageLoader.originalWidth,this.imageLoader.originalHeight);
         this.highlight.unload();
         this.highlight.x = this.highlight.y = 0;
         this.highlight.setSourceSize(this.highlight.originalWidth,this.highlight.originalHeight);
         this.overlay.unload();
         this.overlay.x = this.overlay.y = 0;
         this.overlay.setSourceSize(this.overlay.originalWidth,this.overlay.originalHeight);
         var _loc1_:int = this._deviceCatsContainer.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = Image(this._deviceCatsContainer.getChildAt(_loc3_));
            _loc2_.source = Values.EMPTY_STR;
            _loc3_++;
         }
         _loc1_ = this._slotCatsContainer.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = Image(this._slotCatsContainer.getChildAt(_loc3_));
            _loc2_.source = Values.EMPTY_STR;
            _loc3_++;
         }
         super.cleanUp();
      }
      
      override public function getHeight() : Number
      {
         var _loc1_:Vector.<ImageRendererVO> = null;
         if(this._blockData)
         {
            _loc1_ = this._blockData.getSlotSpecs();
            if(_loc1_ && _loc1_.length)
            {
               return this._slotCatsContainer.y + this._slotCatsContainer.height;
            }
         }
         return this.bgMc.y + this.bgMc.height;
      }
      
      override public function getWidth() : Number
      {
         return this.bgMc.width;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._blockData = new OptDeviceSlotBlockVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         this.updateLayout();
         return false;
      }
      
      override protected function onDispose() : void
      {
         var _loc2_:Image = null;
         this.clearData();
         var _loc1_:int = this._deviceCatsContainer.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = Image(this._deviceCatsContainer.getChildAt(_loc3_));
            _loc2_.dispose();
            _loc3_++;
         }
         this._deviceCatsContainer = null;
         _loc1_ = this._slotCatsContainer.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = Image(this._slotCatsContainer.getChildAt(_loc3_));
            _loc2_.dispose();
            _loc3_++;
         }
         this._slotCatsContainer = null;
         this.imageLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onImageLoaderCompleteHandler);
         this.imageLoader.dispose();
         this.imageLoader = null;
         this.overlay.dispose();
         this.overlay = null;
         this.highlight.dispose();
         this.highlight = null;
         this.bgMc = null;
         this.slotShadow = null;
         this.slotHighlight = null;
         this.plus = null;
         this.arrowUp = null;
         super.onDispose();
      }
      
      protected function onImageLoaderComplete() : void
      {
         dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
      }
      
      private function updateLayout() : void
      {
         var _loc2_:PaddingsVO = null;
         var _loc3_:PaddingsVO = null;
         if(StringUtils.isNotEmpty(this._blockData.overlayPath))
         {
            _loc2_ = this._blockData.overlayPadding;
            if(_loc2_)
            {
               this.updateRelativePosition(this.imageLoader,this.overlay,_loc2_);
            }
         }
         if(StringUtils.isNotEmpty(this._blockData.highlightPath))
         {
            _loc3_ = this._blockData.highlightPadding;
            if(_loc3_)
            {
               this.updateRelativePosition(this.imageLoader,this.highlight,_loc3_);
            }
         }
         var _loc1_:int = this.bgMc.y + this.bgMc.height;
         this._slotCatsContainer.y = _loc1_ + this._blockData.slotSpecsOffset;
         this.arrangeSlots(this._slotCatsContainer,this._blockData.getSlotSpecs());
         this._deviceCatsContainer.y = _loc1_ + this._blockData.deviceSpecsOffset;
         this.arrangeSlots(this._deviceCatsContainer,this._blockData.getDeviceSpecs());
      }
      
      private function updateRelativePosition(param1:DisplayObject, param2:DisplayObject, param3:PaddingsVO) : void
      {
         param2.x = param1.x + param3.left;
         param2.y = param1.y + param3.top;
      }
      
      private function applyData() : void
      {
         var _loc1_:String = this._blockData.overlayPath;
         var _loc2_:Boolean = StringUtils.isNotEmpty(_loc1_);
         this.overlay.visible = _loc2_;
         if(_loc2_)
         {
            this.overlay.source = _loc1_;
         }
         _loc1_ = this._blockData.highlightPath;
         _loc2_ = StringUtils.isNotEmpty(_loc1_);
         this.highlight.visible = _loc2_;
         if(_loc2_)
         {
            this.highlight.source = _loc1_;
         }
         _loc1_ = this._blockData.imagePath;
         _loc2_ = StringUtils.isNotEmpty(_loc1_);
         this.imageLoader.visible = _loc2_;
         if(_loc2_)
         {
            this.imageLoader.source = _loc1_;
         }
         alpha = this._blockData.slotAlpha;
         this.arrowUp.visible = this._blockData.showUpArrow;
         this.plus.visible = !_loc2_;
         this.slotHighlight.visible = this._blockData.showSlotHighlight;
         this.bgMc.gotoAndStop(this._blockData.slotState);
         this.fillSlots(this._slotCatsContainer,this._blockData.getSlotSpecs());
         var _loc3_:Vector.<ImageRendererVO> = this._blockData.getDeviceSpecs();
         this.fillSlots(this._deviceCatsContainer,_loc3_);
         this.slotShadow.visible = _loc3_ && _loc3_.length;
         this._isDataApplied = true;
      }
      
      private function fillSlots(param1:Sprite, param2:Vector.<ImageRendererVO>) : void
      {
         var _loc6_:Image = null;
         var _loc7_:ImageRendererVO = null;
         var _loc3_:int = param1.numChildren;
         var _loc4_:int = Boolean(param2) ? int(param2.length) : int(0);
         var _loc5_:int = Math.max(_loc3_,_loc4_);
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_)
         {
            if(_loc3_ <= _loc8_)
            {
               _loc7_ = param2[_loc8_];
               _loc6_ = new Image();
               _loc6_.source = _loc7_.imgSrc;
               _loc6_.alpha = _loc7_.imgAlpha;
               param1.addChild(_loc6_);
            }
            else if(_loc4_ <= _loc8_)
            {
               _loc6_ = Image(param1.getChildAt(_loc8_));
               _loc6_.source = Values.EMPTY_STR;
               _loc6_.visible = false;
            }
            else
            {
               _loc7_ = param2[_loc8_];
               _loc6_ = Image(param1.getChildAt(_loc8_));
               _loc6_.source = _loc7_.imgSrc;
               _loc6_.alpha = _loc7_.imgAlpha;
            }
            _loc8_++;
         }
      }
      
      private function arrangeSlots(param1:Sprite, param2:Vector.<ImageRendererVO>) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc3_:int = Boolean(param2) ? int(param2.length) : int(0);
         var _loc5_:int = 0;
         var _loc6_:int = this._blockData.specsGap;
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            _loc4_ = param1.getChildAt(_loc7_);
            _loc4_.x = _loc5_;
            _loc5_ += _loc4_.width + _loc6_;
            _loc7_++;
         }
         if(_loc3_)
         {
            _loc5_ -= _loc6_;
         }
         param1.x = this.bgMc.width - _loc5_ >> 1;
      }
      
      private function clearData() : void
      {
         if(this._blockData != null)
         {
            this._blockData.dispose();
            this._blockData = null;
         }
      }
      
      private function onImageLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateBlock();
         this.onImageLoaderComplete();
      }
   }
}
